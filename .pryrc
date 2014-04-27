begin
  require 'awesome_print' 
  Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError => err
  puts "no awesome_print :("
end


Pry.config.prompt = [
    proc { |obj, nest_level, _| "#{obj}:#{nest_level} > " },  
    proc { "       > " }
]