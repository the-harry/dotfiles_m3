#!/bin/sh

zsh_syntax_highlighting_install() {
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting
}

asdf_install() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
}

ruby_install() {
  asdf plugin add ruby
  asdf install ruby 3.0.3
  asdf global ruby 3.0.3
}

aws_install() {
  echo $(printenv HOME) | xargs -I '{}' sed -i.bu 's,TO_BE_REPLACED,{},g' ~/.dotfiles_m3/aws_choices.xml
  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  installer -pkg AWSCLIV2.pkg \
            -target CurrentUserHomeDirectory \
            -applyChoiceChangesXML ~/.dotfiles_m3/aws_choices.xml

  sudo ln -s $(printenv HOME)/aws-cli/aws /usr/local/bin/aws
  sudo ln -s $(printenv HOME)/aws-cli/aws_completer /usr/local/bin/aws_completer

  which aws
  aws --version

  rm AWSCLIV2.pkg aws_choices.xml.bu

  curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac/session-manager-plugin.pkg" -o ~/.dotfiles_m3/session-manager-plugin.pkg
  sudo installer -pkg ~/.dotfiles_m3/session-manager-plugin.pkg -target /
  sudo ln -s /usr/local/sessionmanagerplugin/bin/session-manager-plugin /usr/local/bin/session-manager-plugin
  session-manager-plugin
  # pip install aws-mfa
}

ruby_install() {
  asdf plugin add nodejs
  # bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf install nodejs 12.16.1
  asdf global nodejs 12.16.1

  curl -o- -L https://yarnpkg.com/install.sh | bash -s && source ~/.zshrc && yarn -v
  source ~/.zshrc && yarn -v
}

setup_git_account() {
  git config --global core.editor nvim

  read -p 'Git username: ' gituser
  git config --global user.name $gituser

  read -p 'Git e-email: ' gitmail
  git config --global user.email $gitmail
}

change_wallpaper {
  osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"/Users/$USER/.dotfiles_m3/wallpaper.jpg\""
}

if [ ! -d "$HOME/.dotfiles_m3" ]
then
  echo "Installing Dotfiles"
  echo "We'll install:"
  echo "  - tmux"
  echo "  - silver searcher"
  echo "  - zsh"
  echo "  - nodejs"

  case "$(uname -s)" in
    Darwin )
      echo "  - vim (macvim)"
      echo "  - atom (mac)"

      zsh_syntax_highlighting_install
      asdf_install
      ruby_install
      node_install
      aws_install
      change_wallpaper
      ;;
    Linux)
      echo 'You are using a Linux machine which is not recommended to use with our' \
           ' dotfiles.'
      ;;
    CYGWIN* | MSYS*)
      echo 'You are using a Windows machine which is not recommended to use with our' \
           ' dotfiles.'
      echo 'You can clone our repository and try install it manually.'
      return
      ;;
    *)
      echo 'Operational system not recognized, aborting installation'
      return
      ;;
  esac
  git clone --depth=10 https://github.com/the-harry/dotfiles_m3.git "$HOME/.dotfiles_m3"
  cd "$HOME/.dotfiles_m3"

  setup_git_account

  rake install
else
  echo "Whoops... You already have these dotfiles installed."
fi
