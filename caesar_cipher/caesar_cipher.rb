DOWNCASE_ASCII_BASE = 97
UPCASE_ASCII_BASE = 65
SIZE_ALPHABETS = 26

def caesar_cipher(sentence, key)
  new_sentence = ''
  sentence.each_char do |letter|
    new_letter = nil
    new_letter = convert_letter(letter, key) if is_letter?(letter)
    new_letter ||= letter
    new_sentence << new_letter
  end

  new_sentence
end

# Checks if character is in uppercase
def is_upper?(character)
  /[[:upper:]]/.match(character) ? true : false
end

# Checks if character is a letter
# We don't need to convert if it is a special character
def is_letter?(character)
  character =~ /[[:alpha:]]/ ? true : false
end

def convert_in_ascii(letter, base_ascii)
  letter + base_ascii
end

def index_in_alphabet(letter, base_ascii)
  letter - base_ascii
end

def ask_for_shift_factor
  shift_factor = nil

  loop do
    puts 'Please write your shift factor:'
    shift_factor = gets.chomp.to_i
    break if shift_factor > 0
  end

  shift_factor
end

def convert_letter(letter, key)
  # Converts letter into ascii
  byte_letter = letter.ord

  # Checks the case of the letter
  # "a" in ascii is 97
  # "A" in ascii is 65
  if is_upper?(letter)
    letter_index_alphabet = index_in_alphabet(byte_letter, UPCASE_ASCII_BASE)
    converted_index_alphabet = (letter_index_alphabet + key) % SIZE_ALPHABETS
    letter = convert_in_ascii(converted_index_alphabet, UPCASE_ASCII_BASE)
  else
    letter_index_alphabet = index_in_alphabet(byte_letter, DOWNCASE_ASCII_BASE)
    converted_index_alphabet = (letter_index_alphabet + key) % SIZE_ALPHABETS
    letter = convert_in_ascii(converted_index_alphabet, DOWNCASE_ASCII_BASE)
  end
  letter
end

puts 'Please write your sentence:'
sentence = gets.chomp

key = ask_for_shift_factor
encoded_sentence = caesar_cipher(sentence, key)

puts "\n\n\n"
puts "Sentence encoded: #{encoded_sentence}"
