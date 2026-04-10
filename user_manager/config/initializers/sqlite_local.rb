# When running the app in a VSCode dev container with storage on a mounted volume, SQLite encounters permission
# issues during migrations:
# 
#   vscode ➜ /workspaces/user-manager/user_manager (main) $ bin/rails db:migrate
#   bin/rails aborted!
#   ActiveRecord::StatementInvalid: SQLite3::IOException: disk I/O error: (ActiveRecord::StatementInvalid)
#   SELECT sqlite_version(*) /*application='UserManager'*/
#   
# This is due to the user being used to write the journal files, and not the DB itself. Since we don't actually
# need to worry about DB reliability or concurrency  on local, we can disable them.
if Rails.env.development? && ActiveRecord::Base.connection.adapter_name == "SQLite"
  ActiveRecord::Base.connection.execute("PRAGMA journal_mode=DELETE;")
end