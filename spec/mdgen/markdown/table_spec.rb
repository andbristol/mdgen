describe MDGen::Markdown::Table do
  describe '#table' do
    table = [
      ['apple', :artichoke, 1],
      ['bronson', :boy, 2],
      ['caramels', :briar, 99999]
    ]

    table_with_header = [
      ['strings', 'keywords', 'the longest field'],
      *table
    ]

    header_rendered = <<EOF
| strings  | keywords  | the longest field |
| -------- | --------- | ----------------- |
| apple    | artichoke | 1                 |
| bronson  | boy       | 2                 |
| caramels | briar     | 99999             |
EOF
    no_header_rendered = <<EOF
|          |           |       |
| -------- | --------- | ----- |
| apple    | artichoke | 1     |
| bronson  | boy       | 2     |
| caramels | briar     | 99999 |
EOF

    it 'makes a table with a header' do
      expect(MDGen::Markdown::Table.table(table_with_header)).to eq(header_rendered)
    end

    it 'makes a table with an empty header' do
      expect(MDGen::Markdown::Table.table(table, header: false)).to eq(no_header_rendered)
    end

    missing_cells = [
      ['apple', :artichoke],
      ['bronson', :boy, 2],
      ['caramels'],
      []
    ]

    missing_cells_rendered = <<EOF
|          |           |   |
| -------- | --------- | - |
| apple    | artichoke |   |
| bronson  | boy       | 2 |
| caramels |           |   |
|          |           |   |
EOF

    it 'fills in missing cells' do
      expect(MDGen::Markdown::Table.table(missing_cells, header: false)).to eq(missing_cells_rendered)
    end

    alignment = [:right, :left, :center]
    alignment_rendered = <<EOF
| strings  | keywords  | the longest field |
| --------:|:--------- |:-----------------:|
| apple    | artichoke | 1                 |
| bronson  | boy       | 2                 |
| caramels | briar     | 99999             |
EOF
    it 'adds alignment' do
      expect(MDGen::Markdown::Table.table(table_with_header, alignment: alignment)).to eq(alignment_rendered)
    end
  end
end
