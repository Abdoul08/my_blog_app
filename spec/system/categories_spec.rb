require 'rails_helper'

RSpec.describe "Categories", type: :system do 
  describe "CRUD des Catégories" do
    before do
      @user = FactoryBot.create(:user)
    end

    context "Quand l'admin ajoute une catégorie" do
      
      it 'Ajout réussi' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        click_on 'Nouvelle catégorie'
        fill_in 'Nom', with: 'Comédie'
        click_on 'Enregistrer'
        expect(page).to have_content 'Catégorie enregistrée'
      end
    end

    context "Quand l'admin modifie une catégorie" do
      before do
        @categorie = FactoryBot.create(:categorie)
      end
      it 'Modification réussie' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        click_on 'Liste des catégories'
        click_link 'Modifier'
        fill_in 'Nom', with: 'One man show'
        click_on 'Mise à jour'
        expect(page).to have_content 'Catégorie mise à jour'
      end
    end

    context "Quand l'admin supprime une catégorie" do
      before do
        @categorie = FactoryBot.create(:categorie)
      end
      it 'Suppression réussie' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        click_on 'Liste des catégories'
        click_link 'Supprimer'
        page.accept_confirm
        expect(page).to have_content "Catégorie supprimée"
      end
    end
  end
end
