# Install Script
`bin/install.rb --help`

# HAM
Copy the Pushover API token to 1Passsword.
1. Create password called "Pushover API Token"
2. Insert the API pushover_token as "password" and pushover_user as "username"

# YouCompleteMe
Plugin [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) will get installed when dotfiles are configured.
It has a compiled component in order to make the fuzzy autocomplete performant. This requires cmake and a newer
python to be installed on the machine. After that you can then install YouCompleteMe.

## Install YouCompleteMe
Follow steps laid out [here](https://github.com/Valloric/YouCompleteMe#full-installation-guide)

Note: If you get errors making the files then you might have to set the variables in the CMakeLists.txt. See [here](http://cpp-dev-talk.blogspot.com/2014/06/using-clang-with.html)
