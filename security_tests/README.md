# SysAdmin - Security Testing Lab

Laboratório completo de testes de segurança para o projeto SysAdmin (Rails), 

incluindo análise estática, dinâmica e varredura de vulnerabilidades.

--- BulletOnRails ---


## Ferramentas Incluídas

| Ferramenta | Tipo | Descrição |
|------------|------|-----------|
| **OWASP ZAP** | DAST | Análise dinâmica de segurança web |
| **Brakeman** | SAST | Analisador de segurança específico para Rails |
| **Semgrep** | SAST | Análise estática de código com regras customizáveis |
| **Trivy** | SCA | Scanner de vulnerabilidades em dependências |
| **Dependency-Check** | SCA | Análise de vulnerabilidades conhecidas (CVE) |
| **Nuclei** | DAST | Scanner de vulnerabilidades web rápido |

##  Quick Start

### 1. Iniciar o Laboratório Completo

\`\`\`bash
docker compose up -d web
docker compose -f security_tests/docker-compose.security.yml up -d
\`\`\`

Isso irá:
- ✅ Iniciar a aplicação SysAdmin (serviço `web` na porta 4040)
- ✅ Subir os containers de ferramentas de segurança
- ✅ Conectar tudo na rede externa `rails-docker_network`

### 2. Executar Todos os Scans

\`\`\`bash
./security_tests/run-security-scans.sh
# ou no Windows PowerShell
./security_tests/run-security-scans.ps1
\`\`\`

### 3. Parar o Laboratório

\`\`\`bash
./security_tests/stop-security-lab.sh
\`\`\`

## Notas importantes e correções

- Rede externa necessária:
  ```bash
  docker network create rails-docker_network
  docker network connect rails-docker_network $(docker compose ps -q web)
  ```
  Se ZAP/Nuclei não resolvem `web`, é porque o container `web` não está na rede.

- Windows PowerShell (parametrizar a URL da aplicação):
  ```powershell
  ./security_tests/run-security-scans.ps1 -ApiUrl http://web:4040
  ```

- Nuclei (formato JSONL nas versões recentes):
  ```bash
  docker exec sysadmin-nuclei nuclei -u http://web:4040 -jsonl -o /reports/nuclei-report.jsonl
  ```

- ZAP Baseline (ignorar algumas falhas informativas):
  ```bash
  docker exec sysadmin-zap zap-baseline.py -t http://web:4040 -I -J /zap/reports/zap-report.json -r /zap/reports/zap-report.html
  ```

- Dica de troubleshooting rápido:
  ```bash
  docker compose ps web
  docker compose logs -f web
  curl -I http://localhost:4040
  ```

## 📊 Relatórios

Após executar os scans, os relatórios estarão disponíveis em:

```
security_tests/
├── reports/
│   ├── brakeman/
│   │   └── brakeman-report.html
│   ├── dependency-check/
│   │   ├── dependency-check-report.html
│   │   └── dependency-check-report.json
│   ├── semgrep/
│   │   └── semgrep-report.json
│   ├── trivy/
│   │   └── trivy-report.json
│   └── nuclei/
│       └── nuclei-report.json
└── zap/
    └── reports/
        ├── zap-report.html
        └── zap-report.json
```

### Visualizar Relatórios

```bash
# Brakeman
xdg-open security_tests/reports/brakeman/brakeman-report.html

# Dependency Check
xdg-open security_tests/reports/dependency-check/dependency-check-report.html

# ZAP
xdg-open security_tests/zap/reports/zap-report.html

# JSON reports
cat security_tests/reports/semgrep/semgrep-report.json | jq
cat security_tests/reports/trivy/trivy-report.json | jq
```

## Executar Scans Individuais

### Brakeman (executado ao subir o container)
```bash
docker exec sysadmin-brakeman brakeman --rails7 --output /reports/brakeman-report.html --format html
```

### Semgrep
```bash
docker exec sysadmin-semgrep semgrep \
  --config=auto \
  --json \
  --output=/reports/semgrep-report.json \
  /src
```

### Trivy
```bash
docker exec sysadmin-trivy trivy fs \
  --format json \
  --output /reports/trivy-report.json \
  /app
```

### Nuclei
```bash
docker exec sysadmin-nuclei nuclei \
  -u http://web:4040 \
  -json \
  -o /reports/nuclei-report.json
```

### OWASP ZAP - Baseline Scan
```bash
docker exec sysadmin-zap zap-baseline.py \
  -t http://web:4040 \
  -J /zap/reports/zap-report.json \
  -r /zap/reports/zap-report.html
```

### OWASP ZAP - Full Scan (mais lento, mais completo)
```bash
docker exec sysadmin-zap zap-full-scan.py \
  -t http://web:4040 \
  -J /zap/reports/zap-full-report.json \
  -r /zap/reports/zap-full-report.html
