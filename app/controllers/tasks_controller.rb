class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = Task.all
    @tasks = @tasks.order(task_deadline: :asc) if params[:sort_expired]
    @tasks = @tasks.title_search(params[:title]) if params[:title].present?
    @tasks = @tasks.status_search(params[:status]) if params[:status].present? && params[:status] != ""
  end


  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :task_deadline, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
