module QuestionsHelper
    def display_choice_image(question, choice)
      if choice == 'one' && question.choice_one_image.present?
        image_tag question.choice_one_image.url, class: "img-fluid"
      elsif choice == 'two' && question.choice_two_image.present?
        image_tag question.choice_two_image.url, class: "img-fluid"
      else
        image_tag "noimage_ピクト-760x460.png", class: "img-fluid"
      end
    end
  end
