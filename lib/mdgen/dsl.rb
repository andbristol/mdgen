module MDGen
  module DSL

    BLOCK_ELEMENTS = %i(h hh hhh hhhh hhhhh hhhhhh raw p quote list ul ol task_list code pre rule table).freeze
    SPAN_ELEMENTS = %i(link image).freeze
    MARKDOWN_METHODS = (BLOCK_ELEMENTS + SPAN_ELEMENTS).freeze

    class Basic

      extend Forwardable

      def_delegators Markdown, *MARKDOWN_METHODS
    end

    class Document

      extend Forwardable

      attr_reader :elements

      def_delegators Markdown, *SPAN_ELEMENTS

      def initialize
        @elements = []
      end

      BLOCK_ELEMENTS.each do |method|
        define_method(method) do |*args|
          @elements << Markdown.public_send(method, *args)
        end
      end
    end

  end
end
