require 'sentence_transformer'

RSpec.describe SentenceTransformer, '#reverse' do
  before do
    @st = SentenceTransformer.new
  end
  context 'when single sentence is present' do
    it 'returns reverted sentence fixing the upper cases' do
      sentence = 'the big black cat.'
      reveresed_sentence = @st.reverse(sentence)
      expect(reveresed_sentence).to eq('Cat black big the.')
    end

    it 'returns reverted sentence including chars like comma properly' do
      sentence = 'This cat is very big, but very nice.'
      reveresed_sentence = @st.reverse(sentence)
      expect(reveresed_sentence).to eq('Nice very but, big very is cat this.')
    end

    it 'returns reverted sentence including multiple chars like colon, semicolon properly' do
      sentence = 'This cat is very nice, for example: he can lay down purring all day long!'
      reveresed_sentence = @st.reverse(sentence)
      expect(reveresed_sentence).to eq('Long day all purring down lay can he: example for, nice very is cat this!')
    end

    it 'returns reverted sentence supporting properly different brackets' do
      sentence = 'This cat is sleeping now (for a long time), maybe we should wake him up?'
      reveresed_sentence = @st.reverse(sentence)
      expect(reveresed_sentence).to eq('Up him wake should we maybe, (time long a for) now sleeping is cat this?')
    end
  end

  context 'when multiple sentences are present' do
    it 'returns reverted sentences with fixed upper cases one after another' do
      sentence = 'the big black cat. very big, very nice!'
      reveresed_sentence = @st.reverse(sentence)
      expect(reveresed_sentence).to eq('Cat black big the. Nice very, big very!')
    end

    it 'returns reverted sentences with questions' do
      sentence = 'My mom loves this cat! How old is he?'
      reveresed_sentence = @st.reverse(sentence)
      expect(reveresed_sentence).to eq('Cat this loves mom my! He is old how?')
    end

    it 'returns reverted sentences including commas and brackets' do
      sentence = "My mom loves this cat! She is not sure, but she would like to feed him (if you don't mind) and take home."
      reveresed_sentence = @st.reverse(sentence)
      expect(reveresed_sentence).to eq("Cat this loves mom my! Home take and (mind don't you if) him feed to like would she but, sure not is she.")
    end
  end
end
