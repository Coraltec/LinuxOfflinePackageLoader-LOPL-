LinuxOfflinePackageLoader (LOPL)



This script simplifies the download of linux Packages and its requiered dependencies. It saves the Packages in local folder structures wich allows one to move them to another system for offline installation. In addition it creates scripts to install a selected Package or all downloaded Packages in the created folder structure at once.


The script makes use of the   apt-get install --download-only   command. Which downloads the Packages and its dependencys but not installing them on the current maschine.

**Reminder**: It only downloads the dependencies (required by the Package) which yet **NOT** installed on the current system. Dependencies which are already installed on the current System are **NOT** downloaded and therefore may miss on another vanilla offline system. So to make sure the downloaded packages work, use this script on a virgin system.




Files:
	load-package.sh - Downloads a package and its required dependencies and saves them locally
		usage: ./load-package.sh unrar -y
	
	multiload-packages.sh - Download all packages given in a text file
		usage: ./multiload-packages.sh

	Multiload-packagelist.txt - A file which holds the packagenames of the packages downloaded by multiload-packages.sh
	






This script was developed by a white male, if this is offending to you please feel free to not use it.






