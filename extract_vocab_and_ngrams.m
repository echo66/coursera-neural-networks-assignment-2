function dataset = extract_vocab_and_ngrams(textFilePath, nGramSize, splitExpression) 
  vocab = cell(0,1);
  ngrams = -1 * ones(nGramSize+1, 0);
  %splitExpression = splitExpression || '\w+';
  % Create vocabulary
  fd = fopen(textFilePath);
  l = fgetl(fd);
  while (l != -1)
    %disp(l);
    %tokens = strsplit(l, " ");
    [tokens,~] = regexp(l, splitExpression, 'match', 'split');
    numTokens = length(tokens);
    for i=1:numTokens 
      token = tokens(i);
      if (length(vocab) > 0)
        vocab(end+1) = token;
      else 
        vocab(1) = token;
      end
    end
    l = fgetl(fd);
  end
  vocab = unique(vocab);
  fclose(fd);
  
  % Extract n-grams
  fd = fopen(textFilePath);
  l = fgetl(fd);
  while (l != -1)
    %disp(l);
    %tokens = strsplit(l, " ");
    [tokens,~] = regexp(l, splitExpression, 'match', 'split');
    numTokens = length(tokens);
    c = 1;
    while (1)
      if (c+nGramSize <= numTokens)
        ngrams(:,end+1) = -1 * ones(nGramSize+1, 1);
        nGramTokens = tokens(c:(c+nGramSize));
        for i=1:length(nGramTokens) 
          nGramTokens(1,i) = strmatch(nGramTokens{i}, vocab, 'exact'); 
        end
        nGramTokens = cell2mat(nGramTokens)';
        %disp(nGramTokens);
        %disp(vocab(nGramTokens));
        ngrams(:,end) = nGramTokens;
      else
        break;
      end
      
      c = c + 1;
    end
    
    l = fgetl(fd);
  end
  
  
  dataset = {};
  dataset.vocab = vocab;
  dataset.ngrams = ngrams;
end