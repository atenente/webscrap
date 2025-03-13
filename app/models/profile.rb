class Profile < ApplicationRecord
  before_save :search_web_scrap

  def search_web_scrap
    WebScraper.call(url: 'github.com', **self.attributes.symbolize_keys)
  end
end
