module MDGen
  module Markdown
    module Table

      extend self

      def table(rows, header: true, alignment: nil)
        max_row_size = rows.map(&:length).max

        rows.each do |row|
          if row.length < max_row_size
            empty_cells = [''] * (max_row_size - row.length)
            row.concat(empty_cells)
          end
        end

        unless header
          empty_row = [''] * max_row_size
          rows.unshift(empty_row)
        end

        rendered_rows, column_lengths = render_rows(rows)

        header_row = rendered_rows.shift
        rule_row = rule_row(column_lengths, alignment: alignment)
        [header_row, rule_row, *rendered_rows].join("\n") + "\n"
      end

      private

      def render_rows(rows)
        rows_s = rows.map do |row|
          row.map(&:to_s)
        end

        column_lengths = rows_s.transpose.map do |column|
          column.map(&:length).max
        end

        rendered_rows = rows_s.map do |row|
          padded = row.each_with_index.map do |item, index|
            item + (' ' * (column_lengths[index] - item.length))
          end
          "| #{padded.join(' | ')} |"
        end

        [rendered_rows, column_lengths]
      end

      def rule_row(column_lengths, alignment: nil)
        rules = column_lengths.map { |length| '-' * length}
        if alignment
          rules.zip(alignment).reduce('|') do |partial, column|
            rule, alignment = column
            next_cell = case alignment
            when :left
              ":#{rule} |"
            when :right
              " #{rule}:|"
            when :center
              ":#{rule}:|"
            end
            partial + next_cell
          end
        else
          "| #{rules.join(' | ')} |"
        end
      end

    end
  end
end
