require_relative 'sanity_checker'

def check_result
  "Its #{Time.now} and you are #{SanityChecker.am_i_sane? ? 'sane' : 'insane'}"
end

puts check_result
