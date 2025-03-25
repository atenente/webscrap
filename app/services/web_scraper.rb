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
    page = Nokogiri::HTML(URI.open("https://#{@kwargs[:url]}/#{@kwargs[:name]}"))
    settings_page(@kwargs[:url], page)
  end

  def settings_page(site, page)
    return github(page) if site.include?('github')
  end

  def github(page)
    {
      following: page.at('a[href$="following"] span')&.text&.strip,
      followers: page.at('a[href$="followers"] span')&.text&.strip,
      stars: page.at('a[href$="?tab=stars"] span')&.text&.strip,
      repos: page.at('a[href$="?tab=repositories"] span')&.text&.strip,
      address: page.at('li[itemprop="homeLocation"]')&.text&.strip,
      company: page.at('li[itemprop="worksFor"]')&.text&.strip
    }
  end
end
