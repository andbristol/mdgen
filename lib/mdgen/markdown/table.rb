module MDGen
  module Markdown
    module Table

      extend self

      # TODO refactor this method
      def table(rows, header: true, alignment: nil)
        max_row_size = rows.map(&:length).max

        # if alignment.length != max_row_size
        #  raise ArgumentError, "Given only #{alignment.length} alignments for #{max_row_size} rows"
        # end
        # TODO validate alignments

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

        header_row = rendered_rows.shift
        rules = column_lengths.map { |length| '-' * length}
        rule_row =
          if alignment
            rule_row = rules.zip(alignment).reduce('|') do |partial, column|
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
            rule_row = "| #{rules.join(' | ')} |"
          end
        [header_row, rule_row, *rendered_rows].join("\n")
      end
    end
  end
end
