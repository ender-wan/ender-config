
# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Setting PATH for EPD_free-7.3-2
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH

# For Nand2Tetris, The project and simulator from 
# "The Elements of Computing Systems: Building a Modern Computer from First Principles"
PATH="~/Documents/nand2tetris/tools:${PATH}"
export PATH

if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

##
# Your previous /Users/ender/.bash_profile file was backed up as /Users/ender/.bash_profile.macports-saved_2013-03-02_at_16:50:01
##

# MacPorts Installer addition on 2013-03-02_at_16:50:01: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

