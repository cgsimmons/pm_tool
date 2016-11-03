class DiscussionsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    disc_params = params.require(:discussion).permit(:title, :description)
    @discussion = Discussion.new disc_params
    @discussion.project = @project

    if @discussion.save
      redirect_to project_path(@project), notice: "Discussion created successfully."
    else
      @task = Task.new
      flash[:alert] = "Error creating discussion."
      render 'projects/show'
    end
  end

  def edit
    @discussion = Discussion.find(params[:id])
    @project = @discussion.project
  end

  def update
    @discussion = Discussion.find(params[:id])
    @project = @discussion.project
    discussion_params = params.require(:discussion).permit(:title, :description)
    if @discussion.update discussion_params
      redirect_to project_path(@project), notice: "Discussion added successfully."
    else
      flash[:alert] = "Error saving task."
      render :edit
    end
  end

  def destroy
    @discussion = Discussion.find(params[:id])
    @project = @discussion.project
    @discussion.destroy
    redirect_to project_path(@project), notice: 'Discussion deleted successfully.'
  end

  def show
    @discussion = Discussion.find_by(id: params[:id])
    @project = @discussion.project
    @comment = Comment.new
  end
end
