# I am Python Developer 

### Python and minimal env setup script for Linux and OSX 

### Distros supported:

Ubuntu
OSX (requires XCode/GCC to be installed. Install command line tools via XCode->preferences to install GCC)

### Quickstart on Ubuntu

```bash
$ sudo apt install curl
$ curl -L https://raw.githubusercontent.com/Hiyorimi/i_am_new_python_developer/master/i_am_new_python_developer.sh | bash
```

### Quickstart on Mac

Assuming, you have installed [brew and git]( https://gist.github.com/derhuerst/1b15ff4652a867391f03#file-mac-md):

```bash
$ mkdir projects && cd projects && git clone https://github.com/Hiyorimi/i_am_new_python_developer.git
$ cd i_am_new_python_developer && bash i_am_new_python_developer.sh
```

### What this gives you:

* Homebrew (OSX only)*
* Python defined by .python-version
* Pyenv / pipenv
* Git*

Please note: If you are running on a super slow connection your sudo session may timeout and you'll have to enter your password again. If you're running this on an EC2 or RS instance it shouldn't be problem.


This setup script is based on Pavel Pavlenko's "I am RoR Developer" setup [script](https://github.com/pavlik/i_am_ror_developer). Thanks, Pavel!
