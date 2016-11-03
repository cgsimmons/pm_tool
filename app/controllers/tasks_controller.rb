class TasksController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    task_params = params.require(:task).permit(:title, :body, :due_date)
    @task = Task.new task_params
    @task.project = @project

    if @task.save
      redirect_to project_path(@project), notice: "Task added successfully."
    else
      @discussion = Discussion.new
      flash[:alert] = "Error creating task."
      render 'projects/show'
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    task_params = params.require(:task).permit(:title, :body, :due_date, :done)
    if @task.update task_params
      redirect_to project_path(@project), notice: "Task Updated."
    else
      flash[:alert] = "Error saving task."
      render :edit
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to project_path(@project), notice: 'Task deleted successfully.'
  end
end
