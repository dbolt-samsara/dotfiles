#####################################################################
#
# # --help for details
#
#####################################################################

require 'optparse'
require 'fileutils'

MAC_VOLUME = "/Volumes/Macintosh HD"
DOTFILES = "#{Dir.pwd}/dotfiles"
VIM_CONFIG = "#{Dir.pwd}/vim-config"
CONFIG_DIR = "#{Dir.pwd}/config"
SCRIPTS = "#{Dir.pwd}/scripts"
NVIM_DIR = "#{Dir.pwd}/nvim"

def main()
  options = parse_options()

  if options[:initial_dependencies]
    install_initial_dependencies
  end

  if options[:dotfiles]
    install_dotfiles
  end
end

def parse_options()
  options = {}

  opt_parser = OptionParser.new do |opt|
    opt.banner = "Usage: install.rb [OPTIONS]"

    options[:initial_dependencies] = false
    options[:dotfiles] = false
    opt.on('-d', '--dotfiles', 'Symlink dotfiles') { options[:dotfiles] = true }
    opt.on('-i', '--initial_dependencies', 'Install initial dependencies') { options[:initial_dependencies] = true }
    opt.on('-h', '--help', 'Diplay this screen') { puts opt; exit; }
  end

  opt_parser.parse!

  return options
end

def install_initial_dependencies()
  puts "Installing homebrew..."
  `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

  puts "Install neovim..."
  `brew install neovim`

  puts "Install lazygit"
  `brew install lazygit`

  puts "Install colorls"
  `sudo gem install colorls`
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
  symlink(VIM_CONFIG, "#{Dir.home}/.vim/config")

  # config directory
  if !File.directory?("#{Dir.home}/.config")
    Dir.mkdir("#{Dir.home}/.config")
  end

  # nvim 
  symlink(NVIM_DIR, "#{Dir.home}/.config/nvim")
end

def symlink(source, target)
  puts "Symlinking #{source} to #{target}"

  if File.symlink?(target)
    File.delete(target)
    puts "... File was already a symlink, deleting"
  end

  if File.exist?(target)
    backup_loc = "#{target}.bak"
    FileUtils.mv(target, backup_loc)
    puts "... File already exists, backing up to #{backup_loc}"
  end

  File.symlink(source, target)
  puts "... Installed to #{target}"
end

main
