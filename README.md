# churras_app_calculator

Resumo
- Aplicativo Flutter simples para calcular custos de um churrasco (participantes, carnes, bebidas, divisão de conta).
- Projeto ideal para apresentar em entrevistas: demonstra fluxo de UI, gestão de estado, boas práticas de organização de pastas e testes básicos.

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

Melhorias futuras (roadmap rápido)
- Suporte a múltiplos eventos salvos.
- Persistência local e sincronização com nuvem.
- Perfil de usuários e histórico.
- Exportar/compartilhar resultados.