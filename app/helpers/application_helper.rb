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

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def user_avatar(user)
    user.avatar_url.present? ? user.avatar_url : default_avatar(user)
  end

  def questions_correct_form(number)
    "#{number} #{case_adjuster(number, *QUESTION_WORD_FORMS)}"
  end

  def questions_answered(number)
    "на #{questions_correct_form(number)} отвечено"
  end

  def questions_total(number)
    "#{questions_correct_form(number)} задано"
  end

  def questions_unanswered(number)
    "#{questions_correct_form(number)} без ответа"
  end
end
