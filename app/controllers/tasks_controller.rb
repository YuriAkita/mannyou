class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :ensure_current_user, only: %i[ edit update show ]

  def index
    @tasks = Task.all.order(created_at: :desc)
    @tasks = Task.all.order(task_deadline: :asc) if params[:sort_expired]
    @tasks = Task.all.order(priority: :asc) if params[:sort_priority]
    @tasks = @tasks.title_search(params[:title]) if params[:title].present?
    @tasks = @tasks.status_search(params[:status]) if params[:status].present? && params[:status] != ""
    @tasks = @tasks.priority_search(params[:priority]) if params[:priority].present? && params[:priority] != ""
    @tasks = @tasks.page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to new_task_path, notice: "タスクを作成しました！"
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :task_deadline, :status, :priority, :user_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def ensure_current_user
    if @current_user.id != @task.user.id
      flash[:notice]="権限がありません"
      redirect_to tasks_path
    end
  end

end
