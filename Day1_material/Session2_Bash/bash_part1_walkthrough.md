# Command line and bash - Part 1

**Finding your way around**

Part of *Introduction to Bioinformatics*, day 1.
Duration: 35 minutes taught, or about 45–60 minutes if you work through it on your own.

---

## How to use this document

This walkthrough works two ways.

**If you are in the workshop**, follow along with the instructor. The grey boxes are commands to type.

**If you are working through it alone**, take your time. Type everything by hand rather than copy-pasting; the typing is part of it. Where you see a **Try it** box, stop and do it before reading on.

> **Facilitator notes** appear in boxes like this and are not needed by self-learners.

---

## What you need

- A web browser
- The practice terminal at **https://webterm.app/en/free-play**

Nothing to install, no account, no sign-up.

Open it now. You should see a terminal on one side and a **file tree panel** on the other. Both matter; we'll be looking back and forth between them constantly.

---

## Before we start: nothing here can break

This is the most important thing on the page.

You are working in a **simulated** terminal running inside your browser. It is not your computer. It cannot touch your files, your photos, or anything you care about.

**If you reload the page, everything resets to a clean start.**

That means there is no way to damage anything, no way to get so lost you can't recover, and no command you're not allowed to try. If something goes badly wrong, press F5 and start again.

Most people arrive at the command line slightly afraid of it. That fear is reasonable on a real system and completely unnecessary here. Use this hour to be reckless.

> **Facilitator note : 0-4 min.** Say the "press F5" line out loud and let it land before doing anything else.

---

## 1. Three commands that just answer questions

Let's start with commands that only *look*, and change nothing.

Type each one and press Enter.

```bash
pwd
```

```bash
ls
```

```bash
date
```

**What just happened:**

| Command | Short for | What it does |
|---|---|---|
| `pwd` | print working directory | Tells you where you currently are |
| `ls` | list | Shows what's in the current place |
| `date` | — | Tells you the date and time |

That's the whole idea of the command line: you type a short word, press Enter, and get an answer. It's a conversation, not an exam.

**Look at the tree panel now.** The folder you're "in" according to `pwd` is the same place the tree panel is showing you. Two views of one fact ; the tree is the picture, `pwd` is the sentence.

---

## 2. Your first error, on purpose

Type this deliberately wrong:

```bash
pdw
```

You'll get an error message. Read it.

The computer is not annoyed with you. It looked up `pdw` in its list of words it knows, didn't find it, and said so. That's all an error is: *"I don't know that word"* or *"I can't find that thing."*

You will produce hundreds of these. They are not failures, they're the normal texture of working in a terminal. The skill is not avoiding errors, it's reading them.

**Get into the habit now:** when something doesn't work, read the message before doing anything else. It is usually telling you exactly what's wrong.

> **Facilitator note.** Do this as a whole room at the same time. Everyone making the same mistake simultaneously removes the private shame of it. Ask someone to read the message aloud and say what they think it means.

---

## 3. Moving around

Right now you're sitting in one folder. Let's move.

The command is `cd` : **c**hange **d**irectory.

```bash
ls
```

