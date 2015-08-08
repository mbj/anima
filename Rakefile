require 'devtools'
Devtools.init_rake_tasks

Rake.application.load_imports
task('metrics:mutant').clear

namespace :metrics do
  task :mutant => :coverage do
    system(*%w[
      bundle exec mutant
        --include lib
        --require anima
        --use rspec
        --zombie
        --
        Anima*
    ]) or fail "Mutant task failed"
  end
end
