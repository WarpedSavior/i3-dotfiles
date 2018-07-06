import os

# download audio
config.bind(",y", 'spawn youtube-dl -o "~/Downloads/youtube/%(title)s.%(ext)s" -x {url}')

# download video
config.bind(",Y", 'spawn youtube-dl -o "~/Downloads/youtube/%(title)s.%(ext)s" {url}')

# video to mpv
#config.bind("e", 'spawn mpv {url}')
config.bind(",e", 'spawn --userscript view_in_mpv')
#config.bind(",e", 'spawn --userscript blackout-yt')
#config.bind("E", 'hint links spawn mpv {hint-url}')

# search and translate selected text
config.bind(",f", 'open {primary}')
config.bind(",F", 'open --tab {primary}')
config.bind(",t", 'open --tab https://translate.google.com/#auto/es/{primary}')

# searcg engines
c.url.searchengines = {
    "DEFAULT": 'https://duckduckgo.com/?q={}',
    "r": 'https://old.reddit.com/r/{}',
    "w": 'https://en.wikipedia.org/wiki/={}',
    "y": 'https://www.youtube.com/results?search_query={}',
    "aw": 'https://wiki.archlinux.org/?search={}',
    "g": 'https://www.google.com/search?hl=en&q={}',
    "ga": 'https://fireemblem.gamepress.gg/hero/{}'
}

# editor
#c.editor.command = [os.getenv('TERMINAL'), '-e', os.getenv('EDITOR'), '{}']
c.editor.command = ['urxvt', '-e', 'vim', '-S', '/home/jos/.config/qutebrowser/editor.vimrc', '{}']

# dont store cookies
#c.content.cookies.store = False

# remove finished downloads (in milliseconds)
#c.downloads.remove_finished = 1000

# use rapid hints to make a playlist that is played in mpv when <Escape> is
# pressed to exit hints mode
config.bind(",V", 'hint --rapid links userscript mpv-playlist')

# custom blocked hosts
c.content.host_blocking.lists.append( str(config.configdir) + "/blockedHosts")
