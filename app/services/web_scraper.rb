require 'nokogiri'
require 'open-uri'

class WebScraper

  def initialize(**kwargs)
    @kwargs = kwargs
  end

  def self.call(**kwargs)
    new(**kwargs).call
  end

  def call
    run
  end

  private

  def run
    doc = Nokogiri::HTML(URI.open("https://#{@kwargs[:url]}/#{@kwargs[:name]}"))
  end
end
