# WP-Author-Study

This is where I study authors I think I can learn something from, so I can get better at my own writing.

The idea is pretty simple: I pick an author, I read their work with intention, and I take structured notes on what they're actually doing beneath the surface. How do they build a story? How do they write a sentence? How do they make me care about a character? What are they really writing *about*? I want to move past just enjoying a book and start understanding the craft decisions behind it.

The goal is to build up knowledge, guideline, and opinions on how to actively write with what I’d hope would be some semblance of forethought and quality.

I'll probably do this in small sessions. A weekend here and there, a handful of authors at a time, a file or two at a sitting. There's no deadline. It's just a habit I want to build.

## Structure

```
WP-Author-Study/
├── authors/
│   └── author_name/
│       ├── _author.md              ← Start here. Who they are, what I'm studying, first impressions
│       ├── 00_story_study.md       ← Plot structure, pacing, POV, hooks, narrative arc
│       ├── 01_prose_study.md       ← Sentence rhythm, voice, dialogue, description, show/tell
│       ├── 02_character_study.md   ← Character types, arcs, voice, motivation, relationships
│       ├── 03_world_building_study.md ← World concept, systems, exposition, atmosphere
│       └── 04_themes_and_motifs.md ← What they're really writing about underneath everything
├── _templates/                     ← The master copies of all six study files
├── new-author.sh                   ← Script to spin up a new author folder
└── README.md
```

## Adding a New Author

From the repo root:

```bash
./new-author.sh "Author Name"
```

That creates the folder under `authors/` (lowercase snake_case automatically) and stamps all six files from the templates with the author's name and today's date already filled in.

```bash
./new-author.sh "Robin Hobb"
# → authors/robin_hobb/ with all 6 files ready to go
```

Don't create folders manually — the script keeps everything consistent.

## The Six Study Files

**`_author.md`** — My starting point for each author. Who they are, which works I'm drawing from, why they're on my list, and a running space for overall impressions as I go.

**`00_story_study.md`** — The macro view of how they tell a story. Structure, pacing, how they open and close chapters, POV choices, how they create tension and pull me forward.

**`01_prose_study.md`** — The sentence level. Rhythm, vocabulary, how they write dialogue, how much they describe and what they focus on, where they show and where they tell, what their voice actually sounds like.

**`02_character_study.md`** — How they build people. First impressions, distinct voices, character arcs, what drives their characters internally vs what happens to them externally, how relationships work.

**`03_world_building_study.md`** — How they build the world around the story. The premise, the systems and their rules, how they feed me information without it feeling like a lecture, how vivid the setting actually is.

**`04_themes_and_motifs.md`** — The deeper layer. What keeps coming up across their work, what they seem to actually care about, how they handle moral complexity, whether their themes are heavy-handed or subtle.

## A Note on the Templates

If I want to change the structure — add a section, reframe a heading — I edit the file in `_templates/`. That's the master copy. New authors will get the updated version; existing ones I'd have to update by hand, so it's worth thinking through changes before making them.

## Status Tracking

Each file has a `status` field in its front matter — `not-started`, `in-progress`, or `complete`. Mostly useful if I ever set up a Dataview dashboard in Obsidian to see at a glance where things stand.
