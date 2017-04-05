describe MDGen do
  describe '#document' do

    it 'generates markdown' do
      expected = <<EOF
# The title

Once upon a time

* There
* Were
* Some

## Doggos

| name    | age | good boy? |
| ------- | --- | --------- |
| toby    | 2   | true      |
| charlie | 4   | yes       |
| ralph   | 2   | vv good   |

> This is where
> there would be a quote
> if I could think of one

### Third subhead

This is raw text, so it won't get an extra newline
#### Fourth subhead

```java
// trade secrets do not steal
for (;;) {
  System.out.println("lol");
}
```

How about an ordered list

1. When the moon
2. Hits your eye
3. Like a big
4. Piece of pie

##### Fifth subhead

* * *

###### Sixth subhead

links are an [inline element](http://example.com) in this part

images are inline ![an image](http://example.com) elements too
EOF

      actual = MDGen.document do
        h 'The title'

        p 'Once upon a time'

        list [
          'There',
          'Were',
          'Some'
        ]

        hh 'Doggos'

        table [
          [ 'name', 'age', 'good boy?'],
          ['toby', 2, true],
          ['charlie', 4, 'yes'],
          ['ralph', 2, 'vv good']
        ]

        quote "This is where\nthere would be a quote\nif I could think of one\n"

        hhh 'Third subhead'

        raw "This is raw text, so it won't get an extra newline"

        hhhh 'Fourth subhead'

        java = <<EOF
// trade secrets do not steal
for (;;) {
  System.out.println("lol");
}
EOF
        code java, 'java'

        p 'How about an ordered list'

        ol [
          'When the moon',
          'Hits your eye',
          'Like a big',
          'Piece of pie'
        ]

        hhhhh 'Fifth subhead'

        rule

        hhhhhh 'Sixth subhead'

        p "links are an #{link('inline element', 'http://example.com')} in this part"
        p "images are inline #{image('an image', 'http://example.com')} elements too"
      end

      expect(actual).to eq(expected)
    end
  end

  describe '#md' do

    expected = <<EOF
# the title

A paragraph with some text

* one
* two
* three
EOF

    it 'exposes markdown methods inside the block' do

      actual = ''
      elements = ['one', 'two', 'three']

      MDGen.md do
        actual << h('the title')
        actual << "\n"
        actual << p('A paragraph with some text')
        actual << "\n"
        actual << list(elements)
      end

      expect(actual).to eq(expected)
    end
  end
end