Pick a folder you can see, and go into it. (Replace `documents` with a real folder name if that one isn't there.)

```bash
cd documents
```

Nothing much seems to happen. But now ask where you are:

```bash
pwd
```

Different answer than before. And the tree panel has moved with you.

```bash
ls
```

Different contents, because you're somewhere else.

Now go back up one level:

```bash
cd ..
```

```bash
pwd
```

`..` means **the folder above this one**. It's not a folder name : it's a shorthand that means "up".

Finally, see the whole shape of things at once:

```bash
tree
```

`tree` draws the folder structure as a diagram. Compare it to the tree panel on the side : same information.

**The mental model:** your files live in a tree of nested folders. You are always standing at exactly one point in that tree. `pwd` says where. `ls` says what's here. `cd` moves you.

> **Facilitator note — 4-10 min.** Point at the tree panel every single time someone runs `cd`. The panel is the reason to use this tool and the connection between "I typed something" and "I moved somewhere" needs to be made explicitly, repeatedly, for the first ten minutes.

---

## 4. Two keys that change everything

Before we go further : two keyboard tricks. These are not optional extras. They are the difference between the command line feeling hostile and feeling helpful.

### Tab completes what you're typing

Type this, but **don't press Enter**:

```bash
cd doc
```

Now press the **Tab** key.

The rest of the word appears by itself.

The terminal knows what folders exist. When you press Tab, it fills in the only thing that could match. If several things match, press Tab twice to see the options.

**This means you do not have to type accurately.** Type three letters, press Tab. It's faster, and more importantly it can't misspell things.

### Up-arrow brings back what you already typed

Press the **up arrow** key. Your previous command reappears. Press it again to go further back.

You can edit the line before pressing Enter. So when a long command has one character wrong, you don't retype it — you press up, fix the character, and press Enter.

**Try it:** press up until you find `pwd`, then press Enter to run it again.

---

## 5. The big idea: absolute and relative paths

This is the concept worth slowing down for. Almost everything confusing about the command line, later, traces back to this.

### Two ways to describe where something is

Imagine telling someone where a room is.

**Absolute:** *"Room 3.12, Biology Building, Norwich Research Park."*
That works whoever you are and wherever you're standing.

**Relative:** *"Two doors down on the left."*
That only works if you're standing in the right corridor. Somewhere else, it means something different — or nothing.

Paths on a computer work exactly the same way.

### The rule

> **A path starting with `/` is absolute — it starts from the very top.**
> **Anything else is relative — it starts from where you are right now.**

That single character is the whole distinction.

### See it happen

Go to the very top of the tree:

```bash
cd /
```

```bash
pwd
```

```bash
ls
```

This is the **root** — the trunk that everything else grows out of. Every absolute path starts here.

Now go to your home folder:

```bash
cd ~
```

```bash
pwd
```

`~` or empty space is a shortcut meaning **your home folder**. Note the full address `pwd` gives you, it starts with `/`, so it's absolute.

Now reach the same destination two different ways.

**Relative** : from home, step down into a folder:

```bash
cd documents
pwd
```

Go back home:

```bash
cd ~
```

**Absolute** : name the whole address at once:

```bash
cd ~/documents
pwd
```

Same place, two routes. The first only worked because you happened to be at home. The second works from anywhere.

### Three shorthands to remember

| Symbol | Means |
|---|---|
| `~` | my home folder |
| `.` | here, where I am now |
| `..` | up one level |

These combine. `../..` is up two levels. `../metadata` is "up one, then into metadata".

> **Facilitator note : 10–20 min.** Do the postal-address analogy on the board before touching the keyboard.

---

## 6. The mistake everyone makes

Let's walk into it deliberately.

Go into a folder:

```bash
cd ~/documents
pwd
```

Now, from inside it, try to go into it again:

```bash
cd documents
```

**It fails.**

Why?

Because `cd documents` is a *relative* path. It means "go into a folder called `documents` **inside where I am now**". You're already inside `documents`, and there isn't another one in there.

The instruction was fine. Your position had changed.

This is the single most common beginner stumble at the command line, and it catches people for weeks. Meeting it on purpose, in a room where nothing matters, is worth more than any amount of explanation.

**The habit that fixes it:** when a path doesn't work, run `pwd` first. Nine times out of ten you're not where you thought you were.

```bash
pwd
```

> **Facilitator note.** Ask the room *why* before explaining. 
---

## 7. Build your own project

Time to make something. We're going to build the folder structure for a small RNA-seq study : the kind of thing you'd set up before any real analysis.

Type these one at a time. Watch the tree panel after each one.

Start at home:

```bash
cd ~
```

Make the project folder:

```bash
mkdir rna_project
```

`mkdir` = **m**a**k**e **dir**ectory. Look at the tree panel — it just appeared.

Go into it:

```bash
cd rna_project
```

Make four folders in one go:

```bash
mkdir samples metadata results scripts
```

One command, four folders. `mkdir` will take as many names as you give it.

```bash
ls
```

Now go into `samples` and create some empty files:

```bash
cd samples
```

```bash
touch sample_01_R1.fastq sample_01_R2.fastq
```

```bash
touch sample_02_R1.fastq sample_02_R2.fastq
```

`touch` creates an empty file. (These are pretend, there are no actual sequencing reads inside them.)

```bash
ls
```

Now look more carefully:

```bash
ls -l
```

Same files, much more detail; sizes, dates, permissions. Don't worry about decoding all of it yet.

And see the whole thing you've built:

```bash
tree ~/rna_project
```

**You made that.** Four folders and four files, from nothing, by typing.

### A note on those filenames

`sample_01_R1.fastq` has no spaces, no capitals, no brackets, and numbers that are zero-padded. That's deliberate, and there's a reason for each choice. We'll come back to it properly in the data management session, but start noticing filenames now.

> **Facilitator note — 20–30 min.** Typed by hand, not pasted.

---

## 8. The anatomy of a command

You've now run about a dozen commands. They all have the same shape:

```
command    -options    what-to-act-on
```

For example:

```bash
ls -l ~/rna_project/samples
```

- `ls` — the **command**. What to do. Like a verb.
- `-l` — an **option**. Changes *how* it does it. Options usually start with a dash.
- `~/rna_project/samples` — the **argument**. What to do it *to*.

Options and arguments are often optional. `ls` on its own works fine, it just assumes you mean "here", in the default way.

Once you see this shape, unfamiliar commands stop looking like magic incantations and start looking like sentences.

---

## 9. Copying, moving, deleting

Three more commands. All of them act on files.

Copy a file:

```bash
cd ~/rna_project/samples
cp sample_01_R1.fastq backup_R1.fastq
ls
```

`cp` = copy. First the original, then the new name.

Rename it:

```bash
mv backup_R1.fastq old_backup.fastq
ls
```

`mv` = move. Confusingly, renaming and moving are the same operation, you're changing where a file lives, and its name is part of that.

Delete it:

```bash
ls
rm old_backup.fastq
ls
```

`rm` = remove.

### One habit, and only one

**Run `ls` before you run `rm`.**

Look at what you're about to delete, before you delete it. That's it. That habit will save you at some point.

On a real computer, `rm` does **not** use a recycle bin. Deleted means gone. That's worth knowing, and worth immediately forgetting again for the next twenty minutes, because in here you can reload the page and nothing is lost.

---

## 10. Path challenges

Two short puzzles on the project you just built. Try them before reading the answers.

**Challenge 1.** Go into `samples`. From there, get to `metadata`, **without** using `~` and without using an absolute path.

```bash
cd ~/rna_project/samples
```

<details>
<summary>Answer</summary>

```bash
cd ../metadata
```

Up one level to `rna_project`, then down into `metadata`.
</details>

**Challenge 2.** Go home. From there, list what's inside `samples` — **without moving there.**

```bash
cd ~
```

<details>
<summary>Answer</summary>

```bash
ls ~/rna_project/samples
```

You stayed at home. Check with `pwd`,  you never moved.
</details>

That second one is worth sitting with for a moment. **You can act on a place without going there.** Most commands take a path as an argument, which means you rarely need to navigate somewhere just to do one thing to it. This is a genuine unlock, and it's the point at which the command line starts being faster than clicking.

> **Facilitator note : 30–33 min.**

---

## 11. Your cheatsheet

Fill in your cheatsheet now, while it's fresh, using **your own words**.

Not my words. Yours. "Shows me what's in here" is a better note than "list directory contents", because you wrote it and you'll recognise it in three weeks.

Only write down commands you actually ran. If a command didn't stick, leave it out; you can always add it later.

### And to be completely clear

**Nobody memorises these.** Not your instructors, not the person next to you, not anyone who does this for a living. Everyone looks things up, constantly, forever.

The skill you're building is not recall. It's knowing that a command *exists* for the thing you want to do, and knowing roughly where to look. That's it. Forgetting the exact syntax is normal and permanent.

> **Facilitator note; 33–35 min.** Close with one word each round the room: *what surprised you?* 

---

## Command summary

| Command | What it does |
|---|---|
| `pwd` | Where am I? |
| `ls` | What's here? |
| `ls -l` | What's here, in detail |
| `ls -a` | What's here, including hidden files |
| `cd folder` | Go into a folder |
| `cd ..` | Go up one level |
| `cd ~` | Go home |
| `cd /` | Go to the root |
| `cd -` | Go back where I just was |
| `tree` | Draw the folder structure |
| `mkdir name` | Make a folder |
| `touch name` | Make an empty file |
| `cp old new` | Copy a file |
| `mv old new` | Move or rename a file |
| `rm name` | Delete a file |
| `date` | What's the date and time? |

| Symbol | Means |
|---|---|
| `/` at the start | Absolute path — starts from the root |
| no `/` at the start | Relative path — starts from here |
| `~` | Home folder |
| `.` | Here |
| `..` | Up one level |

| Key | Does |
|---|---|
| **Tab** | Completes what you're typing |
| **Up arrow** | Brings back your previous command |

---

## If something goes wrong

**"command not found"** — Usually a typo. Check spelling and spacing. Press up-arrow and fix the line rather than retyping.

**"No such file or directory"** — The path is wrong, or you're not where you think you are. Run `pwd`, then `ls`, then try again.

**You're completely lost** — `cd ~` takes you home from anywhere.

**Everything is broken** — Reload the page. You get a clean start. Nothing is lost that matters.

---

## What's next

**Part 2** — wildcards, looking inside files, searching with `grep`, and connecting commands together with pipes.

**Part 3** — making the computer repeat itself with loops, and writing your first script.

Before you go: **leave this browser tab open over the break.** Reloading resets everything, and you'd have to rebuild your project.

---

## Appendix: setup block for recovering your project

If you reload or close the tab and lose your work, paste this to rebuild it.

```bash
mkdir -p ~/rna_project/samples/old ~/rna_project/metadata ~/rna_project/results ~/rna_project/scripts; cd ~/rna_project/samples; touch sample_01_R1.fastq sample_01_R2.fastq sample_02_R1.fastq sample_02_R2.fastq sample_03_R1.fastq sample_03_R2.fastq control_01_R1.fastq control_01_R2.fastq old/sample_00_R1.fastq "Final data (copy 2).csv"; cd ~/rna_project; printf "RNA-seq pilot study\nContact: your name here\nRaw reads live in samples/ - do not edit them\n" > README.txt; printf "sample_id,condition,batch,rin\nsample_01,treated,A,8.1\nsample_02,treated,A,7.4\nsample_03,treated,B,6.9\ncontrol_01,control,B,8.8\n" > metadata/samplesheet.csv; printf "2024-03-01 extraction started, all four samples\n2024-03-02 sample_02 looked cloudy after elution\n2024-03-03 RIN values back from the bioanalyser\n2024-03-05 library prep, sample_02 FAILED and was repeated\n2024-03-06 sample_02 repeat looks fine\n2024-03-14 possible contamination in batch B, check control_01\n" > metadata/lab_notes.txt; cd ~
```

Check it worked:

```bash
tree ~/rna_project
```
