# Installing

## Linux

```
sudo apt-get install -y emacs git python curl silversearcher-ag
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
echo 'PATH="~/.cask/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Shared

```
cd
git clone https://github.com/ahinz/emacs-config.git
rm -rf .emacs.d
ln -s ~/emacs-config/.emacs.d .emacs.d
cd .emacs.d
cask install
```

## Remap Keys on Linux

```
setxkbmap -layout us -option ctrl:nocaps
```
