#####################################################################
#
# # --help for details
#
#####################################################################

require 'optparse'
require 'fileutils'

MAC_VOLUME = "/Volumes/Macintosh HD"
DOTFILES = "#{Dir.pwd}/dotfiles"
VIM_AFTER = "#{Dir.pwd}/vim-after"
VIM_CONFIG = "#{Dir.pwd}/vim-config"
FTPLUGIN_CONFIG = "#{Dir.pwd}/ftplugin"
CONFIG_DIR = "#{Dir.pwd}/config"
ZSH_DIR = "#{Dir.pwd}/zsh"
TMUXINATOR_DIR = "#{Dir.pwd}/tmuxinator"
SCRIPTS = "#{Dir.pwd}/scripts"
AWS_DIR = "#{Dir.pwd}/aws"

def main()
  options = parse_options()

  if options[:initial_dependencies]
    install_initial_dependencies
  end

  if options[:dotfiles]
    install_dotfiles
  end

  if options[:vim_plugins]
    install_vim_plugins
  end
end

def parse_options()
  options = {}

  opt_parser = OptionParser.new do |opt|
    opt.banner = "Usage: install.rb [OPTIONS]"

    options[:initial_dependencies] = false
    options[:dotfiles] = false
    options[:vim_plugins] = false
    opt.on('-d', '--dotfiles', 'Symlink dotfiles') { options[:dotfiles] = true }
    opt.on('-i', '--initial_dependencies', 'Install initial dependencies') { options[:initial_dependencies] = true }
    opt.on('-v', '--vim-plugins', 'Install VIM Plugins') { options[:vim_plugins] = true }
    opt.on('-h', '--help', 'Diplay this screen') { puts opt; exit; }
  end

  opt_parser.parse!

  return options
end

def install_initial_dependencies()
  puts "Installing flake8"
  `pip install flake8`

  puts "Installing coreutils..."
  `brew install coreutils`

  puts "Installing tmux..."
  `brew install tmux`

  # Allows copying within tmux to system clipboard
  puts "Installing tmux addon..."
  `brew install reattach-to-user-namespace`

  puts "Installing tmuxinator..."
  `brew install tmuxinator`

  puts "Intalling github cli..."
  `brew install gh`
end

def install_dotfiles()
  puts "Symlinking dotfiles..."
  Dir.foreach(DOTFILES) do |file|
    if File.file?("#{DOTFILES}/#{file}")
      symlink("#{DOTFILES}/#{file}", "#{Dir.home}/.#{file}")
    end
  end

  # scripts
  if !File.directory?("#{Dir.home}/bin")
    Dir.mkdir("#{Dir.home}/bin")
  end
  Dir.foreach(SCRIPTS) do |file|
    if File.file?("#{SCRIPTS}/#{file}")
      symlink("#{SCRIPTS}/#{file}", "#{Dir.home}/bin/#{file}")
    end
  end

  # Vim config
  if !File.directory?("#{Dir.home}/.vim")
    Dir.mkdir("#{Dir.home}/.vim")
  end
  symlink(VIM_AFTER, "#{Dir.home}/.vim/after")
  symlink(VIM_CONFIG, "#{Dir.home}/.vim/config")
  symlink(FTPLUGIN_CONFIG, "#{Dir.home}/.vim/ftplugin")

  # Zsh config
  symlink(ZSH_DIR, "#{Dir.home}/.zsh")

  # config directory
  if !File.directory?("#{Dir.home}/.config")
    Dir.mkdir("#{Dir.home}/.config")
  end
  Dir.foreach(CONFIG_DIR) do |file|
    if File.file?("#{CONFIG_DIR}/#{file}")
      symlink("#{CONFIG_DIR}/#{file}", "#{Dir.home}/.config/#{file}")
    end
  end

  # Persistent undo
  if !File.directory?("#{Dir.home}/.vim/undodir")
    Dir.mkdir("#{Dir.home}/.vim/undodir")
  end

  # Create swapfile directory
  if !File.directory?("#{Dir.home}/.vim/swapfiles")
    Dir.mkdir("#{Dir.home}/.vim/swapfiles")
  end

  # Tmuxinator
  symlink(TMUXINATOR_DIR, "#{Dir.home}/.tmuxinator")

  # AWS directory
  if !File.directory?("#{Dir.home}/.aws")
    Dir.mkdir("#{Dir.home}/.aws")
  end
  Dir.foreach(AWS_DIR) do |file|
    if File.file?("#{AWS_DIR}/#{file}")
      symlink("#{AWS_DIR}/#{file}", "#{Dir.home}/.aws/#{file}")
    end
  end


end

def symlink(source, target)
  puts "Symlinking #{source} to #{target}"

  if File.symlink?(target)
    File.delete(target)
    puts "... File was already a symlink, deleting"
  end

  if File.exists?(target)
    backup_loc = "#{target}.bak"
    FileUtils.mv(target, backup_loc)
    puts "... File already exists, backing up to #{backup_loc}"
  end

  File.symlink(source, target)
  puts "... Installed to #{target}"
end

def install_vim_plugins()
  puts "Installing AG..."
  `brew install ag`

  puts "Installing CMake. Dependency of YouCompleteMe..."
  `brew install cmake`

  puts "Installing YouCompleteMe..."
  `python ~/.vim/bundle/YouCompleteMe/install.py --ts-completer --rust-completer --go-completer`

  puts "Installing ctags..."
  `brew install ctags`
end

main
