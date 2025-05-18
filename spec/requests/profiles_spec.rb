require 'rails_helper'

RSpec.describe "Profiles" do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile) }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "retorna resultado de busca se houver params" do
      result = [build(:profile, name: profile.name)]
      expect(SearchService).to receive(:new).and_return(double(call: result))

      get profiles_path, params: { search_word: profile.name }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show" do
    it "retorna sucesso" do
      get profile_path(profile)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /new" do
    it "retorna sucesso" do
      get new_profile_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /edit" do
    it "retorna sucesso" do
      get edit_profile_path(profile)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    it "cria um profile válido e redireciona" do
      profile_attrs = attributes_for(:profile)

      post profiles_path, params: { profile: profile_attrs }

      created_profile = Profile.last
      expect(response).to redirect_to(profile_path(created_profile))
      follow_redirect!
      expect(response.body).to include("Profile was successfully created.")
    end

    it "não cria profile inválido" do
      post profiles_path, params: { profile: { name: "" } }
      expect(response).to have_http_status(:found)
    end
  end

  describe "PATCH /update" do
    it "atualiza profile com sucesso" do
      patch profile_path(profile), params: { profile: { name: "atenente" } }

      expect(response).to redirect_to(profile)
      follow_redirect!
      expect(response.body).to include("successfully updated")
    end

    it "não atualiza com dados inválidos" do
      patch profile_path(profile), params: { profile: { name: "" } }

      expect(response).to have_http_status(:found)
    end
  end

  describe "DELETE /destroy" do
    it "exclui o profile e redireciona" do
      expect {
        delete profile_path(profile)
      }.to change(Profile, :count).by(-1)

      expect(response).to have_http_status(:see_other)
      follow_redirect!
      expect(response.body).to include("successfully destroyed")
    end
  end
end
