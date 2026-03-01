---
category: "dashboard"
tags: [dashboard, dataview, author-study]
last_updated: "2026-03-01"
---
# Author Study — Dashboard

*Dataview-powered overview of author study progress.*

---

## At a Glance

```dataviewjs
const authorFiles = dv.pages('"WP-Author-Study/authors"').where(p => p.file.name === "_author");
const studyFiles  = dv.pages('"WP-Author-Study/authors"').where(p => p.type != null);

const count = (pages, s) => pages.where(p => p.status === s).length;

const fmt = (pages) =>
  `✅ ${count(pages, "complete")}  ·  🔄 ${count(pages, "in-progress")}  ·  ⬜ ${count(pages, "not-started")}  ·  **${pages.length} total**`;

const totalStudy   = studyFiles.length;
const doneStudy    = count(studyFiles, "complete");
const pct          = totalStudy > 0 ? Math.round((doneStudy / totalStudy) * 100) : 0;

dv.paragraph("**Authors** — " + fmt(authorFiles));
dv.paragraph("**Study files** — " + fmt(studyFiles));
dv.paragraph(`**Overall study completion** — ${pct}%`);
```

---

## Currently In Progress

```dataview
TABLE author AS "Author", type AS "Study Type", file.mtime AS "Last Touched"
FROM "WP-Author-Study/authors"
WHERE status = "in-progress"
SORT author ASC
```

---

## Author Overview

```dataview
TABLE author AS "Author", status AS "Status", medium AS "Medium", genre AS "Genre", created AS "Created"
FROM "WP-Author-Study/authors"
WHERE file.name = "_author"
SORT author ASC
```

---

## Coverage by Topic

How many authors have each study complete, in progress, or untouched.

```dataviewjs
const types = [
  { key: "story-study",          label: "Story Study"     },
  { key: "prose-study",          label: "Prose Study"     },
  { key: "character-study",      label: "Character Study" },
  { key: "world-building-study", label: "World Building"  },
  { key: "themes-and-motifs",    label: "Themes & Motifs" },
];

const rows = types.map(t => {
  const files      = dv.pages('"WP-Author-Study/authors"').where(p => p.type === t.key);
  const complete   = files.where(p => p.status === "complete").length;
  const inProgress = files.where(p => p.status === "in-progress").length;
  const notStarted = files.where(p => p.status === "not-started" || !p.status).length;
  return [t.label, complete, inProgress, notStarted, files.length];
});

dv.table(["Topic", "✅ Complete", "🔄 In Progress", "⬜ Not Started", "Total"], rows);
```

---

## Study Matrix

One row per author. Each column is a study type. Update the `status` field in the individual study files and this refreshes automatically.

```dataviewjs
const icon = { "complete": "✅", "in-progress": "🔄", "not-started": "⬜" };

const types = [
  { key: "story-study",          label: "Story"     },
  { key: "prose-study",          label: "Prose"     },
  { key: "character-study",      label: "Character" },
  { key: "world-building-study", label: "World"     },
  { key: "themes-and-motifs",    label: "Themes"    },
];

const authors = dv.pages('"WP-Author-Study/authors"')
  .where(p => p.file.name === "_author")
  .sort(p => p.author);

const rows = authors.map(a => {
  const cells = types.map(t => {
    const f      = dv.pages(`"WP-Author-Study/authors/${a.folder}"`).where(p => p.type === t.key).first();
    const status = f?.status ?? "not-started";
    return icon[status] ?? "⬜";
  });
  return [a.author, ...cells];
});

dv.table(["Author", ...types.map(t => t.label)], rows);
```
