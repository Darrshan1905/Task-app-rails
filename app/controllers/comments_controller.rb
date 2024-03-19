class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :correct_user, only: [:destroy]
    
    def new
        @comment = Comment.new
    end

    def create
        @project = Project.find(params[:project_id])
        @task = @project.tasks.find(params[:task_id])
        @comment = @task.comments.new(comment_params)

        if @comment.save
            redirect_to project_path(@project)
        else
            render 'new'
        end
    end

    def destroy
        @project = Project.find(params[:project_id])
        @task = @project.tasks.find(params[:task_id])
        @comment = @task.comments.find(params[:id])
        @comment.destroy
        redirect_to project_path(@project)
    end

    def correct_user
        @project = current_user.projects.find_by(id: params[:project_id])
        @comment = current_user.comments.find_by(id: params[:id])
        @current_project = Project.find(params[:project_id])
        redirect_to project_path(@current_project), alert: "Not authorized to delete comments for this task" if @project.nil? && @comment.nil?
    end

    private

    def comment_params
        params.require(:comment).permit(:commenter, :body, :user_id)
    end
end
