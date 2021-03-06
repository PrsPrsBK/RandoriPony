module.exports = {
  'env': {
    'browser': true,
    'es6': true,
    'node': true,
    'webextensions': true
  },
  'extends': 'eslint:recommended',
  'parserOptions': {
      'sourceType': 'module'
  },
  'rules': {
    'func-style': [2, 'expression', {'allowArrowFunctions': true}],
    'func-call-spacing': [2, 'never'],
    'indent': [2, 2, {'SwitchCase': 1}],
    'linebreak-style': [2, 'windows'],
    'no-console': 0,
    'no-multi-assign': 2,
    'no-new-object': 2,
    'no-unused-vars': [2, {'vars': 'all', 'args': 'none'}],
    'no-use-before-define': [2, {'functions': true, 'classes': true, 'variables': true}],
    'operator-linebreak': [2, 'before'],
    'prefer-const': [2, {'ignoreReadBeforeAssign': true}],
    'quotes': [2, 'single'],
    'semi': [2, 'always'],
    'space-before-blocks': [0, 'always'],
    'space-before-function-paren': [2, {'anonymous': 'never', 'named': 'never'}],
    'space-in-parens': [2, 'never'],
    'space-infix-ops': 2,
    'space-unary-ops': 2,
    'unicode-bom': [2, 'never'],
  }
};