```

## 🌐 Interfaces Web

- **SysAdmin (Rails)**: http://localhost:4040
- **ZAP Web Interface**: http://localhost:8087/zap
- **ZAP API**: http://localhost:8097

## Comandos Úteis

### Verificar Status dos Containers
```bash
docker ps | grep sysadmin
```

### Ver Logs
```bash
# Rails web
docker logs sysadmin-web -f

# ZAP
docker logs sysadmin-zap -f

# Brakeman
docker logs sysadmin-brakeman -f

# Todos os containers de segurança
docker compose -f security_tests/docker-compose.security.yml logs -f
```

### Reiniciar um Container Específico
```bash
docker restart sysadmin-zap
docker restart sysadmin-semgrep
docker restart sysadmin-trivy
docker restart sysadmin-nuclei
```

### Reconstruir a Aplicação
```bash
docker compose build web
docker compose up -d web
```

## Configuração

### Variáveis de Ambiente (.env)

Crie um arquivo `.env` na raiz do projeto com:

```env
# Database
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
RAILS_ENV=development
```

##  Boas Práticas

1. **Execute os scans regularmente**: Idealmente em cada commit ou antes de cada release
2. **Revise todos os relatórios**: Priorize vulnerabilidades críticas e altas
3. **Mantenha as ferramentas atualizadas**:
   ```bash
   docker compose -f security_tests/docker-compose.security.yml pull
   ```
4. **Documente falsos positivos**: Use arquivos de supressão quando apropriado
5. **Integre ao CI/CD**: Automatize os scans em seu pipeline

## Troubleshooting

### API não está acessível
```bash
# Verifique se a API está rodando
docker ps | grep prostaff-api

# Verifique os logs
docker logs prostaff-api

# Teste o health endpoint
curl http://localhost:3333/up
```

### ZAP pedindo autenticação
- Acesse: http://localhost:8087/zap (não http://localhost:8087)
- A autenticação foi desabilitada na configuração

### Nuclei sem resultados
- Confirme que a API está rodando: `curl http://localhost:3333/up`
- Verifique se o container está na rede correta: `docker network inspect security_tests_security-net`

### Containers encerrando imediatamente
- Verifique os logs: `docker logs <container_name>`
- Confirme que os volumes estão corretos no docker-compose.yml
- Verifique se a aplicação Rails está no diretório pai: `../`

### Erro de bundle/gems não encontradas
```bash
# Reconstrua a imagem
docker-compose build api

# Force bundle install
docker-compose run --rm api bundle install
```

## 📚 Documentação

- [OWASP ZAP](https://www.zaproxy.org/docs/)
- [Brakeman](https://brakemanscanner.org/docs/)
- [Semgrep](https://semgrep.dev/docs/)
- [Trivy](https://aquasecurity.github.io/trivy/)
- [Dependency-Check](https://jeremylong.github.io/DependencyCheck/)
- [Nuclei](https://docs.projectdiscovery.io/tools/nuclei/overview)

## 🤝 Contribuindo

Para adicionar novas ferramentas ou melhorar os scans:

1. Edite `docker-compose.security.yml`
2. Adicione scripts de execução em `run-security-scans.sh`
3. Documente as mudanças neste README
4. Teste completamente antes de commitar

## 🎯 Arquitetura

```
┌─────────────────────────────────────────────────────┐
│           Security Testing Lab Network              │
│                                                      │
│  ┌──────────────┐      ┌──────────────┐            │
│  │   #######    │◄─────┤  OWASP ZAP   │  DAST      │
│  │     API      │      │  (Baseline)  │            │
│  │              │      └──────────────┘            │
│  │  Rails 7.2   │                                   │
│  │  Port: 3333  │      ┌──────────────┐            │
│  └──────┬───────┘      │    Nuclei    │  DAST      │
│         │              └──────────────┘            │
│         │                                           │
│  ┌──────▼───────────────────────────────┐          │
│  │     Application Code                 │          │
│  │                                      │          │
│  │  ┌───────────┐  ┌────────────┐       │          │
│  │  │ Brakeman  │  │  Semgrep   │   SAST│          │
│  │  └───────────┘  └────────────┘       │          │
│  │                                      │          │
│  │  ┌───────────┐  ┌────────────┐       │          │
│  │  │   Trivy   │  │Dependency- │   SCA │          │
│  │  │           │  │   Check    │       │          │
│  │  └───────────┘  └────────────┘       │          │
│  └──────────────────────────────────────┘         │
│                                                      │
└─────────────────────────────────────────────────────┘
```

## 📝 Licença

Este laboratório de segurança é pessoal e instransferível.

BulletOnRails © 2025. Todos os direitos reservados.