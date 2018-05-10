# i3-dotfiles

repo containing my config files for the i3 window manager.

```
 bash       -> bash settings, aliases, etc.
 dunst      -> daemon notification config
 i3         -> i3 tiling window manager config
 music      -> contains the configuration for mpd and ncmpcpp
 neofetch   -> to view your system info
 polybar    -> status bars
 scripts    -> include some useful scripts
 vim        -> vim configuration
 x11        -> x11 settings
```

I'm using [GNU Stow](https://www.gnu.org/software/stow/) to manage my files comfortably.

To install the dotfiles, first clone the repository:

    git clone https://github.com/WarpedSavior/i3-dotfiles.git

Now let's use GNU Stow to copy the configuration:

```bash
# Change to the right direcotry
cd i3-dotfiles

# To install the polybar config
stow polybar

# To remove the polybar config
stow -D polybar
```
