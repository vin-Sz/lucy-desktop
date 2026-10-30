# Lucy: plan and notes

Everything Lucy-specific lives in this folder, so syncing updates from capri-desktop stays easy.
The folder is named `characters/lucy` so other characters (even Capri) could sit next to her later.

## What's here

| File | What it is |
| --- | --- |
| `personality.md` | Her personality, as plain text in markdown. It becomes `DefaultPersonality` in `app/Brain.cs` |
| `lines.md` | Her netrunner tags and the lines Capri says straight from the code, rewritten for Lucy |
| `ART.md` | Everything her drawings must match, animation by animation |
| `templates/` | Guide images to draw on, one per animation (made by `make-templates.ps1`) |
| `sprites/` | *(later)* her animations, same file names and sizes as `assets/sprites` |
| `voice/` | *(later)* her spoken greetings |
| `icon.ico`, `icon.png` | *(later)* her icon |

## Plan

**Step 1: this folder** *(now)*
- [x] Draft her personality
- [x] Draft her lines and netrunner tags
- [ ] Try the personality in the real app and tweak it. Since 0.7.6 there's no Edit personality button, so this means pasting it into `DefaultPersonality` in `app/Brain.cs` and building

- [x] Sync the big capri-desktop patch (0.7.6, 30 Oct) before changing any app code
- [x] Sync capri-desktop 0.7.7 (30 Oct): lie-down set, perch talking frames, Halloween lines, donation lines
- [x] A GitHub Action (`.github/workflows/sync-upstream.yml`) that merges capri-desktop into `main` when it updates

**Step 2: art and voice**
- [ ] Build script: build with `-Character lucy`, taking each file from this folder when it's there and Capri's otherwise, so sprites can be swapped one at a time
- [x] Check the sprite list and sizes again after the patch: the perch is new (60 frames, narrower frames) and `perch_music` was added. `ART.md` and the templates are updated
- [x] Again for 0.7.7: `perch_talk` and seven `laydown_*` sheets (372 or 440 × 250 px). `ART.md` and the templates are updated
- [ ] Lucy's art, voice and icon

**Step 3: text in the app**
- [ ] A new `app/Character.cs` holding her personality and lines, with small one-line changes in `Brain.cs` pointing at it
- [ ] Update the personality checks in the smoke test (`Capri.cs`): `todaysPersona` (a SHA-256 of the whole prompt) and its length, 5659 since 0.7.7, next to it, and the check a little before it that looks for Capri phrases like "a playful chaos gremlin". Also any tests that check lines word for word
- [ ] Leave `Safety` and `Machinery` in `Brain.cs` as they are: Lachy asks forks to keep her safety rules. `Safety` has a little Capri wording ("your chaos lives on the screen"); decide later whether that's fine for Lucy or worth asking Lachy about
- [ ] "Hey Capri" → "Hey Lucy" (see `lines.md`)
- [ ] Rename what you see from Capri to Lucy (window titles, menus, installer, messages), but not the internal code names

**Later, maybe**
- [ ] Netrunner look in place of Capri's glitch effects, like the crimson tendrils when she starts (`Tendrils` in `Talk.cs`)
- [ ] Choosing the character inside the app instead of when building

## Notes

- **Sprites** (capri-desktop 0.7.7): every animation is one row of frames, 384 px tall except lying down (250 px). Standing frames are 240 px wide; sitting (`perch_*`) frames are 196 or 288 px wide; lying (`laydown_*`) frames are 372 or 440 px wide (see `ART.md`). Frame counts are set in `app/Capri.cs` (search `new Clip(`).
- **Personality** (since 0.7.6): there's no `personality.md` in the app and no Edit personality button any more. Her prompt is `DefaultPersonality` + `Safety` + `Machinery` in `app/Brain.cs`, all fixed in code, on Windows and on Mac/Linux.
- **How the art gets in:** `ci/build-windows.ps1` packs `assets/sprites`, `assets/voice` and the icon into the .exe when building. The app doesn't read them from a folder.
- **Syncing:** the Sync upstream Action checks capri-desktop every 6 hours and merges it into `main` on its own. If the merge conflicts (usually the README), it opens an issue instead; then merge by hand, keeping our README. After a sync, check `ART.md`, `lines.md` and this file against what changed.
- **Testing:** the smoke test (`powershell -ExecutionPolicy Bypass -File ciuild-windows.ps1 -SmokeTest -SmokeSeconds 180`) runs hundreds of checks on the real app and stops at the first failure. It's how we'll know Lucy's changes didn't break anything, but three things get in the way today (checked 30 Oct, 0.7.7):
  - On a German Windows it stops at "Crash recovery": that check looks for the English `at CapriDesktop.` in the error log, and German Windows writes `bei CapriDesktop.`. Not an app bug. Worth telling Lachy, so the fix lands upstream and not as a fork-only change that could conflict
  - The CI workflow's Windows job fails upstream too (23 of 30 runs), on GitHub's machine with no sound, mic or GPU. Turn it off under Actions → CI → ⋯ → Disable workflow (no file change, so no merge conflicts) so syncs don't send failure emails, and back on when Lucy has code of her own
  - Many checks expect Capri word for word: her personality's SHA-256 and length, her lines, sprite frame counts like `PerchBlinkFrom`. Every Lucy change to those needs its check changed in the same commit
