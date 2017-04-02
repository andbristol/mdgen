describe MDGen::Markdown do
  describe '#atx_header' do
    HEADERS = [
      '# foo bar',
      '## foo bar',
      '### foo bar',
      '#### foo bar',
      '##### foo bar',
      '###### foo bar'
    ]

    HEADERS.each_with_index do |header, index|
      level = index + 1

      it "makes a header for level #{level}" do
        expect(MDGen::Markdown.atx_header(level, 'foo bar')).to eq(header)
      end
    end
  end

  describe '#ul' do
    it 'makes an empty list' do
      expect(MDGen::Markdown.ul).to eq('')
    end

    text = <<EOF.chomp
* one
* two
* three
EOF

    it 'makes a list with items' do
      expect(MDGen::Markdown.ul(['one', 'two', 'three'])).to eq(text)
    end
  end

  describe '#ol' do
    it 'makes an empty list' do
      expect(MDGen::Markdown.ol).to eq('')
    end

    text = <<EOF.chomp
1. one
2. two
3. three
EOF

    it 'makes a list with items' do
      expect(MDGen::Markdown.ol(['one', 'two', 'three'])).to eq(text)
    end
  end

  describe '#link' do
    it 'makes a link' do
      expect(MDGen::Markdown.link('a real site', 'http://example.com')).to eq("[a real site](http://example.com)")
    end
  end

  describe '#code' do

    empty_block = <<EOF.chomp
```

```
EOF
    it 'makes an empty code block' do
      expect(MDGen::Markdown.code).to eq(empty_block)
    end

    block = <<EOF.chomp
```
foo bar
```
EOF

    it 'makes a regular code block' do
      expect(MDGen::Markdown.code('foo bar')).to eq(block)
    end

    highlight_block = <<EOF.chomp
```ruby
puts 'foo bar'
```
EOF
    it 'makes a code block with higlighting' do
      expect(MDGen::Markdown.code("puts 'foo bar'", 'ruby')).to eq(highlight_block)
    end
  end

  describe '#quote' do
    it 'makes an empty quote' do
      expect(MDGen::Markdown.quote).to eq('')
    end

    it 'makes a single line quote' do
      expect(MDGen::Markdown.quote('Once upon a time')).to eq('> Once upon a time')
    end

    it 'makes a multi line quote' do
      text = <<EOF
Once upon a time
In a galaxy far away
There was a doggo
EOF
      quote = <<EOF
> Once upon a time
> In a galaxy far away
> There was a doggo
EOF
      expect(MDGen::Markdown.quote(text)).to eq(quote)
    end

    it 'makes nested quotes' do
      quote = <<EOF
> Once upon a time
> In a galaxy far away
EOF
      nested = <<EOF
> > Once upon a time
> > In a galaxy far away
EOF
      expect(MDGen::Markdown.quote(quote)).to eq(nested)
    end
  end

  describe '#image' do
    it 'makes an image' do
      expect(MDGen::Markdown.image('doggo', 'http://example.com/dog')).to eq("![doggo](http://example.com/dog)")
    end

    it 'makes an image with title' do
      expect(MDGen::Markdown.image('doggo', 'http://example.com/dog', title: 'Nice doggo')).to eq("![doggo](http://example.com/dog \"Nice doggo\")")
    end
  end
end
