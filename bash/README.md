[ Font ]
1) Copy 'ttf' directory into '/usr/share/fonts' (i.e. have /usr/share/fonts/ttf')
2) Run the following commands:
	a) fc-cache
	b) mkfontscale /usr/share/fonts
	c) mkfontdir /use/share/fonts

[ Change the terminal colors + Using the new font ]
--> NOTE: The below steps are for Ubuntu 12.04. In Ubuntu 16 the steps are
      identical, but the strings may differ
1) When a terminal is open, go to the top of the screen (Where the File, Edit, View
     bottoms are), and press edit->Profiles..
2) Press New, and give the new profile a name
3) Change the "Profile used when launching a new terminal" to the new profile
4) Highlight the new profile, and press 'Edit'

--> Font <-- [The 'General' window]
1) Untick "Use the system fixed width font"
2) In the "Font:" dropbox, choose 'Hack [regular]', and change the size to 11
3) Change "Cursor shape:" to 'Underline'

--> Colors <-- [The 'Colors' window]
1) Untick 'Use colors from system theme'.
2) Change "Built-in schemes:" to 'Custom'
3) Press the "Text color", in the new window press the "+" sign
4) Change the color to #93A1A1
5) Do the same for 'Background color:', but change the color to #1C1C1C
6) In 'Bold color:', tick 'Same as text color'
7) Under 'Palette', in 'Built-in schemas:', choose 'XTerm'.

[ Opening the terminal as root ]
1) Modify ~/.bashrc (Note, not root's :P) and add the following line at the end:
	echo 1 | sudo -S su 2>/dev/null && sudo su ['1' Being your password]
-> If that doesn't work, then try 'sudo su'

[ Making the root's PS a bit prettier ]
1) Open root's ~/.bashrc
2) Search for 'case "$TERM" in' (Line 31 on my bashrc), and change the line:
	xterm-color) color_prompt=yes;;
   to:
	xterm-color|xterm) color_prompt=yes;;
3) In the PS1 definition (Line 53 on my bashrc), change the '01;32m' to '00;32m'


[ Mapping CapsLock to Escape ]
Makes VIM workflow faster.
Don't forget to 'source bash_profile' to it to work :)_

Also download the following packages:
1) pygmentize
2) highlight
