#!/bin/sh

rm -rf "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core"
brew tap homebrew/core

git -C $(brew --repo homebrew/core) checkout master

arch -x86_64 brew install zsh ctags tmux reattach-to-user-namespace the_silver_searcher fzf macvim
$(brew --prefix)/opt/fzf/install

brew tap homebrew/cask-fonts
arch -x86_64 brew install --cask font-fira-code

arch -x86_64 brew tap heroku/brew && arch -x86_64 brew install heroku
heroku login -i
