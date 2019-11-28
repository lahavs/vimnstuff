Themes..


STEPS:
1) Install the theme of your choice.
   I personally use 'Arc-red-dark'
2) Install "Unity Tweak Tool" *FROM THE UBUNTU SOFTWARE CENTER* (I dunno why apt-get doesn't properly work..)
    a) If the Ubuntu Software Center freezes, then install "Lubuntu Software Center"
         and download the tool from there
3) In there, open the 'Theme' menu and choose your theme



[ Highlight focused bash tab ]
Add the gtk.css file the your *USERNAME*'s home directory (Make sure not to
  put in root's home directory, even if you log in as root. I just saved you
  10 minutes of your life trying to debug this undebugable crap.), under
  ./config/gtk-3.0/" directory
e.g. "/home/your-username/.config/gtk-3.0/gtk.css"
