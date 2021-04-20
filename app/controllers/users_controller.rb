class UsersController < ApplicationController
  before_action :load_user, except: %i(index create new)
  before_action :redirect_current_user, only: %i(new create)
  before_action :restrict_access, only: %i(edit update destroy)

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
    @questions = @user.questions.sorted

    @new_question = @user.questions.build

    @questions_total = @questions.count
    @questions_answered = @questions.answered.count
    @questions_unanswered = @questions.unanswered.count
  end

  def create
    @user = User.new(user_params)

    if @user.save
      authorize_user(@user.id)

      redirect_to root_url, notice: 'Успех! Пользователь зарегисрирован.'
    else
      render :new
    end
  end

  def destroy
    @user.destroy

    redirect_to root_url, notice: 'Пользователь удалён :( Возвращайтесь скорей!'
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Успех! Данные обновлены.'
    else
      render :edit
    end
  end

  private

  def restrict_access
    reject_user unless @user == current_user
  end

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email,
                                 :username,
                                 :name,
                                 :password,
                                 :password_confirmation,
                                 :avatar_url,
                                 :background_color)
  end

  def redirect_current_user
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user
  end
end
