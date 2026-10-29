# Lucy's lines

Lines Capri says that are written straight into the code, with a Lucy version for each.
Draft: the app doesn't use this file yet. Locations are from capri-desktop 0.7.4 and may move after an update.

## Netrunner tags (replace [SIGNAL CORRUPTED])

- [ICE DETECTED]
- [CONNECTION LOST]
- [DAEMON INTERRUPT]
- [NET DROPOUT]
- [TRACE BLOCKED]

## When something fails or she turns a request down

| Where | Capri | Lucy |
| --- | --- | --- |
| `Brain.cs` `Declined` | [SIGNAL CORRUPTED] Lost that one in the static. Ask me something else? | [CONNECTION LOST] Dropped that one somewhere in the Net. Ask me something else? |
| `Brain.cs` (about line 1298) | [SIGNAL CORRUPTED] Something in my head just sparked. Try me again? | [DAEMON INTERRUPT] Something got in my head for a second. Try me again? |
| `Brain.cs` `Safety.Deflect` | [SIGNAL CORRUPTED] Lost that thought somewhere in the subnet. Try me again? | [NET DROPOUT] Lost that thought in the subnet. Try me again? |
| `Brain.cs` `Safety.Refusals` | Nope. Not running that program, choom. Ask me something else. | Not running that program, choom. Ask me something else. |
| | [SIGNAL CORRUPTED] ...yeah, I'm not touching that one. Next question. | [ICE DETECTED] ...not touching that one. Next question. |
| | Hard pass. Even Arasaka had better ideas than that. | No. Even Arasaka had better ideas than that. |
| `Brain.cs` `Safety.Careful` | Nope. Your real-life hardware doesn't respawn, choom. Stay safe and pick something on-screen. | No. Your real-life hardware doesn't respawn, choom. Stay safe and pick something on-screen. |
| | Hard pass. Real bodies don't respawn, choom. Let's cause chaos on your desktop instead. | Not happening. Real bodies don't respawn. Let's cause trouble on your desktop instead. |
| | [SIGNAL CORRUPTED] ...not happening. I like you un-flatlined. Ask me something else. | [TRACE BLOCKED] ...no. I've lost enough people. Ask me something else. |
| `Brain.cs` `Safety.HelpLine` | Hey. Dropping the act for a sec: please talk to someone you trust right now, or find a free helpline at findahelpline.com. I want you around, choom. | Hey. No jokes for a sec: please talk to someone you trust right now, or find a free helpline at findahelpline.com. I want you around, choom. |

## When she pops in to check on you (`Capri.cs` `PopLines`)

| Capri | Lucy |
| --- | --- |
| Boo. Just checking on you. | Just checking on you. |
| Hi! Don't mind me. | Don't mind me. |
| Peekaboo. | Found you. |
| Miss me? I missed you. | Miss me? ...Don't answer that. |
| Hey, you. Having fun? | Hey. Having fun? |
| Surprise. I got bored without you. | Got quiet without you. |

## Other things to check later

- `Talk.cs` `Speaker = "CAPRI: "` (twice): the name shown in her chat log → `LUCY: `
- `assets/voice/hello-morning.wav`, `hello-late.wav`, `hello-miss.wav`: her spoken greetings, need new recordings or removing
- `Hands.cs` `MoonSong` is already "I Really Want to Stay at Your House". It fits Lucy perfectly, keep it
- The tests check some of these lines word for word, so changing a line also means changing its test
