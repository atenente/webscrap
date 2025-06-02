require 'rails_helper'

RSpec.describe User do
  describe "validations" do
    it "é valido com login" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "é invalido sem login" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it "não deve permitir email duplicado" do
      create(:user, email: "email@exemplo.com")
      user = build(:user, email: "email@exemplo.com")
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it "é inválido sem senha" do
      user = build(:user, password: nil, password_confirmation: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end

    it "deve ter uma senha com no mínimo 6 caracteres" do
      user = build(:user, password: "12345", password_confirmation: "12345")
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end
  end

  describe "Devise authentication" do
    it "deve autenticar com o email e senha corretos" do
      user = create(:user, email: "user@exemplo.com", password: "123456")
      expect(user.valid_password?("123456")).to be_truthy
    end

    it "não deve autenticar com senha incorreta" do
      user = create(:user, email: "user@exemplo.com", password: "123456")
      expect(user.valid_password?("12345")).to be_falsey
    end
  end
end
