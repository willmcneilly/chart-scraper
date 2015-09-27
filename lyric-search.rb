require 'rubygems'
require 'bundler/setup'
require 'lyricfy'

fetcher = Lyricfy::Fetcher.new


song = fetcher.search 'bobby darin', 'MULTIPLICATION'
p song
#p song.body # prints lyrics separated by '\n'
