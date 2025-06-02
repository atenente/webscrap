class Profile < ApplicationRecord
  validates :name, presence: true
  before_save :search_web_scrap

  def search_web_scrap
    params_github = WebScraper.call(url: 'github.com', name: self.name)
    self.attributes = params_github
  end
end
