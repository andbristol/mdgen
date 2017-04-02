module MDGen
  class Renderer

    extend Forwardable

    attr_accessor :headers

    DELEGATED_METHODS = %i(raw p quote list ul ol code pre rule link image)

    def_delegators Markdown, *DELEGATED_METHODS

    def initialize(headers: :atx)
      @headers = headers
    end

  end
end
