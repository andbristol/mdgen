module MDGen
  class DSL

    MARKDOWN_METHODS = %i(h hh hhh hhhh hhhhh hhhhhh raw p quote list ul ol code pre rule table link image).freeze

    attr_reader :elements

    def initialize
      @elements = []
    end

    MARKDOWN_METHODS.each do |method|
      define_method(method) do |*args|
        @elements << Markdown.public_send(method, *args)
      end
    end
  end
end
