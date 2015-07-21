require 'spec_helper'
require 'questions_helper'
include QuestionsHelper

feature 'Question management' do
  background do
    @question = create(:question)
    visit root_path
  end

  scenario 'adds a new question' do
    expect{
      click_link 'Add a new question'
      fill_in 'Question', with: @question.question
      fill_in 'Answer', with: @question.answer
      click_button 'Create Question'
    }.to change(Question, :count).by(1)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Question created successfully.'
    expect(page).to have_selector 'a', text: show_only_title(@question.question)
    expect(page).to have_selector 'a', text: 'edit'
  end

  scenario 'updates a question' do
    click_link 'edit'

    old_question = @question.question
    old_answer   = @question.answer
    new_question  = 'Who is the CEO of Google?'
    new_answer    = 'Lawrence Edward "Larry" Page'
    fill_in 'Question', with: new_question
    fill_in 'Answer'  , with: new_answer
    click_button 'Update Question'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Question saved successfully.'
    expect(page).to have_selector 'a', text: show_only_title(new_question)
  end

end

feature 'Answer questions' do
  background do
    @question = create(:question)
    visit root_path
    click_link @question.question
  end

  scenario 'submit a collect answer' do
    fill_in 'answer[user_answer]', with: @question.answer
    click_button 'Submit answer'

    expect(current_path).to eq '/questions/' + @question.id.to_s + '/answer'
    expect(page).to have_selector '.alert-success', text: "That's correct!"
  end

  scenario 'submit a wrong answer' do
    fill_in 'answer[user_answer]', with: 'wrong'
    click_button 'Submit answer'

    expect(current_path).to eq '/questions/' + @question.id.to_s + '/answer'
    expect(page).to have_selector '.alert-warning', text: 'Wrong answer... Try again!'
  end

  scenario 'submit no answer' do
    fill_in 'answer[user_answer]', with: ''
    click_button 'Submit answer'

    expect(current_path).to eq '/questions/' + @question.id.to_s + '/answer'
    expect(page).to have_selector '.alert-danger', text: 'Please input your answer.'
  end
end
