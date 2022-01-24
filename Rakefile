require 'faker'
require 'fileutils'

def some_filler
  person        = Faker::Music::RockBand.name
  possessive    = person.end_with?('s') ? "'" : "'s"
  pet           = Faker::Creature::Animal.name
  verb          = ['loves', 'hates'].sample
  treat         = [Faker::Food.ingredient, Faker::Food.dish].sample.downcase

  "#{person}#{possessive} pet #{pet} #{verb} #{treat}."
end

def clear(file)
  FileUtils.rm file, :force => true
  FileUtils.touch file
end


desc 'add changes for cheaty commits'
task :smoke do
  outfiles      = ['./tmp/mirror.txt', './tmp/smoke.txt']
  file          = outfiles.sample # file to write cheap commits to
  commit_count  = (1..20).to_a.sample # number of cheap commits to make

  clear file

  commit_count.times do
    File.write file, "#{some_filler}\n", mode: 'a'
    # `git add tmp/*`
    # `git commit - m "#{Faker::SlackEmoji.emoji}"`
  end
end

task :default => [:smoke]
