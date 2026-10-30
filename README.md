# Lucy Desktop

A desktop companion of Lucy from *Cyberpunk: Edgerunners*, built on top of [capri-desktop](https://github.com/lachydotmcg/capri-desktop) by lachydotmcg.

## Why this fork exists

capri-desktop turns Capri into a desktop companion who sits on your windows, talks back, and helps out on your PC. I loved the idea but wanted Lucy instead, so this fork swaps the character out.

**Almost everything here is capri-desktop's work.** The app, the brain, voice, voice chat, PC jobs, the Mainframe, the animations system: all of that comes from the original project. This fork mainly changes:

- **Personality:** who she is and how she talks, rewritten as Lucy
- **Artwork:** new sprites, icon and images of Lucy in place of Capri
- **Small text changes:** her name and lines where you'd see them

Features of my own may come later, based on what I need. The fork stays in sync with capri-desktop, so its updates and fixes keep coming here too.

## Status

🛠️ **Planning phase.** Nothing has been changed yet. Right now this is still Capri. Next steps:

- [ ] Rewrite her default personality as Lucy
- [ ] Lucy sprites and animations
- [ ] Voice lines and icon
- [ ] Rename what you see from Capri to Lucy
- [ ] First build you can download

There's no download yet. If you want the working companion today, get [Capri](https://github.com/lachydotmcg/capri-desktop).

## Made with help from Claude

I'm using [Claude](https://claude.ai) (Anthropic's AI) to help plan this fork and to help with the code. I'm also using this project to learn: I want to understand how the app works and write parts of it myself, so some changes are mine, some are Claude's, and a lot are both.

## Credits and licence

- **Original project:** [capri-desktop](https://github.com/lachydotmcg/capri-desktop) by lachydotmcg. All credit for the app goes there. Join their [Discord](https://discord.gg/F4fDHfGtFk) for the original.
- **Capri's art and animations:** by Capri's artist, who prefers to stay private. Until Lucy's own art replaces them, the sprites here are theirs.
- **Licence:** PolyForm Noncommercial 1.0.0, same as the original. Free for anything non-commercial; no selling it or putting it in paid products. Full terms in [LICENSE.md](LICENSE.md).
- **Lucy** and *Cyberpunk: Edgerunners* belong to CD Projekt Red and Studio Trigger. This is an unofficial, non-commercial fan project, not affiliated with them.
- Font: Share Tech Mono (OFL). Free voice: Kokoro-82M (Apache-2.0). Her own ears: NVIDIA Parakeet TDT 0.6B [v2](https://huggingface.co/nvidia/parakeet-tdt-0.6b-v2) and [v3](https://huggingface.co/nvidia/parakeet-tdt-0.6b-v3) (CC-BY-4.0), run with [sherpa-onnx](https://github.com/k2-fsa/sherpa-onnx) (Apache-2.0). HD voice: [Qwen3-TTS 1.7B](https://github.com/QwenLM/Qwen3-TTS) (Apache-2.0), run with [qwentts.cpp](https://github.com/ServeurpersoCom/qwentts.cpp) (MIT).
