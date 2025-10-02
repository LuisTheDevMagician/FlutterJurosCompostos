import 'package:flutter/material.dart';

/// Simulador de Investimentos: Comparação de Rendimentos
/// Aplicativo para comparar dois investimentos diferentes
void main() => runApp(const SimuladorInvestimentosApp());

/// Widget principal do aplicativo
class SimuladorInvestimentosApp extends StatelessWidget {
  const SimuladorInvestimentosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador de Investimentos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TelaEntradaDados(),
    );
  }
}

/// Classe para armazenar dados de um investimento
class Investimento {
  final String nome;
  final double capital;
  final double aplicacao;
  final double taxa;
  final int meses;

  Investimento({
    required this.nome,
    required this.capital,
    required this.aplicacao,
    required this.taxa,
    required this.meses,
  });
}

/// Classe para detalhes mensais
class DetalheMensal {
  final int mes;
  final double capitalInicial;
  final double rendimento;
  final double aplicacao;
  final double capitalFinal;

  DetalheMensal({
    required this.mes,
    required this.capitalInicial,
    required this.rendimento,
    required this.aplicacao,
    required this.capitalFinal,
  });
}

/// Classe para resultado do investimento
class ResultadoInvestimento {
  final Investimento investimento;
  final double montanteFinal;
  final double rendimentoTotal;
  final List<DetalheMensal> evolucaoMensal;

  ResultadoInvestimento({
    required this.investimento,
    required this.montanteFinal,
    required this.rendimentoTotal,
    required this.evolucaoMensal,
  });
}

/// Tela inicial para entrada dos dados
class TelaEntradaDados extends StatefulWidget {
  const TelaEntradaDados({super.key});

  @override
  State<TelaEntradaDados> createState() => _TelaEntradaDadosState();
}

