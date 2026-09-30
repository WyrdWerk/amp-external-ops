// Dependency-free structural checks, not a substitute for live regression.
import assert from 'node:assert/strict'
import { existsSync, readFileSync, readdirSync } from 'node:fs'
import { dirname, join, resolve, relative } from 'node:path'
import { fileURLToPath } from 'node:url'

const root = resolve(process.argv[2] || dirname(dirname(fileURLToPath(import.meta.url))))
const name = 'amp-external-ops'
const skillPath = join(root, name, 'SKILL.md')
const skill = readFileSync(skillPath, 'utf8')
const frontmatter = skill.match(/^---\n([\s\S]*?)\n---\n/)
assert.ok(frontmatter, 'missing frontmatter')
assert.equal(frontmatter[1].match(/^name: (.+)$/m)?.[1], name, 'skill name must match directory')
const description = frontmatter[1].match(/^description: "(.+)"$/m)?.[1]
assert.ok(description && description.length <= 1024, 'description must be quoted and <=1024 characters')
assert.ok(skill.split('\n').length < 500, 'main skill must stay below 500 lines')
assert.ok(!existsSync(join(root, 'amp-thread-ops', 'SKILL.md')), 'retired loadable skill still exists')
assert.ok(frontmatter[1].includes('https://github.com/WyrdWerk/amp-external-ops'), 'wrong upstream metadata')

const history = JSON.parse(readFileSync(join(root, 'deploy', 'originals.json'), 'utf8'))
assert.equal(history.historical, true, 'legacy commands must be explicitly historical')
assert.equal(history.package, name)
assert.ok(history.warning.includes('Do not execute'))
assert.equal(Object.keys(history.originals).length, 7, 'historical templates lost')

function markdownFiles(directory) {
  return readdirSync(directory, { withFileTypes: true }).flatMap(entry => {
    if (entry.name === '.git') return []
    const path = join(directory, entry.name)
    return entry.isDirectory() ? markdownFiles(path) : entry.name.endsWith('.md') ? [path] : []
  })
}

function headings(text) {
  // GitHub-style ASCII headings used by this package; exclude fenced examples.
  const prose = text.replace(/^```[^\n]*\n[\s\S]*?^```\s*$/gm, '')
  return [...prose.matchAll(/^#{1,6}\s+(.+)$/gm)].map(match =>
    match[1].toLowerCase().replace(/[^\w\s-]/g, '').replace(/\s/g, '-'))
}

let links = 0
const files = markdownFiles(root)
for (const file of files) {
  const text = readFileSync(file, 'utf8')
  assert.ok(!text.includes('--new-thread-command'), `retired setup option in ${relative(root, file)}`)
  assert.ok(!/curl[^\n]*\|\s*(?:bash|sh)/.test(text), `unreviewed remote shell guidance in ${file}`)
  const disclosure = `public documentation disclosure in ${relative(root, file)}`
  assert.ok(!/\bT-[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\b/i.test(text), disclosure)
  assert.ok(!/\b(?:[01]\d|2[0-3]):[0-5]\d(?::[0-5]\d(?:\.\d+)?)?\b/.test(text), disclosure)
  for (const email of text.matchAll(/[a-z0-9._%+-]+@([a-z0-9.-]+\.[a-z]{2,})/gi)) {
    assert.ok(['example.com', 'example.invalid', 'users.noreply.github.com'].includes(email[1].toLowerCase()), disclosure)
  }
  for (const match of text.matchAll(/\[[^\]]*\]\(([^)]+)\)/g)) {
    const target = match[1]
    if (/^[a-z][\w+.-]*:/i.test(target)) continue
    const [path, anchor] = target.split('#')
    const destination = path ? resolve(dirname(file), decodeURIComponent(path)) : file
    assert.ok(existsSync(destination), `broken link in ${relative(root, file)}: ${target}`)
    if (anchor) {
      assert.ok(headings(readFileSync(destination, 'utf8')).includes(anchor), `broken anchor in ${file}: ${target}`)
    }
    links++
  }
}
console.log(`PASS: ${name} identity/frontmatter, ${files.length} Markdown files, ${links} local links/anchors, public-documentation privacy, retired guidance and historical metadata`)
