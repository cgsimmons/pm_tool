class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    @user = current_user
    @favorites = @user.favorite_projects.page(params[:page]).per(10)
  end

  def create
    project = Project.find(params[:project_id])
    favorite = Favorite.new(user: current_user, project: project)
    if cannot? :favorite, project
      redirect_to :back, alert: '‼ Access Denied ‼'
    elsif favorite.save
      redirect_to :back, notice: '❤Added to your favorites!❤'
    else
      redirect_to :back, alert: favorite.errors.full_messages.join(", ")
    end
  end

  def destroy
    favorite = Favorite.find_by(id: params[:id])
    @project = favorite.project
    if favorite.destroy
      redirect_to project_path(@project), notice: '💔Unfavorited project.💔'
    else
      redirect_to project_path(@project), alert: favorite.errors.full_messages.join(", ")
    end
  end
end
