# Sentence Transformer
Reverse the words in a sentence or multiple sentences

### In order to run:

```sh
$ git clone git@github.com:mwalkowiak/sentence_transformer.git
$ cd sentence_transformer
$ bundle install
$ irb
$ require './lib/sentence_transformer.rb'
$ st = SentenceTransformer.new
$ st.reverse('this is a cat.')
```

### Running tests

```sh
$ bin/rspec --format doc
```
