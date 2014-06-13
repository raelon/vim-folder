import os
import subprocess

# Allows for a bash command to be passed in as a string. Its stdout is returned
def bash(command):
	output = subprocess.Popen([command], shell=True,
                    stdout=subprocess.PIPE).communicate()[0]
	return output

# Register all submodules
bash("git submodule init")
bash("git submodule update")
bash("git submodule foreach git submodule init")
bash("git submodule foreach git submodule update")

# Place a symlink in for pathogen
os.symlink("vim-pathogen/autoload", "autoload")
os.symlink("vim-hybrid/colors", "colors")
os.symlink('bundles/snipmate/snippets', 'snippets')

# Get home dir and make symlinks
home = os.getenv("HOME") + '/'
os.remove(home + '.vimrc')
bash('rm -rf ' + home + '.vim')
os.symlink('./', home + '.vim')
