# mdgen

MDGen is a library for generating Markdown documents in Ruby. If your project needs to emit Markdown, you've probably written some methods like this somewhere

```ruby
def header(text)
  "# " + text
end

def link(text, url)
  "[#{text}](#{url})"
end
```

This library is just that, dressed up in a slick DSL. It's probably superfluous for most use cases, but I once worked on a project where this would have saved me a whole ten minutes.
