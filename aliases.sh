git config --global alias.mute 'update-index --assume-unchanged'
git config --global alias.unmute 'update-index --no-assume-unchanged'
git config --global alias.zip '!git clean -fXd && git archive --format zip -9 HEAD --output $1 && ls -lh $1'
