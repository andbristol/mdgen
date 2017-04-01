module MDGen
  module Markdown

    extend self

    def atx_header(level, text = '')
      "#{'#' * level} #{text}"
    end

    def setext_title(text = '')
      "#{text}\n======"
    end

    def setext_subhead(text = '')
      "#{text}\n------"
    end

    def link(text, url)
      "[#{text}](#{url})"
    end

    def raw(text = '')
      text
    end
    alias_method :p, :raw

    def ul(items = [], &block)
      items.map { |item| "* #{item}" }.join("\n")
    end
    alias_method :list, :ul

    def ol(items = [], &block)
      items.each_with_index.map { |item, index| "#{index + 1}. #{item}"}.join("\n")
    end

    def code(text = '', decoration = '')
      "```#{decoration}\n#{text}\n```"
    end
  end
end
