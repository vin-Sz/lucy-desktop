# Drawing Lucy

Everything the app needs from her art, measured from capri-desktop 0.7.4. Check it again after big updates (new animations may appear).

## Using the templates

`templates/` has one guide PNG per animation, the same size as Capri's sheet. In Krita, layers from top to bottom:

1. Your drawing
2. Capri's sheet from `assets/sprites/` at 20–30% opacity, only for poses and timing. Don't trace her shape.
3. The template

Hide both helper layers before exporting. Export as PNG with a transparent background, named like Capri's file (`idle.png`, …), into `characters/lucy/sprites/`.

**Bigger is fine:** draw at 2× (480×768 per standing frame) if you like. Keep the same proportions and every guide scales with it.

## What the guide lines mean

| Line | Meaning | Must match? |
| --- | --- | --- |
| Gray box | One frame. Every frame in a sheet is the same size, side by side in one row | Yes |
| Red line, **feet** (standing) | Her feet touch this line (y 362 of 384) | Yes, or she floats/sinks when standing on windows |
| Red cross, **seat** (perch) | The point that sits on a window edge (115, 303 of 384×384) | Yes, or she floats/sinks when sitting |
| Cyan dashes | Center of the frame. Keep her roughly centered | Roughly |
| Blue dots | Where you can click and grab her | Roughly, can be adjusted in code |
| Orange box (idle, mouth) | Where **Capri's** mouth is | No, just a hint. Lucy's mouth goes wherever her face is |

Hair, effects or a raised arm may go outside the blue box, but stay inside the gray frame.

**Facing:** draw her facing the same way as Capri. The app mirrors her when she turns.

## The animations

Standing frames are 240×384, sitting (`perch_*`) frames are 384×384. fps = frames per second.

| File | Frames | fps | What it is | Must match |
| --- | --- | --- | --- | --- |
| `idle` | 16 | 8 | Standing still, the one you see most. Start here | Face stays in the **same spot** in every frame (the mouth is drawn on top) |
| `blink` | 4 | 8 | Blink | Frame 0–3 = idle 9–12 with eyes closing. Swapped in for those frames |
| `blink_glitch` | 4 | 8 | A "glitchy" blink. Netrunner idea: eyes/interface flashing | Same as blink |
| `mouth` | 5 | – | Mouth shapes, drawn **on top of** idle while she talks | Only the mouth, rest transparent, same spot as idle's mouth |
| `grin` | 16 | 8 | Grinning | Feet line |
| `glitch` | 10 | 15 | Capri glitching. Netrunner idea: jacking in, code over her | Feet line |
| `dangle` | 24 | 10 | Hanging while you drag her | Starts and ends close to idle |
| `sleep` | 16 | 6 | Sleeping | Feet line |
| `wake` | 13 | 15 | Waking up | Ends close to idle |
| `walk` | 12 | 12 | Walking along a window | Feet line, loops |
| `arrive` | 14 | 15 | Appearing | Ends close to idle |
| `leave` | 12 | 15 | Disappearing | Starts close to idle |
| `perch` | 16 | 8 | Sitting on a window edge | Seat point |
| `perch_blink` | 4 | 8 | Blink while sitting | Frame 0–3 = perch 9–12 with eyes closing |
| `perch_blink_glitch` | 4 | 8 | Glitchy blink while sitting | Same as perch_blink |
| `perch_glitch` | 10 | 15 | Glitch while sitting | Seat point |
| `perch_arrive` | 14 | 15 | Appearing onto a ledge | Ends close to perch |
| `perch_leave` | 12 | 15 | Disappearing from a ledge | Starts close to perch |
| `face` | 1 | – | 400×400 portrait, shown when she takes over an app | Square |

Not needed: `dance.png` and `perch_dance.png`. The app dances by reusing idle and perch.

Frame counts and fps can change: if Lucy's idle works better with 12 frames, that's one number in `app/Capri.cs` (search `new Clip(`). Write the new count here so we remember.

## Mouth shapes

| Frame | Shape | Used for |
| --- | --- | --- |
| 0 | closed | m, b, p, pauses |
| 1 | small | most consonants |
| 2 | small, a little different | i, u, y and other consonants |
| 3 | open | a, e, o |
| 4 | wide | shouted (capital) a, e, o |

Once your first idle frame exists, draw a box around her mouth on your own layer. All idle frames and all 5 mouth frames keep the mouth inside it.

## Order that makes sense

1. One `idle` frame and one `perch` frame, then test them in the app before drawing more
2. All of `idle`, then `mouth` and `blink`. With these she already works for everyday use
3. `perch` and `perch_blink`
4. `walk`, `arrive`, `leave`, `perch_arrive`, `perch_leave`
5. The rest. Any sheet you haven't drawn yet stays Capri's for now

## If she doesn't fit

Lucy is shaped differently from Capri. If her feet, seat or grab area don't line up with the guides, that's fine: the numbers live in `app/Capri.cs` (`StandY`, `SitRight`, `SitY`, `BodyRight`, `PerchedRight`) and can be changed to fit her. Then change the same numbers in `make-templates.ps1` and run it to remake the templates:

`powershell -File characters\lucy\make-templates.ps1 -Out characters\lucy\templates`
