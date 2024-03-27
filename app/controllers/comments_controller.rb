class CommentsController < ApplicationController
    before_action :authenticate, only: [:new, :create]
    before_action :correct_user, only: [:destroy]
    
    def new
        @comment = Comment.new
    end

    def create
        # @project = Project.find(params[:project_id])
        # @task = @project.tasks.find(params[:task_id])
        # @comment = @task.comments.new(comment_params)

        @comment = comment_service.create_comment(params[:project_id], params[:task_id], comment_params)
        if @comment.save
            redirect_to_project_with_notice("Comment created successfully.")
        else
            render 'new'
        end
    end

    def destroy
        # @project = Project.find(params[:project_id])
        # @task = @project.tasks.find(params[:task_id])
        # @comment = @task.comments.find(params[:id])
        # @comment.destroy

        comment_service.delete_comment(params[:id])
        redirect_to_project_with_notice("Comment deleted successfully.")
    end

    def correct_user
        @project = current_user.projects.find_by(id: params[:project_id])
        @comment = current_user.comments.find_by(id: params[:id])
        @current_project = Project.find(params[:project_id])
        redirect_to project_path(@current_project), alert: "Not authorized to delete comments for this task" if @project.nil? && @comment.nil? && !current_user.admin?
    end

    private

    def comment_params
        params.require(:comment).permit(:commenter, :body, :user_id)
    end

    def comment_service
        CommentService.new(current_user)
    end

    def redirect_to_project_with_notice(notice_message)
        redirect_to project_path(params[:project_id]), notice: notice_message
    end
end
