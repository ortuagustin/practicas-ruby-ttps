def longitud *args
  args.each { |x| puts "#{x.to_s} --> #{x.to_s.length}" }
end