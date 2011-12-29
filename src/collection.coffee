{Monkey} = require './monkey'

class Monkey.Collection
  Monkey.extend(@prototype, Monkey.Events)
  constructor: (@list) ->
    @length = @list.length
    @bind("change", => @length = @list.length)
  get: (index) -> @list[index]
  set: (index, value) ->
    @list[index] = value
    @trigger("change:#{index}", value)
    @trigger("set", index, value)
    @trigger("change", @list)
  push: (element) ->
    @list.push(element)
    @trigger("add", element)
    @trigger("change", @list)
  update: (list) ->
    @list = list
    @trigger("update", list)
    @trigger("change", @list)
  forEach: (fun) ->
    Monkey.forEach(@list, fun)
  indexOf: (item) ->
    @list.indexOf(item)
  deleteAt: (index) ->
    @list.splice(index, 1)
    @trigger("delete", index)
    @trigger("change", @list)
  delete: (item) ->
    @deleteAt(@indexOf(item))
