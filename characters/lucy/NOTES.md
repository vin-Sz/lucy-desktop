# Lucy: plan and notes

Everything Lucy-specific lives in this folder, so syncing updates from capri-desktop stays easy.
The folder is named `characters/lucy` so other characters (even Capri) could sit next to her later.

## What's here

| File | What it is |
| --- | --- |
| `personality.md` | Her default personality, as plain text |
| `lines.md` | Her netrunner tags and the lines Capri says straight from the code, rewritten for Lucy |
| `sprites/` | *(later)* her animations, same file names and sizes as `assets/sprites` |
| `voice/` | *(later)* her spoken greetings |
| `icon.ico`, `icon.png` | *(later)* her icon |

## Plan

**Step 1: this folder** *(now)*
- [x] Draft her personality
- [x] Draft her lines and netrunner tags
- [ ] Try the personality in the real app (Mainframe → Settings → Edit personality) and tweak it

**Wait for the big capri-desktop patch, then sync** before changing any app code.

**Step 2: art and voice**
- [ ] Build script: build with `-Character lucy`, taking each file from this folder when it's there and Capri's otherwise, so sprites can be swapped one at a time
- [ ] Check the sprite list and sizes again after the patch (it adds new animations)
- [ ] Lucy's art, voice and icon

**Step 3: text in the app**
- [ ] A new `app/Character.cs` holding her personality and lines, with small one-line changes in `Brain.cs` pointing at it
- [ ] Update the personality fingerprints (`DefaultStamp` in `Brain.cs`, `todaysPersona` in `Capri.cs`) and any tests that check lines word for word
- [ ] Rename what you see from Capri to Lucy (window titles, menus, installer, messages), but not the internal code names

**Later, maybe**
- [ ] Netrunner look in place of Capri's glitch effects, like the crimson tendrils when she starts (`Tendrils` in `Talk.cs`)
- [ ] Choosing the character inside the app instead of when building

## Notes

- **Sprites** (capri-desktop 0.7.4): every animation is one row of frames, 384 px tall. Standing frames are 240 px wide; sitting (`perch_*`) frames are 384 px wide. Frame counts are set in `app/Capri.cs` (search `new Clip(`).
- **How the art gets in:** `ci/build-windows.ps1` packs `assets/sprites`, `assets/voice` and the icon into the .exe when building. The app doesn't read them from a folder.
- **Syncing:** commit before syncing, and sync soon after each capri-desktop release while the differences are small. If the README conflicts, keep ours.
