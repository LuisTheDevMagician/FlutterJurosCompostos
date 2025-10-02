# Simulador de Investimentos: Comparação de Rendimentos

## Descrição do Projeto

Este é um aplicativo Flutter desenvolvido como parte do desafio "Simulador de Investimentos Personalizado". O aplicativo permite comparar dois investimentos diferentes, calculando juros compostos e exibindo a evolução mensal de cada investimento lado a lado.

## Funcionalidades

### Tela de Entrada de Dados
- **Formulário para dois investimentos distintos:**
  - Capital inicial (R$)
  - Aplicação mensal (R$)
  - Taxa de juros mensal (%)
- **Período compartilhado:** Define quantos meses durarão os investimentos
- **Validação de campos:** Garante que todos os valores sejam preenchidos corretamente
- **Interface intuitiva:** Cards coloridos para diferenciar os investimentos

### Tela de Comparação de Resultados
- **Resumo comparativo:** Mostra qual investimento é melhor e por quanto
- **Visualização lado a lado:** Os dois investimentos são exibidos em colunas paralelas
- **Scroll sincronizado:** Quando você move uma lista, a outra acompanha automaticamente
- **Evolução mensal detalhada:** Para cada mês mostra:
  - Capital acumulado
  - Rendimento do mês
  - Aplicação mensal
  - Ícones e cores para facilitar a identificação

## Componentes Técnicos Utilizados

### Formulários e Validação
- `GlobalKey<FormState>` para gerenciar o estado do formulário
- `TextFormField` com validação personalizada
- `TextEditingController` para capturar os dados de entrada

### Navegação
- `Navigator.push()` com `MaterialPageRoute` para transição entre telas
- Botão de voltar personalizado no AppBar

### Listas e Scroll Sincronizado
- `ListView.builder()` para exibir a evolução mensal
- `ScrollController` sincronizado entre as duas listas
- Cards e ListTiles para organização visual

### Cálculos Financeiros
- **Fórmula de juros compostos implementada:**
  ```dart
  for (int mes = 1; mes <= inv.meses; mes++) {
    double rendimentoMensal = capitalAtual * inv.taxa;
    capitalAtual += rendimentoMensal + inv.aplicacao;
  }
  ```

### Gerenciamento de Estado
- `setState()` para atualizações da interface
- Classes de modelo para organizar os dados:
  - `Investimento`: Dados de entrada
  - `DetalheMensal`: Evolução mês a mês
  - `ResultadoInvestimento`: Resultado consolidado

## Estrutura do Código

### Classes Principais
1. **SimuladorInvestimentosApp**: Widget principal do aplicativo
2. **TelaEntradaDados**: Formulário para entrada dos dados
3. **TelaResultados**: Comparação visual dos resultados
4. **Investimento**: Modelo de dados para um investimento
5. **DetalheMensal**: Detalhes de um mês específico
6. **ResultadoInvestimento**: Resultado completo do cálculo

### Widgets Reutilizáveis
- `_buildInvestmentSection()`: Seção de entrada para cada investimento
- `_buildTextField()`: Campo de texto com validação
- `_buildListaEvolucao()`: Lista de evolução mensal
- `_buildCardResumo()`: Card resumo do investimento

## Como Usar

1. **Preencher os dados do Investimento 1:**
   - Capital inicial (ex: 1000)
   - Aplicação mensal (ex: 200)
   - Taxa mensal (ex: 1.5)

2. **Preencher os dados do Investimento 2:**
   - Capital inicial (ex: 1500)
   - Aplicação mensal (ex: 150)
   - Taxa mensal (ex: 1.2)

3. **Definir o período:** Quantos meses (ex: 12)

4. **Clicar em "Calcular e Comparar"**

5. **Na tela de resultados:**
   - Ver o resumo no topo
   - Comparar a evolução mês a mês
   - Usar o scroll para navegar pelos meses
   - Clicar no ícone de refresh para nova simulação

## Exemplo de Uso

**Cenário:** Comparar Poupança vs. CDB

**Investimento 1 (Poupança):**
- Capital inicial: R$ 5.000,00
- Aplicação mensal: R$ 300,00
- Taxa mensal: 0,5%
- Período: 24 meses

**Investimento 2 (CDB):**
- Capital inicial: R$ 5.000,00
- Aplicação mensal: R$ 300,00
- Taxa mensal: 0,8%
- Período: 24 meses

**Resultado esperado:** O CDB será melhor devido à taxa superior.

## Tecnologias Utilizadas

- **Flutter 3.x**
- **Dart**
- **Material Design**
- **Programação Orientada a Objetos**

## Recursos de Acessibilidade

- Cores contrastantes para facilitar a leitura
- Ícones intuitivos para identificação rápida
- Textos descritivos nos campos
- Feedback visual claro nos botões


