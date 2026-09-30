import assert from 'node:assert/strict'
import { cpSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { dirname, join } from 'node:path'
import { spawnSync } from 'node:child_process'
import { fileURLToPath } from 'node:url'

const root = dirname(dirname(fileURLToPath(import.meta.url)))
const temp = mkdtempSync(join(tmpdir(), 'external-ops-validation-'))
try {
  const fixture = join(temp, 'repository')
  cpSync(root, fixture, { recursive: true, filter: path => !path.includes('/.git') })
  const run = () => spawnSync(process.execPath, [join(root, 'scripts/validate.mjs'), fixture], { encoding: 'utf8' })
  const baseline = run()
  assert.equal(baseline.status, 0, baseline.stderr)
  console.log('PASS: complete repository validates')

  const readme = join(fixture, 'README.md')
  const originalReadme = readFileSync(readme, 'utf8')
  writeFileSync(readme, `${originalReadme}\n[broken](missing-reference.md)\n`)
  const missingFile = run()
  assert.notEqual(missingFile.status, 0, 'missing relative link was accepted')
  assert.match(missingFile.stderr, /broken link/)
  writeFileSync(readme, `${originalReadme}\n[broken anchor](amp-external-ops/SKILL.md#missing-heading)\n`)
  const missingAnchor = run()
  assert.notEqual(missingAnchor.status, 0, 'missing heading was accepted')
  assert.match(missingAnchor.stderr, /broken anchor/)
  writeFileSync(readme, originalReadme)
  console.log('PASS: broken file and anchor links rejected')

  const skill = join(fixture, 'amp-external-ops/SKILL.md')
  const originalSkill = readFileSync(skill, 'utf8')
  writeFileSync(skill, originalSkill.replace('name: amp-external-ops', 'name: amp-thread-ops'))
  const wrongName = run()
  assert.notEqual(wrongName.status, 0, 'old frontmatter identity was accepted')
  assert.match(wrongName.stderr, /skill name must match directory/)
  writeFileSync(skill, `${originalSkill}\namp config external-agents update cursor --new-thread-command unsafe\n`)
  const retiredCommand = run()
  assert.notEqual(retiredCommand.status, 0, 'retired setup command was accepted')
  assert.match(retiredCommand.stderr, /retired setup option/)
  console.log('PASS: wrong skill identity and retired setup guidance rejected')
} finally {
  rmSync(temp, { recursive: true, force: true })
}
