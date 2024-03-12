class CommentsController < ApplicationController
    def new
        @comment = Comment.new
    end

    def create
        @project = Project.find(params[:project_id])
        @task = @project.tasks.find(params[:task_id])
        @comment = @task.comments.build(comment_params)

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

    def comment_params
        params.require(:comment).permit(:commenter, :body)
    end
end
