module MDGen
  module Markdown

    extend self

    # block elements

    def raw(text = '')
      text
    end
    alias_method :p, :raw

    def atx_header(level, text = '')
      "#{'#' * level} #{text}"
    end

    def setext_title(text = '')
      "#{text}\n======"
    end

    def setext_subhead(text = '')
      "#{text}\n------"
    end

    def quote(text = '')
      text.each_line.map { |line| "> #{line}"}.join
    end

    def ul(items = [])
      items.map { |item| "* #{item}" }.join("\n")
    end
    alias_method :list, :ul

    def ol(items = [])
      items.each_with_index.map { |item, index| "#{index + 1}. #{item}"}.join("\n")
    end

    def code(text = '', decoration = '')
      "```#{decoration}\n#{text}\n```"
    end
    alias_method :pre, :code

    def rule
      '* * *'
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
