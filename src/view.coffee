{Monkey} = require './monkey'
{parser} = require './parser'
{Nodes} = require './nodes'

parser.lexer =
  lex: ->
    [tag, @yytext, @yylineno] = @tokens[@pos++] or ['']
    tag
  setInput: (@tokens) ->
    @pos = 0
  upcomingInput: ->
    ""

class Monkey.View
  constructor: (@string) ->
  parse: ->
    parser.parse(new Monkey.Lexer().tokenize(@string))
  render: (document, model, controller) ->
    node = Nodes.compile(@parse(), document, model, controller)
    controller.model = model
    controller.view = node.element
