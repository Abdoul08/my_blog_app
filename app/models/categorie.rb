class Categorie < ApplicationRecord
    validates :name, presence: true
    has_many :articles

    def to_s
        name # Utilisez l'attribut de la catégorie que vous souhaitez afficher
    end
end
