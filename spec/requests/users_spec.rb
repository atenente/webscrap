require 'rails_helper'

RSpec.describe "Users" do
  describe "GET /users/sign_in" do
    it "retorna sucesso na tela de login" do
      get new_user_session_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users/sign_in" do
    let(:user) { create(:user) }

    it "loga com credenciais válidas" do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include(I18n.t("devise.sessions.signed_in"))
    end

    it "não loga com credenciais inválidas" do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: "123"
        }
      }

      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "DELETE /users/sign_out" do
    let(:user) { create(:user) }
    it "faz logout com sucesso depois deleta" do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }

      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
    end
  end
end
