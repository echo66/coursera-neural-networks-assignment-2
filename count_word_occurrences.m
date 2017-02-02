function c = count_word_occurrences(word, vocab, nGramsDataset) 
  % Inputs:
  %   word: The query word as a string.
  %   vocab: TODO
  %   nGramsDataset: TODO (#words-per-ngram x #instances)
  %
  id = strmatch(word, vocab, 'exact');
  c = 0;
  
  for i=1:size(nGramsDataset, 1)
    c = c + sum(nGramsDataset(i,:) == id);
  end
end