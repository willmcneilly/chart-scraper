require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'open-uri'
require 'json'  

# @per_page = 100
# @max_pages = 1
# @surname = 'rice'
# @census_year = "1901"

@chart_weeks = []

@end_year = 2013
@start_year = 1960
@current_year = @start_year





def url_for_page(options={})
  base_url = "http://www.officialcharts.com/archive-chart/_/1/"
  url = "#{base_url}#{@current_year}/"
  return url
end


def open_page(url)

  doc = Nokogiri::HTML(open(url))
  doc.css("table")[0].css('.entry').each do |elem|
    chart_week = {
      :year => @current_year,
      :week => elem.children[0].text,
      :date => elem.css('td.date').text,
      :url => elem.css('td.links')[0].css('a')[0]['href']
    }
    @chart_weeks << chart_week
  end
end




(@start_year..@end_year).to_a.length.times do |year|
  #break unless page <= @max_pages
  url = url_for_page()
  open_page(url)
  @current_year = @current_year + 1 
end




fname = "chart-dates.json"
somefile = File.open(fname, "w")
chart_week_json = @chart_weeks.to_json
somefile.puts chart_week_json
somefile.close


puts @chart_weeks
