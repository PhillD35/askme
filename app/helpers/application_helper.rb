module ApplicationHelper
  QUESTION_WORD_FORMS = %w[вопрос вопроса вопросов]

  def case_adjuster(number, first_form, second_form, third_form)
    return third_form if (11..14).include?(number % 100)

    case number % 10
    when 1 then first_form
    when 2..4 then second_form
    else third_form
    end
  end

  def default_avatar(user)
    "https://via.placeholder.com/150.png/ddd/111?text=@#{user.username.capitalize}"
  end

  def user_avatar(user)
    user.avatar_url.present? ? user.avatar_url : default_avatar(user)
  end

  def questions_answered(questions)
    number_of_questions = questions.select(&:answered?).count
    correct_word_form = case_adjuster(number_of_questions, *QUESTION_WORD_FORMS)

    "на #{number_of_questions} #{correct_word_form} отвечено"
  end

  def questions_total(questions)
    number_of_questions = questions.count
    correct_word_form = case_adjuster(number_of_questions, *QUESTION_WORD_FORMS)

    "#{number_of_questions} #{correct_word_form} задано"
  end

  def questions_unanswered(questions)
    number_of_questions = questions.reject(&:answered?).count
    correct_word_form = case_adjuster(number_of_questions, *QUESTION_WORD_FORMS)

    "#{number_of_questions} #{correct_word_form} без ответа"
  end
end
