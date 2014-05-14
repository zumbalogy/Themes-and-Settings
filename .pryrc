Pry.config.print = proc { |output, value| output.puts '# => ' + CodeRay.scan(value.inspect, :ruby).encode(:terminal) ; puts }

Pry.config.prompt = [
    proc { '' },
    # proc { ":>> " },  
    # proc { "\u001B[35m>>:\u001B[m " },
    proc { '' }
]

puts "# " + Time.now.strftime("%H:%M %d-%m-%Y") 

