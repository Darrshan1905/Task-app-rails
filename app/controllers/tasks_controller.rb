class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: [:new, :create, :destroy, :edit, :update]
    
    def new
        @task = Task.new
    end
    
    def create
        @project = Project.find(params[:project_id])
        @task = @project.tasks.new(task_params)

        if @task.save
            redirect_to project_path(@project)
        else
            render 'new'
        end
    end

    def destroy
        @project = Project.find(params[:project_id])
        @task = @project.tasks.find(params[:id])
        @task.destroy
        redirect_to project_path(@project)
    end

    def edit
        @project = Project.find(params[:project_id])
        @task = @project.tasks.find(params[:id])
    end

    def update
        @project = Project.find(params[:project_id])
        @task = @project.tasks.find(params[:id])

        if @task.update(task_params)
            redirect_to project_path(@project)
        else
            render 'edit'
        end
    end

    def correct_user
        @project = current_user.projects.find_by(id: params[:project_id])
        @current_project = Project.find(params[:project_id])
        redirect_to project_path(@current_project), alert: "Not authorized to add, edit or delete a task for this project" if @project.nil? && !current_user.admin?
    end

    private

    def task_params
        params.require(:task).permit(:name, :duration, :description, :user_id)
    end
end
