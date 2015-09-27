require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'json'

files = [
  'charts-weeks-0-500.json',
  'charts-weeks-501-1000.json',
  'charts-weeks-1001-1500.json',
  'charts-weeks-1501-2000.json',
  'charts-weeks-2001-2500.json',
  'charts-weeks-2501-2807.json'
]

file_contents = []
all_charts = []

def load_user_lib( filename )
  JSON.parse( IO.read(filename) )
end

files.each_with_index{ |fname, index| 
  week_data = load_user_lib(fname)
  week_data.each_with_index{ |chart, index|
    all_charts << chart
  }
}


f_name = "all-charts.json"
somefile = File.open(f_name, "w")
all_charts_json = all_charts.to_json
somefile.puts all_charts_json
somefile.close




