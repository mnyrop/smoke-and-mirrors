require 'faker'
require 'fileutils'
require 'time'

def on_gha
  ENV['CI'].to_s.downcase == 'true' ? true : false
end

def some_filler
  person        = Faker::Music::RockBand.name
  possessive    = person.end_with?('s') ? "'" : "'s"
  pet           = Faker::Creature::Animal.name
  verb          = ['loves', 'hates'].sample
  treat         = [Faker::Food.ingredient, Faker::Food.dish].sample.downcase

  "#{person}#{possessive} pet #{pet} #{verb} #{treat}."
end

def is_weekend?
  Time.now.saturday? || Time.now.sunday?
end

def commit_range
  range   = (0..17).to_a
  empties = is_weekend? ? 80 : 3

  empties.times { range.push(0) }
  range.flatten.shuffle
end


def clear(file)
  FileUtils.rm file, :force => true
  FileUtils.touch file
end


desc 'add changes for cheaty commits'
task :smoke do
  outfiles      = ['./tmp/mirror.txt', './tmp/smoke.txt']
  emojis        = ['🌳', '🔋', '📟', '🎾', '🍀', '💚', '🐊', '🕒']
  file          = outfiles.sample # file to write cheap commits to
  commit_count  = commit_range.sample # number of cheap commits to make

  clear file

  if on_gha
    `git config user.name "$(git log -n 1 --pretty=format:%an)"`
    `git config user.email "$(git log -n 1 --pretty=format:%ae)"`
  end

  commit_count.times do
    File.write file, "#{some_filler}\n", mode: 'a'
    emoji = emojis.sample
    `git add tmp/*`
    `git commit -m "#{emoji} [skip ci]"`
    puts "Committing -m #{emoji} [skip ci]"
  end
  `git push`
end

task :default => [:smoke]
