describe MDGen do
  describe '#md' do

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

[links are a little broken](http://example.com)
![images too](http://example.com)
We'll fix them
EOF

      actual = MDGen.md do
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

        link 'links are a little broken', 'http://example.com'
        image 'images too', 'http://example.com'

        p "We'll fix them"
      end

      expect(actual).to eq(expected)
    end
  end
end
