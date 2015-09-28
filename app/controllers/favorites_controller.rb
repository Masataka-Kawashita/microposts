class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    def create
        @micropost = Micropost.find(params[:micropost_id])
        current_user.create_favorite(@micropost)
    end
    
    def destroy
    #     @micropost = current_user.favorites_relationships.find(params[:id])
    #     current_user.delete_favorite(@micropost)
        @favorite = Favorite.find(params[:id])
        @micropost = Micropost.find(@favorite.micropost_id)
        @favorite.destroy
    end
end
