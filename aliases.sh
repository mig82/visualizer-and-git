# To fire your Git client of choice or the Terminal from Visualizer's `Window>Version` Control menu option.
#git config --global --add alias.gui '!sh -c /usr/local/git/libexec/git-core/git-gui'
#git config --global --add alias.gui '!sh -c /usr/local/Cellar/git/2.16.3/libexec/git-core/git-gui'
#git config --global --add alias.gui 'open -a SourceTree .'
#git config --global --add alias.gui '/Applications/GitKraken.app/Contents/MacOS/GitKraken --path .'
git config --global --add alias.gui 'open -a Terminal .'

# To temporarily quiet down changes to specific files without altering your .gitignore.
git config --global alias.mute 'update-index --assume-unchanged'
git config --global alias.unmute 'update-index --no-assume-unchanged'

# To create a zip archive of your project.
git config --global alias.zip '!git clean -fXd && git archive --format zip -9 HEAD --output $1 && ls -lh $1'
