module MDGen
  module Markdown

    include Table

    extend self

    HEADER_LEVEL_RANGE = (1..6)

    # block elements

    def raw(text = '')
      text
    end

    def p(text = '')
      "#{text}\n"
    end

    def header(level, text = '')
      "#{'#' * level} #{text}\n"
    end

    HEADER_LEVEL_RANGE.each do |level|
      define_method(('h' * level).to_sym) do |text|
        header(level, text)
      end
    end

    def quote(text = '')
      text.each_line.map { |line| "> #{line}"}.join
    end

    def ul(items = [])
      items.map { |item| "* #{item}\n" }.join
    end
    alias_method :list, :ul

    def ol(items = [])
      items.each_with_index.map { |item, index| "#{index + 1}. #{item}\n"}.join
    end

    def task_list(items = [])
      items.map do |text, checked|
        if checked
          "- [x] #{text}\n"
        else
          "- [ ] #{text}\n"
        end
      end.join
    end

    def code(text = '', decoration = '')
      "```#{decoration}\n#{text.chomp}\n```\n"
    end
    alias_method :pre, :code

    def rule
      "* * *\n"
    end

    # span elements

    def link(text, url)
      "[#{text}](#{url})"
    end

    def image(text, url, title: nil)
      if title
        "![#{text}](#{url} \"#{title}\")"
      else
        "![#{text}](#{url})"
      end
    end
  end
end
