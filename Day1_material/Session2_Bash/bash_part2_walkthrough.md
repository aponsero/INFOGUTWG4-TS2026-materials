# Command line and bash — Part 2

**Asking questions of your files**

Part of *Introduction to Bioinformatics*, day 1.
Duration: 80 minutes taught, or about 90–120 minutes if you work through it on your own.

---

## How to use this document

Same as Part 1. Grey boxes are commands to type. Predict what will happen before you press Enter !

> **Facilitator notes** appear in boxes like this and are not needed by self-learners.

**Before you start, you need Part 1.** This assumes you know `pwd`, `ls`, `cd`, and the difference between an absolute and a relative path. If any of that is hazy, go back, the rest of this will be frustrating otherwise.

---

## 1. Restarting and topping up

Open **https://webterm.app/en/free-play** again.

If your project from Part 1 is still there, good. Check:

```bash
tree ~/rna_project
```

If you reloaded or closed the tab, it's gone, that's expected, and it's fine.

Either way, we now need a slightly bigger project than the one you built by hand. Paste this **single line** and press Enter.

```bash
mkdir -p ~/rna_project/samples/old ~/rna_project/metadata ~/rna_project/results ~/rna_project/scripts; cd ~/rna_project/samples; touch sample_01_R1.fastq sample_01_R2.fastq sample_02_R1.fastq sample_02_R2.fastq sample_03_R1.fastq sample_03_R2.fastq control_01_R1.fastq control_01_R2.fastq old/sample_00_R1.fastq "Final data (copy 2).csv"; cd ~/rna_project; printf "RNA-seq pilot study\nContact: your name here\nRaw reads live in samples/ - do not edit them\n" > README.txt; printf "sample_id,condition,batch,rin\nsample_01,treated,A,8.1\nsample_02,treated,A,7.4\nsample_03,treated,B,6.9\ncontrol_01,control,B,8.8\n" > metadata/samplesheet.csv; printf "2024-03-01 extraction started, all four samples\n2024-03-02 sample_02 looked cloudy after elution\n2024-03-03 RIN values back from the bioanalyser\n2024-03-05 library prep, sample_02 FAILED and was repeated\n2024-03-06 sample_02 repeat looks fine\n2024-03-14 possible contamination in batch B, check control_01\n" > metadata/lab_notes.txt; cd ~
```

This is safe to run over the top of what you already built; it adds things, it doesn't remove anything you made.

Check it worked:

```bash
tree ~/rna_project
```

You should now have eight `.fastq` files in `samples/`, a folder called `old` inside it, one oddly-named `.csv`, a `README.txt`, and two files in `metadata/`.

You built the folders this morning. This just added the paperwork.

> **Facilitator note : 0–8 min.** The paste is the riskiest moment of the session with thirty people. Don't explain the block; just say it builds the rest of the pretend project. You'll come back to it at the end of Part 3.

---

## 2. Copying, moving, deleting

A quick recap, and a proper look at three commands that change things.

Go to your samples folder:

```bash
cd ~/rna_project/samples
pwd
ls
```

### Copy

```bash
cp sample_01_R1.fastq backup_R1.fastq
ls
```

`cp` takes two things: what to copy, then what to call the copy. The original stays put.

You can also copy into a different folder:

```bash
cp README.txt results/
```

That fails. Why? Look at where you are.

<details>
<summary>Answer</summary>

You're in `samples`, and there's no `README.txt` here — it's up one level in `rna_project`. Either move first, or use a path:

```bash
cp ~/rna_project/README.txt ~/rna_project/results/
```

Run `pwd` whenever a path doesn't work. Nine times out of ten you're not where you thought.
</details>

### Move and rename

```bash
mv backup_R1.fastq old_backup.fastq
ls
```

`mv` = move. Renaming and moving are the same operation — you're changing where a file lives, and its name is part of that address.

Actually move it somewhere:

```bash
mv old_backup.fastq old/
ls
ls old
```

It's gone from here and appeared in `old/`.

### Delete

```bash
ls old
rm old/old_backup.fastq
ls old
```

### One habit

**Run `ls` before you run `rm`.** Look at what you're about to delete, first.

