begin
    require "awesome_print"
    # AwesomePrint.defaults = {multiline: false} 
    # in the .aprc
    Pry.config.print = proc { |output, value| output.puts "# => " + value.ai ; puts }
rescue LoadError => err
    puts "no awesome_print :("
end

Pry.config.prompt = [
    proc { "" },
    # proc { ":>> " },  
    # proc { "\u001B[35m>>:\u001B[m " },
    proc { "" }
]

Pry.config.prompt_name = 'my_project_name'

puts "# " + Time.now.strftime("%H:%M %d-%m-%Y") 

