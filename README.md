# mdgen

This is a library for generating Markdown documents in Ruby. If your project emits Markdown, you've probably written some methods like these somewhere

```ruby
def link(text, url)
  "[#{text}](#{url})"
end
```

This library is just that, dressed up in a slick DSL. It's probably unnecessary for most use cases, but I once worked on a project where this would have saved me a whole fifteen minutes.

## Usage

To expose the Markdown generation methods in a compact way that's convenient to write long documents in, use `MDGen.md`. All Markdown methods will evaluate to their Markdown text representations.

```ruby
page = ''
MDGen.md do
  page << h('The title')
  page << "\n"
  page << p("This paragraph has a link: #{link('example', 'http://example.com')}")
  page << "\n"
  page << list([
    'item one',
    'item two',
    'item three'
    ])
end
```

After this listing, the value of `page` would be

```markdown
# The title

This paragraph has a link: [example](http://example.com)

* item one
* item two
* item three
```

If your document is simple, you can use `MDGen.document` to handle line breaks and just get back a string. Here the methods for Markdown block objects will be added to the resulting document. Methods for inline objects still evaluate to their The value of `page` ends up the same in this listing.

```ruby
page = MDGen.document do
  h 'The title'
  p "This paragraph has a link: #{link('example', 'http://example.com')}"
  list [
    'item one',
    'item two',
    'item three'
  ]
end
```

If you're thinking "oh no another Ruby DSL why", don't worry because there are still regular methods in the `MDGen::Markdown` module

```ruby
page = ''
page << MDGen::Markdown.h('The title')
page << "\n"
page << MDGen::Markdown.p("This paragraph has a link: #{MDGen::Markdown.link('example', 'http://example.com')}")
page << "\n"
page << MDGen::Markdown.list([
  'item one',
  'item two',
  'item three'
])
```

## Markdown elements

This supports most major markdown elements. The tests in [`spec/mdgen/markdown_spec.rb`](spec/mdgen/markdown_spec.rb) are another example of usage.

### Headers - #h through #hhhhhh

Header levels 1-6 are supported in atx style

```ruby
MDGen::Markdown.h 'The title'
  # => '# The title\n'
MDGen::Markdown.hh 'Subtitle'
  # => '## Subtitle\n'
MDGen::Markdown.hhhhhh 'Subhead'
  # => '###### Subhead\n'
```

### Paragraph - #p

Just adds the line break that makes a string a paragraph in Markdown. This does override the `p` to `puts` mapping, which you can still call as `Kernel.p`.

```ruby
MDGen::Markdown.p 'This is a paragraph'
  # => 'This is a paragraph\n'
```

### Block quote - #quote

Handles lines when adding the quote prefacing

```ruby
text = <<EOF
First line
Second line
EOF

MDGen::Markdown.quote text
  # => "> First line\n> Second line\n"
```

### Lists - #list, #ul, and #ol

Both `ul` and its alias `list` generate an unordered list

```ruby
MDGen::Markdown.list ['red', 'green', 'blue']
  # => '* red\n* green\n* blue\n'
```

The `ol` method generates an ordered list

```ruby
MDGen::Markdown.ol ['one', 'two', 'three']
  # => '1. one\n2. two\n3. three\n'
```

### Task list - #task_list

This element is from Github flavored Markdown and may not be supported by all parsers.

```ruby
MDGen::Markdown.task_list [
  ['foo', false],
  ['bar', true],
  ['baz', false]
]
  #=> '- [ ] foo\n- [x] bar\n- [ ] baz\n'
```

To initialize a big list you could do

```ruby
tasks = [
  'a thing',
  'another',
  'and another' # and so on
]
MDGen::Markdown.task_list(tasks.zip([false].cycle))
  # => '- [ ] a thing\n- [ ] another\n- [ ] and another\n'
```

### Code block - #code

Supports optional syntax highlighting. Also has the alias `pre`

```ruby
text = "puts 'foo'"
MDGen::Markdown.code(text, 'ruby')
  # => '```ruby\nputs 'foo'\n```'
```

### Horizontal rule - #rule

```ruby
MDGen::Markdown.rule
  # => '* * *\n'
```
### Table - #table

Pass your data as an array of rows to make a Github flavored markdown table. It will make the spacing nice and readable. The first row is read as a header by default.

```ruby
data = [
  ['thing', 'color', 'dangerous?'],
  ['sky', 'blue', 'no'],
  ['tiger', 'orange', 'yes']
]
MDGen::Markdown.table(data)
```

would evaluate to

```markdown
| thing | color  | dangerous? |
| ----- | ------ | ---------- |
| sky   | blue   | no         |
| tiger | orange | yes        |
```

```ruby
# pass header: false to get an empty header
MDGen::Markdown.table(data.drop(1), header: false)

# indicate alignment by passing an array of column alignments
alignments = [:center, :left, :right]
MDGen::Markdown.table(data, alignment: alignments)
```

The second example would evaluate to

```markdown
| thing | color  | dangerous? |
|:-----:|:------ | ----------:|
| sky   | blue   | no         |
| tiger | orange | yes        |
```

Note that the alignment feature doesn't actually align the Markdown text. It sets the alignment for the columns when they are rendered by the Markdown renderer.

### Links - #link

```ruby
MDGen::Markdown.link('example', 'http://example.com')
  # => '[example](http://example.com)'
```

### Images - #image

Pass `title: str` for an optional image title

```ruby
MDGen::Markdown.image('example', 'http://example.com/image.jpg')
  # => '![example](http://example.com.image)''

# Pass title: str for an optional image title
MDGen::Markdown.image('example', 'http://example.com/image.jpg', 'my title')
  # => '![example](http://example.com/image.jpg "my title")'
```

### Raw text - #raw

Use this when you want to insert text without any changes when using `MDGen.document`. Acts as the identity function.

```ruby
MDGen::Markdown.raw('foo')
  # => 'foo'

MDGen.document do
  raw 'foo'
  p 'paragraph'
end
   # => 'fooparagraph\n'
```
