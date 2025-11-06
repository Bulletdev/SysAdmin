<img src="public/syscover.png" alt="Project Logo" width="1920">

[![CI](https://github.com/bulletdev/SysAdmin/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/bulletdev/SysAdmin/actions/workflows/codeql-analysis.yml) [![License](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by-nc-sa/4.0/)


[![Ruby Version](https://img.shields.io/badge/ruby-3.4.5-CC342D?logo=ruby)](https://www.ruby-lang.org/)
[![Rails Version](https://img.shields.io/badge/rails-7.2-CC342D?logo=rubyonrails)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-blue.svg?logo=postgresql)](https://www.postgresql.org/)
[![Redis](https://img.shields.io/badge/Redis-6+-red.svg?logo=redis)](https://redis.io/)
[![Sidekiq](https://img.shields.io/badge/sidekiq-7.3-orange.svg)](https://sidekiq.org)

---
## Sumário

* [Tecnologias Utilizadas](#-tecnologias-utilizadas)
* [Pré-requisitos](#-pré-requisitos)
* [Configuração e Execução](#-configuração-e-execução)
* [Acesso à Aplicação](#-acesso-à-aplicação)
* [Contas de Demonstração](#-contas-de-demonstração)
* [Executando os Testes](#-executando-os-testes)
* [Comandos Úteis](#-comandos-úteis)
* [Tutorial](#-tutorial)
* [Funcionalidades](#-funcionalidades)
* [Soluções Simplificadas](#-soluções-simplificadas)

---

## ️ Tecnologias Utilizadas

* **Backend:** Ruby 3.4.5, Rails 7.2
* **Banco de Dados:** PostgreSQL 15+
* **Frontend:** Hotwire (Turbo/Stimulus), Tailwind CSS
* **Testes:** RSpec, FactoryBot, Capybara, 
* **Lint & Security:** Rubocop, OWASP Top 10, brakeman, Nuclei, Semgrep, Trivy, Dependency-Check
* **Containerização:** Docker e Docker Compose v2

## Preview

<details>
  <summary>Clique para ver a galeria de screenshots</summary>

  <br>
  <table border="0">
    <tr>
      <td align="center">
        <strong>Interface de Usuários</strong><br>
        <img src="public/preview/Users.jpg" alt="Screenshot da tela de usuários" width="400">
      </td>
      <td align="center">
        <strong>Dashboard Principal</strong><br>
        <img src="public/preview/Dashboard.jpg" alt="Screenshot do dashboard" width="400">
      </td>
    </tr>
    <tr>
      <td align="center">
        <strong>Index</strong><br>
        <img src="public/preview/Index.jpg" alt="Screenshot da tela inicial" width="400">
      </td>
      <td align="center">
        <strong>Perfil do Usuário</strong><br>
        <img src="public/preview/Profile.jpg" alt="Screenshot da tela de perfil" width="400">
      </td>
    </tr>
  </table>

</details>

---
## K6 Test & Security

<details>
  <summary>Clique para ver os teste de carga e segurança</summary>

  <br>
  <table border="0">
    <tr>
      <td align="center">
        <strong>Teste de carga</strong><br>
        <img src="public/preview/k6.PNG" alt="k6 testando usuários" width="400">
      <td align="center">
        <strong>Teste de carga 2</strong><br>
        <img src="public/preview/K62.PNG" alt="k6 testando usuários" width="400">
    </tr>
      <td align="center">
        <strong>Teste de segurança</strong><br>
        <img src="public/preview/SECURITY.PNG" alt="k6 testando segurança" width="400">
      </td>
      <td align="center">
        <strong>Teste de segurança 2</strong><br>
        <img src="public/preview/SECURITY2.PNG" alt="k6 testando segurança" width="400">
      </td>
    </tr>
  </table>

</details>

##  Pré-requisitos

Para executar este projeto, você precisará ter instalados **apenas**:

* **Docker**
* **Docker Compose (v2 ou superior)**

> **Nota:** Não é necessário ter Ruby, Rails ou PostgreSQL instalados localmente. 

> Todas as dependências do projeto são gerenciadas pelos containers Docker.

---

##  Configuração e Execução

Siga estes passos para configurar e iniciar a aplicação:

**1. Clonar o Repositório**

```bash
git clone https://github.com/bulletdev/sysadmin.git
cd sysadmin
````
git checkout to Md-test branch

**2. Configurar Variáveis de Ambiente**

O projeto requer um arquivo `.env` para as variáveis de ambiente (como credenciais do banco).

```bash
# Copie o arquivo de exemplo para criar seu arquivo .env local
cp .env.example .env
```

Valores recomendados para desenvolvimento:
- `DATABASE_URL=postgres://postgres:postgres@db:5432/Fullstack_Developer_development`
- `RAILS_ENV=development`

**3. Construir as Imagens Docker**

Este comando irá construir a imagem da aplicação web (`web`) conforme definido no `Dockerfile`.

```bash
docker compose up -d --build
```

**4. Preparar o Banco de Dados**

Com os containers em execução, prepare o ambiente de desenvolvimento e aplique migrações/seeds.

```bash
docker compose exec web bash -lc "bin/rails db:environment:set RAILS_ENV=development && bin/rails db:migrate && bin/rails db:seed"
```

-----

##  Acesso à Aplicação

Após seguir os passos de configuração, a aplicação estará disponível no seu navegador:

* **URL:** [http://localhost:4040](http://localhost:4040)
  *(A porta `4040` do seu host é mapeada para a porta `3000` dentro do container Rails)*

---

##  Contas de Demonstração

Para facilitar os testes, a aplicação vem com contas pré-cadastradas:

### Administrador
* **E-mail:** `admin@example.com`
* **Senha:** `password123`

### Usuários Comuns
* **E-mails:** `user1@example.com`, `user2@example.com`, `user3@example.com`, `user4@example.com`, `user5@example.com`
* **Senha:** `password123`

> **Dica:** Use a conta de administrador para acessar o painel administrativo e gerenciar usuários.

-----

##  Executando os Testes

Para executar a suíte de testes RSpec, utilize o seguinte comando:

```bash
docker compose exec web bash -lc "bin/rails db:environment:set RAILS_ENV=test && bin/rails db:prepare && bundle exec rspec"
```

-----

# Guia de Testes de carga

## Cenário Recomendado (Linux + Docker)

- **Pré-requisitos**: Docker e Docker Compose instalados.
- **Porta alvo**: 4040 (está mapeada no docker-compose.yml).
- **Subir serviços**:
  ```
  docker compose up -d db web
  ```
- **Preparar banco e seeds** (cria user1@example.com / password123):
  ```
  docker compose exec web bash -lc "bundle exec rails db:prepare && bundle exec rails db:seed"
  ```
- **Rodar o k6 com o cenário do SysAdmin usando container**:
  ```
  docker run --rm -e BASE_URL=http://host.docker.internal:4040 -e TEST_EMAIL=user1@example.com -e TEST_PASSWORD=password123 -v ${PWD}/load_tests:/scripts grafana/k6 run /scripts/scenarios/sysadmin-smoke.js
  ```
- **Interpretação do “passa”**:
  - Checks do k6 sem falhas (status 200/302 nas páginas).
  - http_req_failed próximo de 0.
  - Tempo p95 dentro de thresholds do smoke (500ms na configuração padrão do smoke).

## Sem Docker (Linux nativo)

- **Dependências**: Ruby 3.4.5, Bundler, Node, Postgres.
- **Ajuste config/database.yml** para apontar host: localhost (ou seu host de Postgres) e credenciais válidas.
- **Instalar deps e subir Rails**:
  ```
  bundle install
  bin/rails db:setup  # (cria e popula com seeds)
  bin/rails s -p 4040 -b 0.0.0.0
  ```
- **Instalar k6**:
  - Ubuntu:
    ```
    sudo apt-get install k6
    ```
- **Rodar o smoke**:
  ```
  BASE_URL=http://localhost:4040 TEST_EMAIL=user1@example.com TEST_PASSWORD=password123 k6 run load_tests/scenarios/sysadmin-smoke.js
  ```

##  Comandos Úteis

Aqui estão alguns comandos úteis do Docker Compose para gerenciar o ambiente:

* **Parar a aplicação:**

  ```bash
  docker compose down
  ```

* **Parar e remover volumes (limpeza total, remove os dados do DB):**

  ```bash
  docker compose down -v
  ```

* **Forçar a reconstrução das imagens (após mudar o Gemfile ou Dockerfile):**

  ```bash
  docker compose up -d --build
  ```

* **Acessar o console do Rails:**

  ```bash
  docker compose run --rm web bin/rails c
  ```

* **Executar um comando de terminal dentro do container web:**

  ```bash
  docker compose run --rm web bash
  ```

<!-- end list -->

 ---

## Guia rápido: testes e análise de resultados

- Subir app e banco:
  - `docker compose up -d db web`
  - `docker compose exec web bash -lc "bundle exec rails db:prepare && bundle exec rails db:seed"`

- Smoke de carga (k6 via Docker):
  - `docker run --rm -e BASE_URL=http://host.docker.internal:4040 -e TEST_EMAIL=user1@example.com -e TEST_PASSWORD=password123 -v ${PWD}/load_tests:/scripts grafana/k6 run /scripts/scenarios/sysadmin-smoke.js`
  - Interpretação: `checks_succeeded ~ 100%`, `http_req_failed ~ 0%`, latências dentro dos thresholds do cenário.

- Suíte de segurança (containers):
  - Criar/garantir rede externa: `docker network create rails-docker_network` (ignorado se já existir)
  - Conectar o `web` à rede: `docker network connect rails-docker_network $(docker compose ps -q web)`
  - Subir scanners: `docker compose -f security_tests/docker-compose.security.yml up -d`
  - Executar individualmente (exemplos):
    - Semgrep: `docker exec sysadmin-semgrep semgrep --config=auto --json --output=/reports/semgrep-report.json /src`
    - Trivy: `docker exec sysadmin-trivy trivy fs --format json --output /reports/trivy-report.json /app`
    - Nuclei: `docker exec sysadmin-nuclei nuclei -u http://web:4040 -jsonl -o /reports/nuclei-report.jsonl`
    - ZAP Baseline: `docker exec sysadmin-zap zap-baseline.py -t http://web:4040 -I -J /zap/reports/zap-report.json -r /zap/reports/zap-report.html`
    - Brakeman: `docker exec sysadmin-brakeman brakeman --rails7 --output /reports/brakeman-report.html --format html`

- Onde estão os relatórios:
  - `security_tests/reports/semgrep/semgrep-report.json`
  - `security_tests/reports/trivy/trivy-report.json`
  - `security_tests/reports/nuclei/nuclei-report.jsonl`
  - `security_tests/reports/brakeman/brakeman-report.html`
  - `security_tests/zap/reports/zap-report.html` e `zap-report.json`

- Dicas de análise:
  - Semgrep: priorize regras `critical`/`high`, triando falsos positivos; registre supressões com justificativa.
  - Trivy: foque em `CRITICAL`/`HIGH` com `Fix Version` disponível; avalie segredos e misconfigs.
  - Nuclei/ZAP: valide achados manualmente; para páginas autenticadas, considere configurar ZAP com sessão.
  - Brakeman: revise `High Confidence` com `High Warning` primeiro.

- Troubleshooting comum:
  - "Name or service not known" no ZAP/Nuclei: garanta que `web` está conectado à `rails-docker_network`.
  - Nuclei sem `-json`: use `-jsonl` (versões recentes).
  - Acesso do k6 bloqueado: `host.docker.internal` já está permitido em `config/environments/development.rb`.

Para guia completo e mais exemplos, veja `security_tests/README.md`.

 ---

## Setup Local (Linux)

Caso prefira rodar fora do Docker (ex.: desenvolvimento em Linux), siga:

1) Dependências (Debian/Ubuntu):
- `sudo apt update`
- `sudo apt install -y build-essential libssl-dev libreadline-dev zlib1g-dev libpq-dev git curl`

2) Ruby e Bundler:
- Ruby `3.4.5` (vide `.ruby-version`).

---

## Solução de Problemas

- "You are attempting to modify a database that was last run in test environment":
  - Desenvolvimento:
    ```bash
    docker compose exec web bash -lc "bin/rails db:environment:set RAILS_ENV=development"
    ```
  - Testes:
    ```bash
    docker compose exec web bash -lc "bin/rails db:environment:set RAILS_ENV=test && bin/rails db:prepare"
    ```
- via asdf: `asdf plugin add ruby && asdf install ruby 3.4.5 && asdf global ruby 3.4.5`
- ou rbenv: `rbenv install 3.4.5 && rbenv global 3.4.5`
- `gem install bundler`

3) Gems e ambiente:
- `bundle install`
- `cp .env.example .env` e ajuste variáveis (DB etc.)

4) Banco de dados:
- Configure `config/database.yml` para seu PostgreSQL local
- `bin/rails db:setup` (ou `db:create db:migrate db:seed`)

5) Subir o servidor:
- `bin/rails server -p 3000`
- Acesse `http://localhost:3000/`

### Rotas úteis
- Home: `/`
- Login: `/users/sign_in`
- Cadastro: `/users/sign_up`
- Perfil: `/user_profile`
- Soluções: `/solutions` e subrotas (`/solutions/evaluations`, `/solutions/goals`, etc.)

### Testes
- `bundle exec rspec`

### Rubocop 
- `bundle exec rubocop`

```
docker-compose exec -T web bundle exec rubocop
```
### Observações
- Se aparecer erro de gems faltando, rode `bundle install`.
- Tailwind via `tailwindcss-rails`; importmap dispensa Node/Yarn.

##  Tutorial

Para um guia completo de setup, uso e troubleshooting (incluindo dicas para o Postgres, healthcheck e comandos úteis), consulte `docs/tutorial.md`.

---

##  Funcionalidades

### Painel Administrativo
* **Dashboard:** Visão geral com estatísticas e métricas
* **Gestão de Usuários:** CRUD completo de usuários com importação em lote (CSV)
* **Alternância de Papéis:** Alternar entre usuário comum e administrador com um clique
* **Busca e Filtros:** Encontrar usuários rapidamente

### Perfil do Usuário
* **Edição de Dados:** Atualizar informações pessoais
* **Mudança de Senha:** Interface estilizada e segura
* **Exclusão de Conta:** Com confirmação de segurança

### Sistema de Autenticação
* **Login/Logout:** Sistema completo com Devise
* **Recuperação de Senha:** Via e-mail com tokens seguros
* **Sessões:** Lembrar usuário entre sessões

### Interface Responsiva
* **Design Moderno:** Tailwind CSS com componentes modernos
* **Mobile First:** Totalmente responsivo para dispositivos móveis
* **Temas:** Interface limpa e profissional

---

##  Troubleshooting (Migrações, Seeds e Login)

- Erro de migração pendente (ActiveRecord::PendingMigrationError):
  - Rode dentro do container: `docker compose exec web bin/rails db:migrate`.
  - Se estiver fora do Docker, conecte ao Postgres do container via porta mapeada `25432`:
    - PowerShell (Windows):
      - `$env:DATABASE_URL='postgres://postgres:postgres@localhost:25432/Fullstack_Developer_development'; $env:RAILS_ENV='development'; bin/rails db:migrate`

- Rodar seeds (cria/atualiza usuário admin e usuários de exemplo):
  - `docker compose exec web bin/rails db:seed`
  - Alternativa fora do Docker (PowerShell):
    - `$env:DATABASE_URL='postgres://postgres:postgres@localhost:25432/Fullstack_Developer_development'; $env:RAILS_ENV='development'; bin/rails db:seed`

- Login retornando 422 (Unprocessable Content):
  - Geralmente credenciais inválidas. Use:
    - Admin: `admin@example.com` / `password123`
    - Usuários: `user1@example.com` … `user5@example.com` / `password123`
  - Se ainda falhar, rode `db:seed` novamente e verifique o status das migrações:
    - `docker compose exec web bin/rails db:migrate:status`

---

## 📊 Charts no Dashboard (Chart.js + Stimulus)

- O projeto utiliza Chart.js via Importmap e um controlador Stimulus em `app/javascript/controllers/charts_controller.js`.
- Pin atual (UMD) no `config/importmap.rb`:
  - `pin "chart.js", to: "https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.js"`
- Import no controlador (default import para UMD):
  - `import Chart from "chart.js"`
- Caso apareça o erro: `doesn't provide an export named: 'Chart'`, verifique se o import é default, não named.

### Alternativa ESM
- Se preferir ESM:
  - Mude o pin para: `pin "chart.js", to: "https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.esm.js"`
  - E importe: `import Chart from "chart.js/auto"`

### Verificação visual
- Após migrações e seeds, acesse `http://localhost:4040/admin/dashboard` e confira a renderização dos gráficos.

---

##  Soluções Simplificadas

Inspirado na Umanni, adicionei páginas estáticas que descrevem módulos de People Ops para demonstrar capacidades e direcionar evolução futura:

- Rotas:
  - `/solutions` (índice)
  - `/solutions/succession` (Planos de Sucessão)
  - `/solutions/evaluations` (Avaliações)
  - `/solutions/goals` (Metas)
  - `/solutions/feedbacks` (Feedbacks)
  - `/solutions/pdi` (PDI)
  - `/solutions/talent_matrix` (Matriz de Talentos)

- Documentação de regras de negócio: `docs/use_cases.md`.

As páginas servem como MVP de conteúdo e base para futura implementação funcional.

---

##  Preview Estático

Para validar visualmente a Home sem subir Rails, use:
- `python3 -m http.server 5500 --directory public`
- Acesse `http://localhost:5500/indexbak.html`

Notas:
- Links do Devise (`/users/sign_in`, `/users/sign_up`) retornam 404 no preview (sem backend). No Rails, funcionam.
- Header usa logo real `public/SysAdminLogo.png`.

---

## Repaginada da Home

- A Home Rails (`app/views/home/index.html.erb`) usa o layout global (`app/views/layouts/application.html.erb`), preservando cabeçalho, logotipo e rodapé.
- CTAs condicionais:
  - Logado: `Abrir Dashboard` (se admin) e `Ver Perfil`.
  - Não logado: `Criar conta` e `Entrar` (helpers do Devise).
- Preview estático equivalente em `public/index.html` para validação rápida de UI.

---

##  Engine

Este projeto inclui um esqueleto de engine Rails para modularização:

- Caminho: `engines/sysadmin_core`
- Como incluir: adicionar ao `Gemfile` do app host `gem 'sysadmin_core', path: 'engines/sysadmin_core'`.
- Objetivo: facilitar reuso e futura publicação como gem.

Após incluir, rode `docker compose run --rm web bundle install`.

```
```


# Copyright & License

© 2025 BulletOnRails .  
All rights reserved.


O código-fonte contido aqui é disponibilizado sob a licença Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

Você pode encontrar o texto completo da licença no arquivo [LICENSE](license.md) neste repositório.

Shield:

[![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg
