# RStudio integration with Git and publishing your code in GitHub

*Third INFOGUT Training School, 28–30 September 2026 organized at IMDEA Nutrition Institute, Madrid, Spain*

To make our code available for other researchers, including possible collaborators and reviewers, we should publish it in a repository. To do this,

RStudio has excellent, built-in Git integration that simplifies this process.

### 1. The Pre-Requisites (Set Up Once)

Before writing any code, we must configure the system. This is often where beginners get stuck.

1.  Install Git & Create an account on GitHub

    - Download [Git](https://git-scm.com/install/) and sign up on [GitHub](https://github.com/).

2.  Introduce Yourself to Git

    - Run these lines in the RStudio Terminal (not the R Console) to link your local machine to your GitHub identity:

```         
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com" 
```

3.  Authentication: GitHub no longer accepts account passwords for Git operations. Thus, we need to generate a Personal Access Token (PAT)

    - Run these lines in the RStudio R Console to create and save the PAT:

```         
install.packages("usethis")
usethis::create_github_token() # Opens GitHub to create a token
# Copy the token, then run:
credentials::set_github_pat() # Pastes and saves the token securely
```

4.  From the Tools menu, click Global Options \> Git/SVN tab \> Enable version control interface for RStudio projects

5.  If necessary, enter the path for the Git executable where provided. In Windows, this is often "C:/Program Files/Git/bin/git.exe". A SSH key can be created or added for SSH if necessary. For further info you can see <https://docs.posit.co/ide/user/ide/guide/tools/version-control.html>

### 2. Best Practice: Always Use RStudio Projects

Never push loose files from the desktop. We can use RStudio Projects (.Rproj), which isolate the working directory and make paths relative.

1.  Go to File \> New Project \> New Directory \> New Project. This creates a dedicated folder with an .Rproj file

2.  To initialize Git, choose from the right hand upper corner the name of the project \> Project Options \> Git/SVN \> Version control system "Git"

3.  RStudio will need to reboot, and you should then have git enabled.

You can now find a "Git" tab in the top-right pane of RStudio

### 3. The .gitignore File (Do This Before Pushing!)

Not everything in the project folder belongs on GitHub. RStudio automatically generates a .gitignore file, which tells Git what not to update in the GitHub repository. For data analysis, this must be modified.

- Open .gitignore and add lines to block raw data files and local history:

```         
.Rhistory 
.RData 
.Ruser/ 
data/
```

Note that we have blocked the whole "data" folder. Instead of this, we could also just block \*.csv or other file types. This alternative would preserve the folder structure on GitHub.

- Code lives on GitHub; data lives on your secure local machine or cloud storage.

### 4. The First R Script & Relative Paths

Let's create our first script (e.g., analysis.R).

- Never use absolute file paths like setwd("C:/Users/Name/Documents/Data"). If another person downloads the repository, that path will break.
- Rather use relative paths that start from the project root, like "data/". This will enable someone else to load the relevant data files and put them in a correct place to be accessed. This can be done e.g., as a shared data.zip.

Open a new .R file and save it with the name "analysis.R" and the following content:

```         
# This example script loads in the acid measurement data and prints its contents, then its row and column names
acids <- read.csv("data/acids.csv", check.names = FALSE)
str(acids)
head(rownames(acids))
head(colnames(acids))
```

Remember, that well written code also includes inline comments which inform the user on what different parts of the code are for.

### 5. The Git Workflow in RStudio 

We first need to initialize a new repository from RStudio. There is a simple command for this, which we need to run in the Console:

```
usethis::use_github()
```

We can utilize the RStudio's visual Git Tab to update the contents of our repository on GitHub:

1.  Save: Save your files locally.
2.  Stage: Open the Git tab, click the checkboxes next to .gitignore, the .Rproj file, and analysis.R.
3.  Commit: Click the "Commit" button. Write a short, descriptive message in the box on the right side (e.g., "initial commit: add data loading script"). Click the "Commit" button.
4.  Push: Click the green "Push" arrow. Close both windows.

(Save \> Stage \> Commit \> Push)

This workflow should also work in the future. Everything that's inside your project's working directory can be uploaded easily like this to GitHub.

### 6. Documenting the contents of the repository with a README

The repository is incomplete without giving context to the people trying to understand how your codebase is structured. We also need to create a README.md file in the project root. It should briefly explain:

- What is this repository for?
- It can be a program or a tool, or in our case, data analysis code for a project. Provide context to the user.
- How to use the code or the tool? If you are describing a program, you need to tell the user how they can install and use it. If the repository is for analysing data, you need to tell what the different code files do and how the repository is organized. Where can the raw data be found?

Create a new empty text file with the following contents:

```         
This repository was made to learn about RStudio integration with Git and GitHub in the Third INFOGUT Training School, 28–30 September 2026 organized at IMDEA Nutrition Institute, Madrid, Spain.

The file "analysis.R" includes code to read in the acid measurement data, and to display its contents.

The raw data files are not included in this repository, but should be placed in a folder named "data" placed at the root.
```

### 7. Adding a license

Licenses are important, when sharing your code in an online repository. They are legal documents with which you define how other people can use (or not use) your code. Let's watch the following videos. <https://www.youtube.com/watch?v=nFU8KoSgEmk> Open Source Software and licenses <https://www.youtube.com/watch?v=srVPLrmlBJY> Creative Commons

For this excercise, we'll use the MIT license, which can be conveniently added directly from a template on the GitHub page.

1.  Go to the front page of your project and click "Add file" \> "Create new file"
2.  Type "LICENSE" in the box right under the menu bar (the file name). A new button appears below!
3.  Click on the "Choose a license template"
4.  Select "MIT License" on the bar on the left side
5.  Read and understand the terms of the license (!)
6.  Check the details on the right: if the current year and the user name / your full name are to your liking, click on the "Review and submit".
7.  Click on the "Commit changes" button.

Now, since we added this file directly from the GitHub web interface, it's not included in our local repository.

The conflict in the repository contents online and locally can be easily resolved by "pulling" the updated content from GitHub in your RStudio Git Tab.

If you have not pulled the contents of the online repository, you can't push your local updates back!

All done!
