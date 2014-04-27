Pry.config.prompt = [
    proc { |obj, nest_level, _| "#{obj}:#{nest_level}> " },  
    proc { "> " }
]