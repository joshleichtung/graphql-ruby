class GraphQL::Query::FragmentSpreadResolutionStrategy
  attr_reader :result
  def initialize(ast_fragment_spread, type, target, operation_resolver)
    fragments = operation_resolver.query.fragments
    fragment = fragments[ast_fragment_spread.name]
    child_type = operation_resolver.query.schema.types[fragment.type]
    resolved_type = GraphQL::Query::TypeResolver.new(target, child_type, type).type
    if resolved_type.nil?
      @result = {}
    else
      selections = fragment.selections
      resolver = GraphQL::Query::SelectionResolver.new(target, resolved_type, selections, operation_resolver)
      @result = resolver.result
    end
  end
end
