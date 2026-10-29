# How the app works

A tour of capri-desktop's code, written while planning Lucy. Line numbers are from capri-desktop 0.7.4 and move with updates, so search by **name** (Ctrl+F), not by number.

## The basics

- **Language:** C#, an older version (C# 5) with Windows Forms, the classic Windows window system.
- **No project file:** `ci/build-windows.ps1` hands every `.cs` file in `app/` to the compiler that comes with Windows.
- **Classes:** code is grouped into *classes*, named bundles of data and functions. A function is called a *method*. Most of the app is one big class, `Companion`.
- **`internal` / `private`:** `internal` means other files can use it, `private` means only this class can. `const` means the value never changes.

## Which file does what

| File | What it's for |
|---|---|
| `app/Capri.cs` | **The heart.** `Program.Main` (where the app starts), `Companion` (her: the window, movement, animations, menus, glue for everything), `Updater`, plus the self-test (the huge part at the end) |
| `app/Brain.cs` | **Her mind.** Talks to the AI model (local, NVIDIA, ChatGPT, Claude…), holds her personality and memory, and `Safety`, the filter for things she won't do |
| `app/Talk.cs` | **What you see besides her:** speech bubble (`SpeechBox`), typing box (`TypeBox`), effects like the startup tendrils (`Tear`), her task panel. `Look` holds colors and fonts |
| `app/Hands.cs` | **Simple jobs:** opening apps, music, closing windows, recognizing "open Spotify" |
| `app/Computer.cs` | **Multi-step jobs** with her own cursor: looking at the screen, clicking, typing |
| `app/Voice.cs` | **Her voice:** ElevenLabs and the free Kokoro voice |
| `app/Ears.cs`, `Dictation.cs`, `Agent.cs` | **Hearing you:** mic, speech recognition, ElevenLabs voice chat. `Ears.cs` also listens for the music beat for dancing |
| `app/Mainframe.cs` | **The settings window** ("Capri Mainframe") |
| `app/Ledges.cs` | Finding window edges and icons she can sit on |
| `app/Engine.cs` | Setting up the AI model on your PC |
| `app/Setup.cs` | **The installer** (a separate small program) |
| `app/Presence.cs` | Discord status |
| `cross/` | The **Mac/Linux** version. It reuses `Brain.cs`, `Hands.cs`, `Voice.cs` and `Engine.cs` from `app/` |

## Path 1: you type "hi", she answers

1. **`TypeBox.Submit`** (Talk.cs): you press Enter. The box empties and fires its `Submitted` *event*, which is like ringing a bell for whoever is listening.
2. **`Companion.Hear`** (Capri.cs) is listening, hooked up with `typer.Submitted += Hear;`. It:
   - cuts the text at 240 characters,
   - runs `Safety.Stops`, which blocks forbidden topics right away with a canned line,
   - has no brain set up? Then it replies `Brain.Offline`,
   - otherwise starts `brain.Ask` **in the background** so she keeps animating while she thinks.
3. **`Brain.Ask`** (Brain.cs) builds the message for the AI:
   - **system message** = her personality + memory + current time (+ instructions for jobs, if those are on). Her personality comes from `personality.md` or `DefaultPersonality`.
   - **history** = your recent chat.
   - **your message**.
   - It also checks whether you're asking for a job (`Hands.Heard`, `Hands.Wants`). If so, the job runs and she replies about it.
4. **`Companion.Answer`** (Capri.cs) gets the reply. It picks a voice (ElevenLabs, free voice or silent), makes the audio in the background, then shows the bubble and plays the audio together.

So **her personality is just text sent along with every message**. The AI model does the actual "being Lucy". That's why changing the personality text is so powerful.

## Path 2: how she moves

1. **`Clip`** (Capri.cs): one animation = one sprite strip + frame count + speed. They're all listed near the top of `Companion`. For example, `new Clip("idle", 16, 8, 1.11f)` means idle.png, 16 frames, 8 frames per second.
2. **`Tick`** runs many times per second. It moves her (riding your cursor, falling, walking, sitting) and then calls `RenderFrame`.
3. **`Advance`** decides **which frame** to show: time since the clip started × fps. It also switches clips: a glitch ends → back to idle; she sits → `perch`; now and then a random blink or glitch. Lucy's netrunning frames would hook in here.
4. **`RenderFrame`** cuts the frame out of the strip and lays the **mouth** frame on top while she talks (`MouthCell`). Then it draws it all onto a transparent window.

That's why the art has to match exactly: the code finds frame 5 of idle by moving 5 × 240 px along the strip.

## Rules to know before changing code (from CONTRIBUTING.md)

- **C# 5 only:** no `$"..."` strings, `?.` or `=>` shortcuts. The built-in Windows compiler doesn't understand them. If you copy code from the internet and it fails to build, this is often why.
- **The self-test:** `build-windows.ps1 -SmokeTest` runs hundreds of checks (`checks.Add("PASS ...")`). If you change something they check, like her lines or personality, the test fails and tells you which check. That's how you'll know what else needs updating.
- **Match the code around you:** same naming and layout as the file you're in.

## Good first changes to try yourself

1. **Her pop-in lines** (`PopLines` in Capri.cs): a plain list of text. Lucy versions are in `lines.md`.
2. **The chat log name** (`Speaker = "CAPRI: "` in Talk.cs).
3. **An animation's speed:** change an fps number in the `Clip` list and watch her move faster or slower.

**Editor tip:** [VS Code](https://code.visualstudio.com) with the C# extension colors the code and lets you Ctrl+click a name to jump to where it's defined.
