class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:dstroy]
  
  def index
    @tasks = current_user.tasks.all.page(params[:page]).per(3)
  end
  
  def show
    # @task = Task.find(params[:id])
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
  # これは if 文による条件分岐と、@task の保存を同時に行っている
  # @task.save は成功すると true を返し、失敗すると false を返す。
    if @task.save
      flash[:success] = 'Task が正常に投稿されました' #redirect_to の前なら flash です。redirect_to は、HTTP リクエストを発生させるので flash.now だと内容を保持できずに消えてしまう
      redirect_to @task          #今作った個別詳細ページへ飛ぶ
    else                         
      flash.now[:danger] = 'Message が投稿されませんでした'   #render の前なら flash.now 
      render :new                #tasks/new.html.erb を表示するだけ
    end                          #Tasks#newアクションは実行しない
  end

  def edit
     # @task = Task.find(params[:id])
  end
  
  def update
   # @task =Task.find(params[:id])
    
      if @task.update(task_params)
        flash[:success] = 'タスクは正常に更新されました'
        redirect_to @task
      else
        flasf.now[:danger] = 'タスク は更新されませんでした'
        render :edit
      end
  end

  def destroy
    
    @task.destroy
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to root_url
  end


  #このメソッドがアクションではなくこのクラス内のみでしようするよ、と明示している
  private 

  def set_task
    @task = Task.find(params[:id])
  end
  # Strong Parameter
  #Task モデルのフォームから得られるデータに関するものだと明示し
  #必要なカラムだけを選択し
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end

