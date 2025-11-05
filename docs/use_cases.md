# Use Cases e Regras de Negócio (Versão Simplificada)

Esta documentação descreve, de forma resumida, os módulos inspirados na Umanni e suas regras de negócio fundamentais, para entendimento e futuras evoluções.

## Planos de Sucessão
- Objetivo: Garantir continuidade em cargos críticos.
- Entidades: `Cargo`, `Sucessor`, `Critério`.
- Regras:
  - Cada `Cargo` pode ter 0..N `Sucessores` internos/externos.
  - `Critérios` de prontidão: experiência, competências, disponibilidade.
  - Alertas de vacância: estimativa de saída por tempo/ciclo.
- Fluxo:
  1) Mapear cargos críticos; 2) Listar sucessores; 3) Definir planos; 4) Monitorar.

## Avaliações
- Objetivo: Desenvolvimento de cultura e equipe.
- Entidades: `Avaliação`, `Participante`, `Modelo` (Auto, 90º, 180º, 360º).
- Regras:
  - `Modelo` define papéis avaliador/avaliado e escala de notas.
  - Consolidação de notas por competência e dimensão.
  - Resultados alimentam `PDI` e `Matriz de Talentos`.
- Fluxo: Planejar → Executar → Consolidar → Reportar → Integrar PDI.

## Metas
- Objetivo: Conectar equipes e resultados.
- Entidades: `Meta`, `Indicador`, `Plano` (OKR, SMART, BSC, MBO).
- Regras:
  - Cascateamento: vínculo hierárquico de metas por equipes.
  - Evidências: anexos, comentários, checkpoints.
  - Acompanhamento: periodicidade e cálculo de progresso.
- Fluxo: Definir → Alinhar → Acompanhar → Fechar ciclo.

## Feedbacks
- Objetivo: Engajamento e comunicação contínua.
- Entidades: `Feedback` (privado/solicitado), `Usuário`.
- Regras:
  - Privacidade: acesso somente emissor e destinatário.
  - Classificação: elogio, melhoria, alinhamento.
  - Integração: insumos para `PDI` e métricas de engajamento.
- Fluxo: Emitir/Solicitar → Registrar → Acompanhar.

## PDI (Plano de Desenvolvimento Individual)
- Objetivo: Potencializar colaboradores.
- Entidades: `PDI`, `Objetivo`, `Ação`, `Competência`.
- Regras:
  - Alinhamento com resultados de `Avaliações` e `Feedbacks`.
  - Progresso por marco/entrega.
  - Visibilidade por gestor e consolidado por equipe.
- Fluxo: Definir → Executar → Monitorar → Revisar.

## Matriz de Talentos
- Objetivo: Transformar desempenho em resultado.
- Entidades: `Matriz` (4/5/9/12/16 Box), `EixoX`, `EixoY`, `Peso`.
- Regras:
  - Cálculo dos eixos com pesos customizados e fontes (Avaliações, Metas, Feedbacks).
  - Segmentações por área/unidade/cargo.
  - Comitês de calibragem com histórico e justificativas.
- Fluxo: Configurar → Alimentar → Visualizar → Calibrar → Decidir.

---

## Ultrathink (Regra de Negócio - Visão)

“Ultrathink” aqui representa um arcabouço de decisão que combina dados de múltiplos módulos para sugerir ações de alto impacto com baixo atrito.

- Inputs: Notas de Avaliação, progresso de Metas, registros de Feedbacks, status de PDI.
- Engine simplificada:
  - Normaliza métricas em escala comum (0..100).
  - Aplica pesos por contexto (ex.: 40% Avaliações, 30% Metas, 20% Feedbacks, 10% PDI).
  - Produz score por colaborador/time para apoiar decisões (promoção, sucessão, treinamento).
- Saídas:
  - Lista de “próximas melhores ações” (NBAs) por colaborador e time.
  - Sinalizadores: risco de vacância, gap crítico de competência, baixa aderência a metas.

Esta visão pode evoluir para recomendações assistidas e painéis interativos.