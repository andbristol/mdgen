require 'forwardable'

require 'mdgen/dsl'
require 'mdgen/markdown/table'
require 'mdgen/markdown'
require 'mdgen/version'

module MDGen
  extend self

  def md(**options, &block)
    renderer = Renderer.new(**options)
    give_renderer_get_markdown(renderer, &block)
  end

  def md_render(renderer, &block)
    raise ArgumentError, "Must pass a block" unless block
    dsl = DSL.new(renderer)
    dsl.instance_eval(&block)
    dsl.elements.join("\n")
  end
end