On a real computer, `rm` has no recycle bin. Deleted is deleted. 

> **Facilitator note : 8–15 min.** These appeared briefly in Part 1; this is the proper treatment. The failed `cp` is deliberate : it's a second dose of the relative-path lesson from Part 1.

---

## 3. Wildcards: describing many files at once

You have eight `.fastq` files. Suppose you want to do something to just the forward reads. You could name all four. Or you could describe them.

```bash
cd ~/rna_project/samples
ls
```

Now:

```bash
ls *.fastq
```

`*` means **any number of any characters**. So `*.fastq` means "anything, as long as it ends in `.fastq`".

```bash
ls *_R1.fastq
```

Just the forward reads.

```bash
ls sample_*
```

Just the samples, the controls are excluded.

```bash
ls control_*
```

Just the controls.

**Try it:** before you run it, predict what `ls *_R2.fastq` will show. Then run it.

### Two more, less used

`?` means **exactly one character**:

```bash
ls sample_0?_R1.fastq
```

Square brackets mean **one character from this set**:

```bash
ls sample_0[12]_R1.fastq
```

### Wildcards work with other commands too

This is the point. Wildcards aren't part of `ls`, they're part of the shell, so they work everywhere:

```bash
cp *_R1.fastq old/
ls old
```

Four files copied in one command. That's the moment where the command line starts being faster than clicking.

Clean up:

```bash
ls old
rm old/*_R1.fastq
ls old
```

Note what you just did: `ls` first, then `rm`. That's the habit.

### The badly-named file

```bash
ls *.csv
```

There it is: `Final data (copy 2).csv`. Now try to do something with it:

```bash
cp Final data (copy 2).csv old/
```

It fails, and the error probably won't be obvious.

The problem is the **spaces**. The shell splits your command at spaces, so it thinks you asked to copy four different things called `Final`, `data`, `(copy`, and `2).csv`. To make it work you'd need quotes:

```bash
cp "Final data (copy 2).csv" old/
```

And you'd need to remember that, forever, every time you touch that file.

**This is why filenames matter.** `sample_01_R1.fastq` has no spaces, no capitals, no brackets, and zero-padded numbers. It works with wildcards, it needs no quoting, and it sorts correctly. `Final data (copy 2).csv` tells you nothing and fights you every time.

We'll come back to this properly in the data management session. For now, just notice how much friction one badly-named file creates.

Clean up:

```bash
rm old/*.csv
```

> **Facilitator note : 15–28 min.** The failed `cp` on the spaced filename is the highest-value thirty seconds in this block. Let people try it and fail before explaining. It converts filename hygiene from a rule they've been told into a problem they've felt.

---

## 4. Looking inside files

So far you've moved files around without ever seeing what's in them. Let's fix that.

```bash
cd ~/rna_project
```

### The whole file

```bash
cat README.txt
```

`cat` prints a file to the screen. It's fine for short files.

```bash
cat metadata/samplesheet.csv
```

### Just the start, or just the end

```bash
head metadata/lab_notes.txt
```

```bash
tail metadata/lab_notes.txt
```

`head` shows the first lines, `tail` the last. Both default to ten.

You can ask for a specific number:

```bash
head -3 metadata/lab_notes.txt
```

**Why this matters to you:** real sequencing files are enormous. Opening one in a text editor can hang your computer for minutes. `head` shows you the format instantly, however big the file is. It's the first thing anyone does with an unfamiliar data file.

### Counting

```bash
wc -l metadata/samplesheet.csv
```

`wc` = word count. `-l` asks for lines.

Look at the number. Now look at the file:

```bash
cat metadata/samplesheet.csv
```

The count includes the **header row**. So four samples, five lines. That off-by-one catches everyone at least once; always check whether your file has a header.

**Why this matters:** *"how many samples are in this sheet?"* just got answered without opening Excel, in a command that works the same whether there are four rows or four hundred thousand.

**Try it:** how many lines are in the lab notes?

<details>
<summary>Answer</summary>

```bash
wc -l metadata/lab_notes.txt
```
</details>

