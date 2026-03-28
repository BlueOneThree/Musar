# MUSAR

**Unmute your creativity.**

Musar is a creative companion for musicians stuck in writer's block. Instead of generating music for you, it gives you the spark to start — a mood, a direction, reference tracks, and lyric prompts — so the song remains entirely yours.

> Musar doesn't make your song. It helps you start it. You are always the artist.

---

## What It Does

Pick a mood and genre, tap Magic, and get a musically coherent result in under 30 seconds:

- **Key** — with scale notes displayed on an interactive piano keyboard
- **BPM** — matched to the mood and reference track
- **Theme** — an evocative one-line prompt to spark your session
- **Chord Progression** — generated from the key
- **Reference Track** — a real song that matches the vibe, with album art and 30s preview

### Two Ways to Create

**Magic** — Pick a mood and genre from curated tiles, tap generate, and get instant inspiration driven by a curated database of real tracks.

**Whisper** — Type freeform text describing what you feel. Claude AI interprets it and returns the same structured result.

---

## Screenshots

*Add your screenshots here*

---

## Tech Stack

| Layer | Choice |
|-------|--------|
| UI Framework | SwiftUI |
| Architecture | MVVM |
| Local Storage | SwiftData |
| AI | Claude API (Sonnet) |
| Music Data | iTunes Search API |
| Async Networking | URLSession + async/await |

---

## Features

- 9 moods + 9 genres with code-drawn Canvas tiles
- Curated track database (~80 tracks) for musically coherent results
- AI-powered freeform input via Claude API
- Save sessions with custom labels (SwiftData persistence)
- 30s audio preview via iTunes API
- Interactive piano keyboard showing scale notes
- Dark mode with 44 colors across 4 ramps (Light / Dark / System)
- Animated gradient background
- Guest mode — no account required
- Onboarding flow (shown once)

---

## Architecture

```
Musar/
├── App/              — MusarApp.swift
├── Models/           — InspirationResult, SavedSession, CuratedTracks, MusicTheory
├── ViewModels/       — InspirationViewModel, WhisperViewModel, SavedViewModel
├── Views/
│   ├── Onboarding/   — OnboardingView, Slides, SignUpView
│   ├── Home/         — MusarView, MoodGridView, GenreGridView, all tiles
│   ├── Whisper/      — WhisperView
│   ├── Result/       — InspirationResultView, KeyDetailView, ThemeDetailView, ReferenceDetailView
│   ├── Saved/        — SavedListView, SavedCardView
│   ├── Settings/     — SettingsView
│   └── Components/   — Buttons, PianoKeyboardView, AnimatedBackground
├── Services/         — ClaudeService
├── Utilities/        — Constants, Color+Hex
└── Resources/        — Assets.xcassets (44 colors, app icon)
```

---

## Roadmap (v2)

- Spotify integration for richer reference track matching
- Share inspiration cards to Instagram / iMessage
- Mood history and analytics
- Premium tier with advanced AI lyric generation
- Full user authentication

---

## About

**Musar** = Muse + Art + Mozart

An iOS portfolio project built with SwiftUI.

By **The Blue**
