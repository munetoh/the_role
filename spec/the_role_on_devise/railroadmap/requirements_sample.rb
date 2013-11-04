# RailroadMap security requirements file

# Type of Access Control. rbac
$ac_type = 'rbac'

$roles = {
  'admin' => {
    description: 'system admin',
    color:       '#A757A8',  # Purple
    level:       10,
  },
  'pages_moderator' => {
    description: 'moderator can do_anything except security settings',
    color:       '#BCA352',   #  Karashiiro
    level:        5,
  },
  'user' => {
    description: 'user can edit his/her railsapps entry',
    color:       '#97A750',   #   Kimidori
    level:        3,
  },
}

$assets_base_policies = {
  'user' => {         # for Devise and User
    model_alias: {    # for controllers defined by Devise
      'devise:registration' => 'user',
      'devise:session' => 'user',
      'devise:password' => 'user',
      'devise:confirmation' => 'user',
      'devise:unlock' => 'user',
      'devise:omniauth_callback' => 'user' },
    is_authenticated: true,
    is_authorized:    true,
    level:            10,  # High
    roles: [
      { role: 'admin', action: 'CRUD' },
      { role: 'pages_moderator',  action: 'CRU', is_owner: true },
      { role: 'user',  action: 'CRU', is_owner: true }
    ],
    color: 'orange'
  },

  'role' => {         # The_Role
     model_alias: {   # for controllers defined by TheRole
       'admin:role' => 'role',
       'admin:role_section' => 'role' },
    is_authenticated: true,
    is_authorized:    true,       # Admin only
    level: 15,  # Highest
    roles:  [
      { role: 'admin',  action: 'CRUD' },
      { role: 'pages_moderator',  action: 'R' },
      { role: 'user',   action: 'R' },
    ],
    color: 'red'
  },

  'page' => {         # App
    is_authenticated: true,
    is_authorized:    true,       # Admin only
    level: 5,  # Mid
    roles:  [
      { role: 'admin',  action: 'CRUD' },
      { role: 'pages_moderator',  action: 'CRUD' },
      { role: 'user',   action: 'R' },
    ],
    color: 'green'
  },
}

$assets_mask_policies = {
  # Devise
  # Devise
  'C_devise:session#new'         => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:session#create'      => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:session#destroy'     => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:registration#new'    => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:registration#create' => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:registration#cancel' => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:unlock#new'          => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:unlock#show'         => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:unlock#create'       => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:confirmation#new'    => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:confirmation#show'   => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:confirmation#create' => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:password#new'        => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:password#edit'       => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:password#create'     => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:password#update'     => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:omniauth_callback#passthru'  => { is_authenticated: false, level: 0, color: 'green' },  # Public
  'C_devise:omniauth_callback#failure'   => { is_authenticated: false, level: 0, color: 'green' },  # Public

  'V_devise#_links'                      => { ignore: true },
  'V_devise:mailer#reset_password_instructions' => { ignore: true },
  'V_devise:mailer#unlock_instructions'         => { ignore: true },
  'V_devise:mailer#confirmation_instructions'   => { ignore: true },

  'C_devise:registration#edit'    => { is_authenticated: true, is_authorized: false, level: 15, color: 'red' }, # any role
  'C_devise:registration#update'  => { is_authenticated: true, is_authorized: false, level: 15, color: 'red' }, # any role
  'C_devise:registration#destroy' => { is_authenticated: true, is_authorized: false, level: 15, color: 'red' }, # any role

  # Application
  'C_welcome#index'     => { is_authenticated: false, level: 0, color:'green' },  # Public
  'C_welcome#profile'   => { is_authenticated: true,  level: 5, color:'green' },  # Public
  'C_welcome#autologin' => { is_authenticated: false, level: 0, color:'green' },  # Public

  # Application
  'C_page#index' => { is_authenticated: false, level: 0, color:'green' },  # Public
  'C_page#show'  => { is_authenticated: false, level: 0, color:'green' },  # Public

  # V of layout use
  'V_layout#application' => {
    is_authenticated: false,
    ignore: true,
    view_type: 'layout',
    level: 0,  # Public and else
  },
}

# EOF
