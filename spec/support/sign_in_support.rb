module SignInSupport
  def sign_in(school)
    visit new_school_session_path
    fill_in 'school[email]', with: school.email
    fill_in 'school[password]', with: school.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
  end
end