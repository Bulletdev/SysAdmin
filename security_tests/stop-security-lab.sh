#!/bin/bash
# Stop Security Testing Lab

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}🛑 Stopping SysAdmin Security Lab...${NC}"

docker compose -f security_tests/docker-compose.security.yml down

# Stop application (optional)
# docker compose down

echo -e "${GREEN}✅ Security lab stopped${NC}"
