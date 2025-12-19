# churras_app_calculator

Resumo
- Aplicativo Flutter simples para calcular custos de um churrasco (participantes, carnes, bebidas, divisão de conta).
- Projeto ideal para apresentar em entrevistas: demonstra fluxo de UI, gestão de estado, boas práticas de organização de pastas e testes básicos.

Por que este projeto em uma entrevista
- Mostra conhecimento prático de Flutter (widget composition, navegação, formulários, validação).
- Permite discutir decisões de arquitetura (pastas, separação de UI / lógica / modelos).
- Permite demonstrar habilidade com gerenciamento de estado, tratamento de entrada assíncrona e testes.
- Fácil de estender com features que podem ser pedidas durante a entrevista (persistência, internacionalização, integração com APIs).

Tecnologias
- Flutter (Dart)
- Estrutura básica de pastas: lib/, test/, assets/, pubspec.yaml
- Ferramentas: flutter CLI (flutter pub get, flutter run, flutter test, flutter analyze)

Funcionalidades principais
- Entrada de participantes e quantidades (adultos/crianças).
- Seleção de itens (carnes, bebidas) com quantidade/porção e preço.
- Cálculo automático de custo total e custo por pessoa.
- Validação básica de formulário e mensagens de erro.
- Layout responsivo para diferentes tamanhos de tela (celular/tablet).

Como rodar (local)
1. Instalar Flutter: https://docs.flutter.dev/get-started
2. No diretório do projeto:
    - flutter pub get
    - flutter run
3. Executar testes:
    - flutter test
4. Rodar análise estática:
    - flutter analyze

Estrutura sugerida (pontos a destacar na entrevista)
- lib/
  - main.dart — ponto de entrada e rota principal.
  - screens/ — telas (ex.: home_screen.dart, results_screen.dart).
  - widgets/ — widgets reutilizáveis (ex.: input_field.dart, item_card.dart).
  - models/ — modelos de domínio (ex.: participant.dart, item.dart).
  - services/ — lógica de cálculo e utilitários (ex.: calculator_service.dart).
  - providers/ ou blocs/ — onde o gerenciamento de estado está implementado (Provider, Riverpod, BLoC, etc.).
- test/ — testes unitários e de widget cobrindo cálculo e validações.
- pubspec.yaml — dependências e assets.

Pontos técnicos para discutir
- Gestão de estado escolhida (por que, trade-offs).
- Organização de código e separação de responsabilidades.
- Testes: cobertura de cálculos críticos e validação de formulários.
- Performance: evitar rebuilds desnecessários, uso de const widgets, profiling.
- Acessibilidade e internacionalização (i18n) — como adicionar.
- Possíveis melhorias: persistência local (SharedPreferences / Hive), exportar resultado (PDF / compartilhar), integração com backend para salvar eventos.

Possíveis perguntas da entrevista e respostas curtas
- Como garantir precisão dos cálculos? — Cobrir com testes unitários e tratamento consistente de tipos numéricos (double/decimal) e formatação local.
- Como escalar a UI para mais itens? — Componentizar item list, usar lazy loading e manter widgets pequenos e testáveis.
- Como tratar erros de entrada? — Validação no frontend + testes; considerar validação adicional no backend se houver.

Melhorias futuras (roadmap rápido)
- Suporte a múltiplos eventos salvos.
- Persistência local e sincronização com nuvem.
- Perfil de usuários e histórico.
- Exportar/compartilhar resultados.

Observações finais
- Código simples e focado em demonstrar fundamentos do desenvolvimento Flutter e boas práticas de engenharia. Preparar uma demo ao vivo destacando os pontos listados e mostrando testes e análise estática funcionando.

