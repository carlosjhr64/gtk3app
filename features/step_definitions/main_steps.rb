Given /^(w+) (.*)$/ do |given, condition|
  condition.strip!
  case given
  when 'Given'
    raise "'Given' form not defined."
  when 'When'
    raise "'When' form not defined."
  when 'Then'
    raise "'Then' form not defined."
  else
    raise "'#{given}' form not defined."
  end
end
