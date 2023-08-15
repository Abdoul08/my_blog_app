require 'rails_helper'

RSpec.describe "Articles", type: :system do 
  describe "CRUD des articles" do
    before do
      @second_user = FactoryBot.create(:second_user)
      @categorie = FactoryBot.create(:categorie)
    end

    context "Quand l'utilisateur ajoute un article" do
      
      it 'Ajout réussi' do
        visit new_user_session_path
        fill_in 'Email', with: @second_user.email
        fill_in 'Mot de passe', with: @second_user.password
        click_on 'Se connecter'
        click_on 'Articles'
        expect(page).to have_content 'Liste des articles'
      end
    end
  end
end