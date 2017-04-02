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

    def self.build(renderer, &block)
      raise ArgumentError, 'Must pass a block' unless block
      dsl = self.new
      dsl.instance_eval(&block)
      dsl.elements.join("\n")
    end
  end
end
