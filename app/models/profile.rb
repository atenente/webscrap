class Profile < ApplicationRecord
  before_save :search_web_scrap

  def search_web_scrap
    page = WebScraper.call(url: 'github.com', name: self.name)
    self.following = page.at('a[href$="following"] span')&.text&.strip
    self.followers = page.at('a[href$="followers"] span')&.text&.strip
    self.stars = page.at('a[href$="?tab=stars"] span')&.text&.strip
    self.repos = page.at('a[href$="?tab=repositories"] span')&.text&.strip
    self.address = page.at('li[itemprop="homeLocation"]')&.text&.strip
    self.company = page.at('li[itemprop="worksFor"]')&.text&.strip
  end
end
