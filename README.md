# vis-git
Tips and tricks to use Git with Kony Visualizer projects.

# Removing Noise

Once you've commited your Visualizer project to your repository for the first time there are a number of files you can safely ignore thereafter. You can't ignore them from the start and not push them to your repo because Visualizer can't re-create them if they're missing. So checking out your project from the repo and trying to open it with Vis will fail. This means **these files must be a part of your repo**. However Visualizer has an annoying habit of modifying these files every time the project is opened, other files are changed or the project is built, and so these appear as changes when you run `git status` and so you'll get a lot of "noise" when determining which changes to commit. So, to ignore these files after they've been pushed to your repo for the first time use:

    git update-index --assume-unchanged <file>

For convenience you can just copy and execute these lines:

    git update-index --assume-unchanged projectProperties.json
    git update-index --assume-unchanged context.properties
    git update-index --assume-unchanged defaults/defaults.properties
    
