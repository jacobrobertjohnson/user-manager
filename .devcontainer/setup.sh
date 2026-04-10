#!/usr/bin/env bash

set -euo pipefail

TARGET_RUBYGEMS_VERSION="4.0.10"
PROJECT_PATH="/workspaces/user-manager/user_manager/" 
GEMFILE_PATH="$PROJECT_PATH/Gemfile"
DB_PATH="$PROJECT_PATH/storage/development.sqlite3"

# Get the current Rails version from the Gemfile instead of hardcoding it here.
# The goal is to avoid needing to update this script when we update Rails.
TARGET_RAILS_VERSION="$(ruby - "$GEMFILE_PATH" <<'RUBY'
gemfile = ARGV.fetch(0)
line = File.readlines(gemfile).find { |l| l.match?(/^\s*gem\s+["']rails["']\s*,/) }
abort("Could not find a Rails gem version in #{gemfile}") unless line
match = line.match(/gem\s+["']rails["']\s*,\s*["']([^"']+)["']/)
abort("Could not parse the Rails gem version requirement in #{gemfile}") unless match
puts match[1]
RUBY
)"

if ruby -e 'exit(Gem::Version.new(Gem::VERSION) >= Gem::Version.new(ARGV[0]) ? 0 : 1)' "$TARGET_RUBYGEMS_VERSION"; then
	echo "RubyGems $TARGET_RUBYGEMS_VERSION or newer already installed; skipping update"
else
	gem update --system "$TARGET_RUBYGEMS_VERSION"
fi

if gem list --installed rails --version "$TARGET_RAILS_VERSION" >/dev/null 2>&1; then
	echo "Rails $TARGET_RAILS_VERSION already installed; skipping install"
else
	gem install rails --version "$TARGET_RAILS_VERSION"
fi

bundle install --gemfile "$GEMFILE_PATH"

sudo apt update
sudo apt install sqlite3 -y

sqlite3 "$DB_PATH" "PRAGMA journal_mode=DELETE;"