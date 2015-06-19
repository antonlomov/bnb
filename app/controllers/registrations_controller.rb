class RegistrationsController < Devise::RegistrationsController
  # (**) so here we create a new registrationscontroller, which will inherit from the devise registrationscontroller
  #      and we only overwrite the piece we want to change i.e. the create accounts' action's redirect_to part
  #      https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-up-%28registration%29
  protected

  def after_sign_up_path_for(resource)
    # so here we give the path the end of the account's creation action should redirect to instead of the default devise redirect
    # new_user_path
    # (FIXING BUG) replaced by user creation with empty values so that there is a user already and then we UPDATE this user instead of a new one
    ActiveRecord::Base.transaction do
      user = User.create!
      current_account.update_attribute(:user, user)
      edit_user_path(user)
    end
  end
end
