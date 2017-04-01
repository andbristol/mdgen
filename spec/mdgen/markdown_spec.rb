require 'mdgen'

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
  it 'can make an empty list' do
    expect(MDGen::Markdown.ul).to eq('')
  end

  it 'can make a list with items' do
    expect(MDGen::Markdown.ul(['one', 'two', 'three'])).to eq("* one\n* two\n* three")
  end
end

describe '#ol' do
  it 'can make an empty list' do
    expect(MDGen::Markdown.ol).to eq('')
  end

  # todo should use heredocs for these
  it 'can make a list with items' do
    expect(MDGen::Markdown.ol(['one', 'two', 'three'])).to eq("1. one\n2. two\n3. three")
  end
end

describe '#code' do
  it 'can make an empty code block' do
    expect(MDGen::Markdown.code).to eq("```\n\n```")
  end

  it 'can make a regular code block' do
    expect(MDGen::Markdown.code('foo bar')).to eq("```\nfoo bar\n```")
  end

  it 'can make a code block with higlighting' do
    expect(MDGen::Markdown.code("puts 'foo bar'", 'ruby')).to eq("```ruby\nputs 'foo bar'\n```")
  end
end
