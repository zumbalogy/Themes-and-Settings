Pry.config.print = proc { |output, value| output.puts '# => ' + CodeRay.scan(value.inspect, :ruby).encode(:terminal) ; puts }

Pry.config.exception_handler = proc do |output, exception, _pry_|
  output.puts exception
  output.puts exception.backtrace.first(12)
end

Pry.config.prompt = [
    proc { '' },
    # proc { ":>> " },  
    # proc { "\u001B[35m>>:\u001B[m " },
    proc { '' }
]

puts "# " + Time.now.strftime("%H:%M %d-%m-%Y") 

