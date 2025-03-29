class Profile < ApplicationRecord
  before_save :search_web_scrap

  def search_web_scrap
    params_github = WebScraper.call(url: 'github.com', name: self.name)
    self.following = params_github[:following]
    self.followers = params_github[:followers]
    self.stars = params_github[:stars]
    self.repos = params_github[:repos]
    self.address = params_github[:address]
    self.company = params_github[:company]
  end
end
