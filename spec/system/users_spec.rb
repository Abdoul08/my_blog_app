require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by :rack_test
  end
  
  describe "CRUD de l'utilisateur" do
    context 'Quand un utilisateur crée un compte' do
      it 'La création réussit' do
        visit new_user_registration_path
        fill_in 'Nom', with: 'didi'
        fill_in 'Email', with: 'didi@gmail.com'
        fill_in 'Mot de passe', with: '123456'
        fill_in 'Confirmation du mot de passe', with: '123456'
        click_on "S'inscrire"
        expect(page).to have_content 'Bienvenue ! Vous vous êtes bien enregistré(e).'
      end
    end

    context 'Quand un utilisateur modifie son profil' do
      before do
        @second_user = FactoryBot.create(:second_user)
      end
      it 'Modification réussit' do
        visit new_user_session_path
        fill_in 'Email', with: @second_user.email
        fill_in 'Mot de passe', with: @second_user.password
        click_on 'Se connecter'
        click_on 'Mon compte'
        click_link 'Modifier'
        fill_in 'Nom', with: 'dodo'
        fill_in 'Mot de passe actuel', with: '123456'
        click_on 'Modifier'
        expect(page).to have_content 'Votre compte a bien été modifié.'
        click_on 'Mon compte'
        expect(page).to have_content 'dodo'
      end
    end
    #context 'Quand un utilisateur supprime son compte' do
      #before do
        #@second_user = FactoryBot.create(:second_user)
      #end
      #it 'Suppression réussit' do
        #visit new_user_session_path
        #fill_in 'Email', with: @second_user.email
        #fill_in 'Mot de passe', with: @second_user.password
        #click_on 'Se connecter'
        #click_link 'Mon compte'
        #click_on 'Modifier'
        #click_on 'Supprimer mon compte'
        #page.accept_confirm
        #expect(page).to have_content 'Au revoir ! Votre compte a bien été supprimé. Nous espérons vous revoir bientôt.'
      #end
    #end
    context 'Quand un utilisateur visionne son compte' do
      before do
        @second_user = FactoryBot.create(:second_user)
      end
      it 'Visionnage réussit' do
        visit new_user_session_path
        fill_in 'Email', with: @second_user.email
        fill_in 'Mot de passe', with: @second_user.password
        click_on 'Se connecter'
        click_link 'Mon compte'
        expect(page).to have_content 'dada'
      end
    end
  end
  describe "Resctrictions d'accès à l'utilisateur" do
    context "Quand l'utilisateur tente d'accéder à la liste des utilisateurs réservée à l'admin" do
      before do
        @second_user = FactoryBot.create(:second_user)
      end
      it "Accès refusé" do
        visit new_user_session_path
        fill_in 'Email', with: @second_user.email
        fill_in 'Mot de passe', with: @second_user.password
        click_on 'Se connecter'
        visit users_path
        expect(page).to have_content "Seul l'admin peut accéder à cette page"
      end
    end
    context "Quand l'utilisateur tente d'accéder à la page de création des catégories réservée à l'admin" do
      before do
        @second_user = FactoryBot.create(:second_user)
      end
      it "Accès refusé" do
        visit new_user_session_path
        fill_in 'Email', with: @second_user.email
        fill_in 'Mot de passe', with: @second_user.password
        click_on 'Se connecter'
        visit new_category_path
        expect(page).to have_content "Seul l'admin peut accéder à cette page"
      end
    end
  end
  describe "Resctrictions d'accès à l'admin" do
    context "Quand l'admin tente d'accéder à la page de création d'un article réservée à l'utilisateur" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "Accès refusé" do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        visit new_article_path
        expect(page).to have_content "Page réservée aux utilisateurs"
      end
    end
    context "Quand l'admin tente d'accéder à la page Mes articles réservée à l'utilisateur" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "Accès refusé" do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        visit user_articles_path(@user)
        expect(page).to have_content "Page réservée aux utilisateurs"
      end
    end
    context "Quand l'admin accède à la liste des articles réservée et essaye de liker un article" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "Accès refusé" do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        visit user_articles_path(@user)
        expect(page).to have_content "Page réservée aux utilisateurs"
      end
    end
  end
end
