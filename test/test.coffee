{ createElement } = require 'react'
{ assert } = require 'chai'
{ fake } = require 'sinon'
{ clientHandler, react } = require '../lib'

before () ->
  taiko = {
    client: () -> await {
      Runtime: {
        evaluate: fake()
      }
    }
  }
  clientHandler taiko

describe 'Validation', () ->
  it 'rejects a selector that does not exist', () ->
    try
      await react()
    catch error
      assert.equal error.message, 'Selector needs to be either a string or an object'
  
  it 'accepts a selector that exists', () ->
    assert.doesNotThrow (() -> await react 'Header'),
    'Selector needs to be either a string or an object'
  
  it 'rejects a selector that is an object but not a React element', () ->
    try
      await react(react createElement 'Cat')
    catch error
      assert.equal error.message, 'Could not ascertain the type of this React component'

  it 'accepts a selector that is a React element', () ->
    assert.doesNotThrow (() -> await react createElement 'Something'),
    'Could not ascertain the name of this React component'