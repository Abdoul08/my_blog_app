class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_required, except: %i[ index ]
    before_action :set_categorie, only: [:destroy,  :edit, :update]

    def index
      @categories = Categorie.all
    end
  
    def show
    end
  
    def new
      @categorie = Categorie.new
    end
  
    def create
      @categorie = Categorie.new(categorie_params)
      if @categorie.save
        redirect_to categories_path, notice: 'Catégorie enregistrée'
      else
        render 'new'
      end
    end
  
    def edit
      @categorie 
    end
  
    def update
      if @categorie.update(categorie_params)
        redirect_to categories_path, notice: 'Catégorie mise à jour'
      else
        render 'edit'
      end
    end
  
    def destroy
      @categorie.destroy
      redirect_to categories_path, notice: 'Catégorie supprimée'
    end
  
    private

    def set_categorie
        @categorie = Categorie.find(params[:id])
    end
  
    def categorie_params
      params.require(:categorie).permit(:name)
    end

    def admin_required
        unless current_user.admin?
            flash[:alert] = "Seul l'admin peut accéder à cette page"
            redirect_to root_path
        end
    end
end
  