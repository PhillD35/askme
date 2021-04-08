class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Jay',
        username: 'Mega-pihar',
        avatar_url: 'https://www.fillmurray.com/100/100'
      ),
      User.new(
        id: 2,
        name: 'Robert',
        username: 'silent_bob'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'David',
      username: 'phill'
    )

    @questions = [
      Question.new(text: 'Who are you?', created_at: '2021-04-08 11:16:00'),
      Question.new(text: 'None of your business!', created_at: '2021-04-08 11:50:00')
    ]

    @new_question = Question.new
  end
end
