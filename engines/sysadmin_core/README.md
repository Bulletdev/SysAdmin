# SysAdmin Core Engine

Engine Rails mínima para modularizar partes do SysAdmin e permitir reuso como gem local.

## Estrutura

- `lib/sysadmin_core.rb`: módulo base
- `lib/sysadmin_core/version.rb`: versão
- `lib/sysadmin_core/engine.rb`: definição do engine

## Uso

No `Gemfile` do app host:

```ruby
gem 'sysadmin_core', path: 'engines/sysadmin_core'
```

Depois, rode `bundle install` no container.