> **Facilitator note : 28–43 min.** Lead with the "why", not the commands. Wet-lab scientists have Excel and it works fine for a four-row sheet, the argument only lands when you frame it around files too big to open, which is the situation they'll actually be in. The header-row off-by-one is worth pausing on; it's a genuine source of real-world errors.

---

## Stretch break : 5 minutes

Stand up. Look at something further away than your screen.

---

## 5. grep: finding the needle

`grep` searches inside files for text. It's probably the single most useful command on this page.

```bash
cd ~/rna_project
grep "treated" metadata/samplesheet.csv
```

It printed every line containing `treated`.

That's the whole idea: **give it a word and a file, get back the lines that match.**

### Useful options

Count instead of listing:

```bash
grep -c "treated" metadata/samplesheet.csv
```

Show line numbers:

```bash
grep -n "sample_02" metadata/lab_notes.txt
```

Ignore capitals:

```bash
grep "failed" metadata/lab_notes.txt
```

```bash
grep -i "failed" metadata/lab_notes.txt
```

The first finds nothing, because the file says `FAILED`. The second finds it. **`-i` will save you constantly** — real data is inconsistent about capitals.

Invert it — show lines that *don't* match:

```bash
grep -v "treated" metadata/samplesheet.csv
```

Search a whole folder:

```bash
grep -r "sample_02" ~/rna_project
```

`-r` = recursive. It goes through every file in every subfolder. Useful when you know something is mentioned somewhere but not where.

### The lab notes mystery

Something went wrong with one of the samples. The lab notes know what.

Working with the person next to you, use `grep` to answer:

1. **Which sample had a problem?**
2. **What went wrong?**
3. **Was it fixed?**

You have everything you need. Take five minutes.

<details>
<summary>How you might have done it</summary>

Look for anything alarming:

```bash
grep -i "fail" metadata/lab_notes.txt
```

That points at `sample_02`. Now get its whole story:

```bash
grep "sample_02" metadata/lab_notes.txt
```

Three lines: it looked cloudy after elution, the library prep failed and was repeated, and the repeat was fine. Problem found, cause visible, resolved.

Three commands, and you never opened the file.
</details>

**Worth noticing:** you just did real detective work on a file you never looked at directly. On a four-line file that's a party trick. On a lab notebook covering two years and four hundred samples, it's the only way anyone finds anything.

> **Facilitator note : 48–63 min.** Deliberately a mystery, not a race, every table can solve it and nobody loses. Circulate; the common stumble is searching for `failed` in lowercase, which is exactly the `-i` lesson landing on its own. For tables who finish early: *how would you have done this in Excel?*

---

## 6. Two symbols: `|` and `>`

No new commands here. Just two ways of connecting the ones you already have, and they're what makes the command line more than a slow way to browse folders.

### `|` — send output into another command

Think of each command as a small machine that does one job. The pipe, `|`, is the conveyor belt between them: it takes what comes out of one and feeds it into the next.

You know how to find treated samples:

```bash
grep "treated" metadata/samplesheet.csv
```

And you know how to count lines:

```bash
wc -l metadata/samplesheet.csv
```

Join them:

```bash
grep "treated" metadata/samplesheet.csv | wc -l
```

*"Find the treated samples, then count them."*

Note that `wc` has no filename now — it isn't reading a file, it's reading what `grep` handed it. And this count has no header problem, because the header line doesn't contain the word `treated`.

**Try it:** how many lines in the lab notes mention `sample_02`?

<details>
<summary>Answer</summary>

```bash
grep "sample_02" metadata/lab_notes.txt | wc -l
```

Or `grep -c "sample_02" metadata/lab_notes.txt`, often there's more than one way.
</details>

### `>` — send output into a file

By default, output goes to your screen. `>` redirects it into a file instead.

```bash
grep "treated" metadata/samplesheet.csv > results/treated_samples.txt
```

Nothing appeared on screen — it went into the file. Check:

```bash
ls results
cat results/treated_samples.txt
```

**You just produced a result.** Not a temporary answer on a screen, an actual file, in the `results/` folder you made this morning, that you could send to someone.

### `>>` — add instead of replacing

