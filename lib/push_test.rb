# frozen_string_literal: true

# "https://#{@user}:#{@token}@github.com/#{@repo_slug}.git"
file = File.join `pwd`.strip, 'storage/.smoke'
500.times do
  File.open(file, 'a') { |f| f << '0' }
end
