dictionary = ['below', 'down', 'go', 'going!', 'horn', 'how', 'howdy', 'it', 'i', 'low', 'own', 'part', 'partner', 'sit']
sentence = "Howdy partner, sit down! How's it going?"

def substrings(sentence, dictionary)
  sentence_words = sentence.split
  result = {}

  sentence_words.each do |sentence_word|
    dictionary.each do |word|
      result[word] = (result[word] || 0) + 1 if sentence_word.include?(word)
    end
  end

  puts result
end

substrings(sentence, dictionary)
