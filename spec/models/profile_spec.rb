require 'rails_helper'

RSpec.describe Profile do
  describe 'callbacks' do
    it 'chama WebScraper e atualiza os atributos antes de salvar' do
      fake_data = {
        company: 'Empresa X'
      }

      expect(WebScraper).to receive(:call)
        .with(url: 'github.com', name: 'fulano')
        .and_return(fake_data)

      profile = Profile.new(name: 'fulano')
      profile.save!

      expect(profile.company).to eq('Empresa X')
    end

    it 'não salva quando WebScraper retorna dados inválidos' do

      expect(WebScraper).to receive(:call)
        .with(url: 'github.com', name: 'invalido')
        .and_return({})

      profile = Profile.new(name: 'invalido')

      expect(profile.save).to be_truthy
      expect(profile.company).to be_nil
    end
  end
end
