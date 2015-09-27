require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'open-uri'
require 'json'

@charts = []

@lower_limit = 2501
@upper_limit = 2807

def url_for_page(options={})
  base_url = "http://www.officialcharts.com"
  url = "#{base_url}#{@week_url}"
  return url
end

def open_page(url)
  chart_entries = []
  doc = Nokogiri::HTML(open(url))
  doc.css("table")[0].css('.entry').each do |elem|
    chart_entry = {
      :position => elem.children[0].text,
      :last_position => elem.css('.lastposition').text,
      :weeks => elem.css('.weeks').text,
      :artist => elem.css('.info').css('h4').text,
      :song => elem.css('.info').css('h3').text,
      :img_url => elem.css('.info').css('.coverImage'),
    }
    chart_entries << chart_entry
  end
  chart_entries
end

def load_user_lib( filename )
  JSON.parse( IO.read(filename) )
end

week_data = load_user_lib("chart-dates.json")


week_data = week_data[@lower_limit..@upper_limit]



week_data.each_with_index{ |week, index|
  chart_week = {
    :date => week['date'],
    :week => week['week'],
    :year => week['year'],
    :url => week['url'],
  }
  @week_url = week['url']
  url = url_for_page()
  chart_entries = open_page(url)
  chart_week['entries'] = chart_entries
  @charts << chart_week
  p index
  rand_num = 1 + Random.rand(4)
  sleep(rand_num.round(1))
}

fname = "charts-weeks-#{@lower_limit}-#{@upper_limit}.json"
somefile = File.open(fname, "w")
chart_week_json = @charts.to_json
somefile.puts chart_week_json
somefile.close

p chart_week_json
