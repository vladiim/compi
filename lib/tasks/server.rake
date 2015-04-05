task :s do
  puts `foreman start -f Procfile.development -p 3000 --color`
end

task :log do
  `foreman export`
end