One trap worth knowing: **`>` silently wipes whatever was in the file.** No warning, no confirmation.

```bash
grep "control" metadata/samplesheet.csv > results/treated_samples.txt
cat results/treated_samples.txt
```

The treated samples are gone. `>` replaced the whole file.

`>>` adds to the end instead:

```bash
grep "treated" metadata/samplesheet.csv >> results/treated_samples.txt
cat results/treated_samples.txt
```

Both sets are now there.

**Remember it as:** one arrow replaces, two arrows append.

> **Facilitator note : 63–74 min.** Build the pipe one stage at a time, running each intermediate version so people see the output change. Keep it to `grep` and `wc`, no `cut`, `sort` or `uniq`. Two ideas, well understood, beat five half-followed ones at minute 70. The `>` overwrite demo is worth doing live; losing a file in front of everyone is memorable and safe.

---

## 7. Where to find help

You now know about fifteen commands. You will forget most of them by next week. **That is completely normal**, nobody memorises this, including the people teaching you.

Here's what people actually do.

### `command --help`

A quick reminder of what the options are:

```
ls --help
grep --help
```

**This does not work in WebTerm.** It works on real computers. Don't try it here and conclude you've done something wrong.

### `man command`

The full manual. Long, thorough, sometimes dense.

```
man ls
```

Press **`q`** to get out of it. (Everyone gets stuck in `man` the first time. `q` for quit.)

**Also not available in WebTerm.**

> **Facilitator note.** Demo both live from a real terminal on your own machine, projected, thirty seconds is enough. Show `man ls`, scroll, press `q`. They need to see it exists and hear the word, so it's familiar when they meet it on a real system. If you can't project, a screenshot on a slide does most of the job.

### Search the error message

Copy the exact error, paste it into a search engine. Someone has had it before. This is a legitimate professional skill, not cheating.

### Your cheatsheet

The sheet in your hand is a real tool, not training wheels.

---

## 8. Cheatsheet

Add today's commands in **your own words**. Only the ones you actually ran.

Mark `--help` and `man` clearly as *works on a real computer, not in WebTerm* so you don't get confused later.

> **Facilitator note : 74–80 min.** this is the last thing before lunch and energy is low. One sentence each round the room if you have time: *what's the one command you'd actually use?* Then remind everyone to **leave the tab open over lunch**, though Part 3 needs much less existing state than this one did.

---

## Command summary

| Command | What it does |
|---|---|
| `cp old new` | Copy a file |
| `mv old new` | Move or rename a file |
| `rm name` | Delete a file |
| `cat file` | Print the whole file |
| `head file` | First 10 lines |
| `head -3 file` | First 3 lines |
| `tail file` | Last 10 lines |
| `wc -l file` | Count lines |
| `grep "word" file` | Show lines containing the word |
| `grep -i` | Ignore capitals |
| `grep -n` | Show line numbers |
| `grep -c` | Count matches instead of showing them |
| `grep -v` | Show lines that *don't* match |
| `grep -r "word" folder` | Search a whole folder |

| Symbol | Means |
|---|---|
| `*` | Any number of any characters |
| `?` | Exactly one character |
| `[12]` | One character from this set |
| `\|` | Send output into the next command |
| `>` | Send output into a file (**replaces it**) |
| `>>` | Send output into a file (adds to the end) |

| Lifeline | Note |
|---|---|
| `command --help` | Real computers only |
| `man command` | Full manual, `q` to quit — real computers only |
| Search the error | Always works |
| Your cheatsheet | Always works |

---

## If something goes wrong

**A command with a filename fails** : Run `pwd`. You're probably not where you think. Then `ls` to see what's actually there.

**`grep` finds nothing** : Try `-i`. The file may use different capitals than you expected.

**A filename with spaces won't work** : Put it in quotes: `"Final data (copy 2).csv"`.

**You overwrote a file with `>`** : It's gone. On a real computer that matters; here, re-run the setup block.

**Everything is broken** : Reload the page and paste the setup block from section 1.

---

## What's next

**Part 3** : making the computer repeat itself with loops, and writing your first actual script. That's also the bridge to R: same idea, different language.
