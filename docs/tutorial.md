# Tutorial SysAdmin

Este tutorial orienta a subir o projeto com Docker, acessar as principais rotas, usar as contas de demonstração e solucionar problemas comuns (incluindo a lentidão na subida do Postgres em alguns ambientes).

---

## Sumário

- Setup rápido
- Subir e acessar a aplicação
- Contas de demonstração
- Fluxos principais
- Troubleshooting (Postgres lento, seeds, rebuild)
- Dicas de performance no Docker Desktop
- Comandos úteis

---

## Setup rápido

- Pré-requisitos: `Docker` e `Docker Compose v2`.
- Clonar: `git clone <repo> && cd sysadmin`.
- Subir: `docker compose up -d --build`.
- Setup do DB (primeira vez):
  - Aguarde o Postgres inicializar a base de dados (pode levar ~30–60s na primeira execução).
  - Rode o setup quando o DB estiver pronto: `docker compose run --rm web bin/rails db:setup`.

---

## Subir e acessar a aplicação

- Iniciar/atualizar containers: `docker compose up -d --build`.
- Acessar no navegador: `http://localhost:4040`.
- Logs do web: `docker compose logs -f web`.
- Logs do db: `docker compose logs -f db`.

---

## Contas de demonstração

- Administrador:
  - E-mail: `admin@example.com`
  - Senha: `password123`
- Usuários comuns:
  - E-mails: `user1@example.com` … `user5@example.com`
  - Senha: `password123`
- Recriar/garantir contas: `docker compose exec web bin/rails db:seed`

---

## Fluxos principais

- Login: `http://localhost:4040/users/sign_in`.
- Perfil: `http://localhost:4040/user_profile`.
- Editar cadastro/senha: `http://localhost:4040/users/edit` (após logar).
- Dashboard Admin: `http://localhost:4040/admin/dashboard` (visível apenas para admin).

---

## Troubleshooting

### Postgres demorando para subir

- Primeira inicialização do volume (`pg_data`) cria o cluster do Postgres e pode levar ~30–60s.
- Em Windows, o filesystem compartilhado pode ser mais lento. Use WSL2 backend no Docker Desktop para melhor performance.
- Verifique readiness:
  - `docker compose logs -f db` (procure mensagens "database system is ready to accept connections").
  - `docker exec rails-docker_db pg_isready -U postgres -h localhost` (deve retornar "accepting connections").

### Seeds e usuários demo

- Rodar seeds: `docker compose exec web bin/rails db:seed`.
- Caso dê erro de e-mail já cadastrado, os seeds foram tornados idempotentes; rodar novamente resolve.

### Reset total do ambiente

- Parar e remover containers: `docker compose down`.
- Remover volumes (apaga dados): `docker compose down -v`.
- Subir novamente: `docker compose up -d --build`.

---

## Dicas de performance no Docker Desktop

- Ativar WSL2 backend (Windows) nas configurações do Docker Desktop.
- Limitar compartilhamento de pastas e evitar antivírus escaneando diretórios de volumes.
- Evitar rebuild completo quando desnecessário; use `docker compose up -d` se não alterou `Gemfile`/`Dockerfile`.
- Cache de bundler no container já está habilitado via volume `rails-docker_bundle`.

### Healthcheck e readiness (opcional)

- Adicione um `healthcheck` ao serviço `db` e faça o `web` depender do estado saudável para evitar iniciar antes do Postgres estar pronto.

Exemplo de trecho para `docker-compose.yml`:

```yaml
services:
  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 3s
      retries: 10

  web:
    depends_on:
      db:
        condition: service_healthy
```

Alternativa: esperar no comando do `web`:

```yaml
command: bash -c "until pg_isready -h db -p 5432 -U postgres; do echo 'Aguardando Postgres...'; sleep 1; done; rm -f tmp/pids/server.pid && bundle exec rails s -p 4040 -b '0.0.0.0'"
```

---

## Comandos úteis

- Console Rails: `docker compose run --rm web bin/rails c`
- RSpec: `docker compose run --rm web bundle install && docker compose run --rm web bundle exec rspec`
- Acompanhar logs: `docker compose logs -f web` e `docker compose logs -f db`
- Recriar admin rapidamente (via console):

```ruby
User.find_or_create_by(email: 'admin@example.com') do |u|
  u.password = 'password123'
  u.role = 'admin'
end
```

---

## Próximos passos (ideias)

- Empacotar como gem/engine para reuso — fora do escopo imediato, mas viável.
- Otimizar Dockerfile com cache avançado e buildkit se necessário.