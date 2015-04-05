task :s do
  puts `foreman start -f Procfile -p 3000`
end

task :log do
  `foreman export`
end