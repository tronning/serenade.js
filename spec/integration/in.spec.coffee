{Serenade} = require '../../src/serenade'

describe 'In', ->
  beforeEach ->
    @setupDom()

  it 'changes the context to a subobject', ->
    model = { author: { name: 'jonas' } }

    @render '''
      article
        - in @author
          p[id=name]
    ''', model
    expect(@body).toHaveElement('article > p#jonas')

  it 'updates when the subobject is changed', ->
    model = new Serenade.Model( author: { name: 'jonas' } )

    @render '''
      article
        - in @author
          p[id=name]
    ''', model
    expect(@body).toHaveElement('article > p#jonas')
    model.set(author: { name: 'peter' })
    expect(@body).toHaveElement('article > p#peter')
    expect(@body).not.toHaveElement('article > p#jonas')

  it 'updates when a property on the subobject is changed', ->
    model = { author: new Serenade.Model( name: 'jonas' ) }

    @render '''
      article
        - in @author
          p[id=name]
    ''', model
    expect(@body).toHaveElement('article > p#jonas')
    model.author.set(name: 'peter')
    expect(@body).toHaveElement('article > p#peter')
    expect(@body).not.toHaveElement('article > p#jonas')
