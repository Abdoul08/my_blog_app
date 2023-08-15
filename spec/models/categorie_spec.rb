require 'rails_helper'

RSpec.describe Categorie, type: :model do
  describe "Test de Validation de la catégorie" do
    context "Si le nom de la catégorie est une chaîne vide" do
      it 'Validation échoue' do
        categorie = Categorie.create(name: "")
        expect(categorie).not_to be_valid
      end
    end

    context "Si le nom de la catégorie est rentrée" do
      it 'Validation réussie' do
        categorie = Categorie.create(name: "Sport")
        expect(categorie).to be_valid
      end
    end
  end
end
