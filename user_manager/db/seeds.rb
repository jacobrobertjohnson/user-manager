if (User.count == 0)
  user = User.create!(
    active: 1,
    email_address: "temp_admin@local",
    first_name: "Temporary",
    last_name: "Admin",
    username: "tempadmin"
  )

  user.roles.create!(
    name: "user_admin",
    active: 1
  )

  user.passwords.create!(
    active: 1,
    active_end: nil,
    active_start: nil,
    password_digest: "TempPass123!",
  )
end