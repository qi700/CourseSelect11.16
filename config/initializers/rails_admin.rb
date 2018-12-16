RailsAdmin.config do |config|


    # config.main_app_name = ["Cool app", "BackOffice"]
  # or something more dynamic
  config.main_app_name = Proc.new { |controller| ["CourseSelect", "控制面板"] }

  # config.authorize_with :cancan, AdminAbility

  config.included_models = ['User','Inform','Course','Grade']

  # config.model ['Relationship'] do
  #   navigation_label 'Association'
  # end
  # config.navigation_static_links = {
  #     'Google' => 'http://www.google.com'
  # }
  # config.navigation_static_label = "My Links"

  # == Authenticate ==
  config.authorize_with do
    if !current_user.admin
      redirect_to main_app.root_url, flash: {:danger => '请先以管理员身份登陆'}
    end
  end

  config.current_user_method(&:current_user)
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
