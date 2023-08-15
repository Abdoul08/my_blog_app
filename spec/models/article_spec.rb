require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @categorie = FactoryBot.create(:categorie)
    @second_user = FactoryBot.create(:second_user)
  end
  describe "Test de Validation de l'article" do
    context "Si le titre de l'article est une chaîne vide" do
      it 'Validation échoue' do
        article = Article.create(title: "",categorie_id: @categorie.id,content: "Une belle maison",image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'acteur.png')),user_id: @second_user.id)
        expect(article).not_to be_valid
      end
    end

    context "Si la catégorie de l'article est une chaîne vide" do
      it 'Validation échoue' do
        article = Article.create(title: "Maison",categorie_id: "",content: "Une belle maison",image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'acteur.png')),user_id: @second_user.id)
        expect(article).not_to be_valid
      end
    end

    context "Si le contenu est une chaîne vide" do
      it 'Validation échoue' do
        article = Article.create(title: "Maison",categorie_id: @categorie.id,content: "",image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'acteur.png')),user_id: @second_user.id)
        expect(article).not_to be_valid
      end
    end

    context "Si la photo n'est pas présente" do
      it 'Validation échoue' do
        article = Article.create(title: "Maison",categorie_id: @categorie.id,content: "Une belle maison",image: nil,user_id: @second_user.id)
        expect(article).not_to be_valid
      end
    end

    context "Si tous les champs sont correctement renseignés" do
      it 'Validation échoue' do
        article = Article.create(title: "Maison",categorie_id: @categorie.id,content: "Une belle maison",image: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'acteur.png')),user_id: @second_user.id)
        expect(article).to be_valid
      end
    end

    
  end
end
