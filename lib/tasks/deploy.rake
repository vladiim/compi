task :deploy do
  puts """
    ---------------------------------------------------
    Instruction\t\t\t\t Command
    ---------------------------------------------------\n
    1. Run tests\t\t\t rspec\n
    2. Migrate dev/test databases\t rake migrate\n
    3. Ensure git is clean\t\t git status\n
    4. Push to heroku\t\t\t git push heroku\n
    5. Migrate production database\t heroku run:detatched sq:migrate\n
  """
end