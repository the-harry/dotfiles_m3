#!/bin/sh

asdf_install() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
}

ruby_install() {
  asdf plugin add ruby
  asdf install ruby 2.7.1
  asdf global ruby 2.7.1
}

setup_git_account() {
  git config --global core.editor vim

  read -p 'Git username: ' gituser
  git config --global user.name $gituser

  read -p 'Git e-email: ' gitmail
  git config --global user.email $gitmail
}

if [ ! -d "$HOME/.dotfiles" ]
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

      asdf_install
      ruby_install
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
  git clone --depth=10 https://github.com/the-harry/dotfiles_m2.git "$HOME/.dotfiles_m2"
  cd "$HOME/.dotfiles_m2"

  setup_git_account

  rake install
else
  echo "Whoops... You already have these dotfiles installed."
fi
