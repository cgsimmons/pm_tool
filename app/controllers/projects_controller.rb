class ProjectsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    @projects = Project.order(created_at: :DESC).page(params[:page]).per(10)
  end

  def show
    @project = Project.find(params[:id])
    @task = Task.new
    @discussion = Discussion.new
    @favorite = @project.favorite_for(current_user)
  end

  def new
    @project = Project.new
  end

  def create
    project_params = params.require(:project).permit(:title, :description, :due_date)
    @project = Project.new project_params
    @project.user = current_user
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    project_params = params.require(:project).permit(:title, :description, :due_date)
    if @project.update project_params
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: "Project deleted."
  end

end