/// Estado da tela de entrada
class _TelaEntradaDadosState extends State<TelaEntradaDados> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controladores para Investimento 1
  final TextEditingController _capital1Controller = TextEditingController();
  final TextEditingController _aplicacao1Controller = TextEditingController();
  final TextEditingController _taxa1Controller = TextEditingController();

  // Controladores para Investimento 2
  final TextEditingController _capital2Controller = TextEditingController();
  final TextEditingController _aplicacao2Controller = TextEditingController();
  final TextEditingController _taxa2Controller = TextEditingController();

  // Controlador para período
  final TextEditingController _mesesController = TextEditingController();

  @override
  void dispose() {
    _capital1Controller.dispose();
    _aplicacao1Controller.dispose();
    _taxa1Controller.dispose();
    _capital2Controller.dispose();
    _aplicacao2Controller.dispose();
    _taxa2Controller.dispose();
    _mesesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Investimentos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Compare dois investimentos diferentes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),

              // Seção Investimento 1
              _buildInvestmentSection(
                'Investimento 1',
                Colors.green,
                _capital1Controller,
                _aplicacao1Controller,
                _taxa1Controller,
              ),

              const SizedBox(height: 16),

              // Seção Investimento 2
              _buildInvestmentSection(
                'Investimento 2',
                Colors.orange,
                _capital2Controller,
                _aplicacao2Controller,
                _taxa2Controller,
              ),

              const SizedBox(height: 16),

              // Seção Período
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Período de Investimento',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(_mesesController, 'Período (meses)'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Botão Calcular
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _calcular,
                  icon: const Icon(Icons.calculate, color: Colors.white),
                  label: const Text(
                    'Calcular e Comparar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvestmentSection(
    String titulo,
    Color cor,
    TextEditingController capitalController,
    TextEditingController aplicacaoController,
    TextEditingController taxaController,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: cor,
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField(capitalController, 'Capital inicial (R\$)'),
            const SizedBox(height: 10),
            _buildTextField(aplicacaoController, 'Aplicação mensal (R\$)'),
            const SizedBox(height: 10),
            _buildTextField(taxaController, 'Taxa de juros mensal (%)'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um valor';
        }
        if (double.tryParse(value) == null) {
          return 'Por favor, insira um número válido';
        }
        return null;
      },
    );
  }

  void _calcular() {
    if (_formKey.currentState!.validate()) {
      try {
        // Criar objetos dos investimentos
        final inv1 = Investimento(
          nome: 'Investimento 1',
          capital: double.parse(_capital1Controller.text),
          aplicacao: double.parse(_aplicacao1Controller.text),
          taxa: double.parse(_taxa1Controller.text) / 100,
          meses: int.parse(_mesesController.text),
        );

        final inv2 = Investimento(
          nome: 'Investimento 2',
          capital: double.parse(_capital2Controller.text),
          aplicacao: double.parse(_aplicacao2Controller.text),
          taxa: double.parse(_taxa2Controller.text) / 100,
          meses: int.parse(_mesesController.text),
        );

        // Calcular resultados
        final resultado1 = _calcularInvestimento(inv1);
        final resultado2 = _calcularInvestimento(inv2);

        // Navegar para tela de resultados
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TelaResultados(resultado1: resultado1, resultado2: resultado2),
          ),
        );
      } catch (e) {
        _mostrarAlerta(
          'Erro ao processar os dados. Verifique os valores inseridos.',
        );
      }
    }
  }

  ResultadoInvestimento _calcularInvestimento(Investimento inv) {
    List<DetalheMensal> evolucao = [];
    double capitalAtual = inv.capital;
    double rendimentoTotal = 0.0;

    for (int mes = 1; mes <= inv.meses; mes++) {
      double rendimentoMensal = capitalAtual * inv.taxa;
      rendimentoTotal += rendimentoMensal;

      evolucao.add(
        DetalheMensal(
          mes: mes,
          capitalInicial: capitalAtual,
          rendimento: rendimentoMensal,
          aplicacao: inv.aplicacao,
          capitalFinal: capitalAtual + rendimentoMensal + inv.aplicacao,
        ),
      );

      capitalAtual += rendimentoMensal + inv.aplicacao;
    }

    return ResultadoInvestimento(
      investimento: inv,
      montanteFinal: capitalAtual,
      rendimentoTotal: rendimentoTotal,
      evolucaoMensal: evolucao,
    );
  }

  void _mostrarAlerta(String mensagem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Atenção'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// Tela de resultados para comparação
class TelaResultados extends StatefulWidget {
  final ResultadoInvestimento resultado1;
  final ResultadoInvestimento resultado2;

  const TelaResultados({
    super.key,
    required this.resultado1,
    required this.resultado2,
  });

  @override
  State<TelaResultados> createState() => _TelaResultadosState();
}

/// Estado da tela de resultados com scroll sincronizado otimizado
class _TelaResultadosState extends State<TelaResultados> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  bool _isScrolling1 = false;
  bool _isScrolling2 = false;

  @override
  void initState() {
    super.initState();

    // Sincronização otimizada para evitar loops e melhorar performance
    _scrollController1.addListener(() {
      if (!_isScrolling2 && _scrollController2.hasClients) {
        _isScrolling1 = true;
        _scrollController2.jumpTo(_scrollController1.offset);
        _isScrolling1 = false;
      }
    });

    _scrollController2.addListener(() {
      if (!_isScrolling1 && _scrollController1.hasClients) {
        _isScrolling2 = true;
        _scrollController1.jumpTo(_scrollController2.offset);
        _isScrolling2 = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparação de Investimentos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => Navigator.pop(context),
            tooltip: 'Nova Simulação',
          ),
        ],
      ),
      body: Column(
        children: [
          // Resumo comparativo
          _buildResumoComparativo(),

          // Lista comparativa com scroll sincronizado
          Expanded(
            child: Row(
              children: [
                // Investimento 1 (esquerda)
                Expanded(
                  child: _buildListaEvolucao(
                    resultado: widget.resultado1,
                    cor: Colors.green,
                    scrollController: _scrollController1,
                  ),
                ),

                // Divisor
                Container(width: 1, color: Colors.grey[300]),

                // Investimento 2 (direita)
                Expanded(
                  child: _buildListaEvolucao(
                    resultado: widget.resultado2,
                    cor: Colors.orange,
                    scrollController: _scrollController2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumoComparativo() {
    final melhor =
        widget.resultado1.montanteFinal > widget.resultado2.montanteFinal
        ? widget.resultado1
        : widget.resultado2;

    final diferenca =
        (widget.resultado1.montanteFinal - widget.resultado2.montanteFinal)
            .abs();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.grey[50],
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ocupa menos espaço
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Resumo da Comparação',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              // Indicador do melhor investimento compacto
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '🏆 ${melhor.investimento.nome}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              // Card Investimento 1 compacto
              Expanded(
                child: _buildCardResumoCompacto(
                  widget.resultado1,
                  Colors.green,
                ),
              ),

              const SizedBox(width: 8),

              // Card Investimento 2 compacto
              Expanded(
                child: _buildCardResumoCompacto(
                  widget.resultado2,
                  Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Dica de navegação
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.swipe_vertical, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                'Deslize para ver todos os meses • Diferença: R\$ ${diferenca.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardResumoCompacto(ResultadoInvestimento resultado, Color cor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resultado.investimento.nome,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: cor,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'R\$ ${resultado.montanteFinal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            Text(
              '+R\$ ${resultado.rendimentoTotal.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 9, color: Colors.green[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListaEvolucao({
    required ResultadoInvestimento resultado,
    required Color cor,
    required ScrollController scrollController,
  }) {
    return Column(
      children: [
        // Cabeçalho
        Container(
          padding: const EdgeInsets.all(12.0),
          color: cor.withValues(alpha: 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.trending_up, color: cor),
              const SizedBox(width: 8),
              Text(
                resultado.investimento.nome,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: cor,
                ),
              ),
            ],
          ),
        ),

        // Lista de evolução mensal otimizada para performance
        Expanded(
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            thickness: 8,
            radius: const Radius.circular(4),
            child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(), // Scroll mais fluido
              padding: const EdgeInsets.symmetric(vertical: 2),
              itemCount: resultado.evolucaoMensal.length,
              itemExtent: 50, // Altura fixa para melhor performance
              cacheExtent: 200, // Cache mais itens para scroll fluido
              itemBuilder: (context, index) {
                final detalhe = resultado.evolucaoMensal[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        // Número do mês - círculo simples
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: cor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${detalhe.mes}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Informações do mês - layout otimizado
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'R\$ ${detalhe.capitalFinal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                '+${detalhe.rendimento.toStringAsFixed(0)} | Apl: ${detalhe.aplicacao.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Ícone simples
                        Icon(
                          Icons.arrow_upward,
                          color: cor.withValues(alpha: 0.7),
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
