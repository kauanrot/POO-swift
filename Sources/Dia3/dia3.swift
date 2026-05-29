import Foundation
/* foi usado ia para fins esteticos como no meunu e algumas outras funções como alunos e outras partes , a maioria aonde apresenta emojis e para colocar os mark,
 e arrumar certos bugs que tive */
// MARK: - ENUMS

enum NivelAluno {
    case iniciante
    case intermediario
    case avancado
}

enum Objetivo {
    case perderPeso
    case ganharMassa
    case altaPerformance
}

enum CategoriaAula {
    case musculacao
    case spinning
    case yoga
    case funcional
    case luta
}

// MARK: - PESSOA

class Pessoa {
    var nome: String
    var email: String
    var telefone: String
    let cpf: String
    var endereco: String

    init(nome: String, email: String, telefone: String, cpf: String, endereco: String) {
        self.nome = nome
        self.email = email
        self.telefone = telefone
        self.cpf = cpf
        self.endereco = endereco
    }

    public func getDescricao() -> String {
        return "nome = \(nome)\nemail = \(email)\ntelefone = \(telefone)\ncpf = \(cpf)\nendereco = \(endereco)"
    }
}

// MARK: - PLANOS

class Plano {
    var nome: String
    var valorMensalidade: Double
    var possuiPersonal: Bool
    var limiteAulasColetivas: Int
    var duracaoMeses: Int

    init(nome: String, valorMensalidade: Double, possuiPersonal: Bool, limiteAulasColetivas: Int, duracaoMeses: Int) {
        self.nome = nome
        self.valorMensalidade = valorMensalidade
        self.possuiPersonal = possuiPersonal
        self.limiteAulasColetivas = limiteAulasColetivas
        self.duracaoMeses = duracaoMeses
    }

    func calcularMensalidade() -> Double {
        return valorMensalidade
    }
}

class PlanoMensal: Plano {
    init() { super.init(nome: "Plano Mensal", valorMensalidade: 120.0, possuiPersonal: false, limiteAulasColetivas: 5, duracaoMeses: 1) }
}

class PlanoTrimestral: Plano {
    init() { super.init(nome: "Plano Trimestral", valorMensalidade: 110.0, possuiPersonal: false, limiteAulasColetivas: 10, duracaoMeses: 3) }
}

class PlanoAnual: Plano {
    init() { super.init(nome: "Plano Anual", valorMensalidade: 96.0, possuiPersonal: true, limiteAulasColetivas: 999, duracaoMeses: 12) }
}

var catalogoPlanos: [Plano] = [PlanoMensal(), PlanoTrimestral(), PlanoAnual()]

// MARK: - ALUNO

class Aluno: Pessoa {
    var matricula: String
    var nivel: NivelAluno = .iniciante
    private(set) var plano: Plano
    var objetivo: Objetivo
    var peso: Float
    var altura: Float

    init(matricula: String, plano: Plano, objetivo: Objetivo, peso: Float, altura: Float, nome: String, email: String, telefone: String, cpf: String, endereco: String) {
        self.matricula = matricula
        self.plano = plano
        self.objetivo = objetivo
        self.peso = peso
        self.altura = altura
        super.init(nome: nome, email: email, telefone: telefone, cpf: cpf, endereco: endereco)
    }

    override func getDescricao() -> String {
        return super.getDescricao() +
            "\nmatricula = \(matricula)" +
            "\nnivel = \(nivel)" +
            "\nplano = \(plano.nome)" +
            "\nmensalidade = R$ \(plano.calcularMensalidade())" +
            "\nduracao = \(plano.duracaoMeses) meses" +
            "\npersonal trainer = \(plano.possuiPersonal)" +
            "\nlimite aulas coletivas = \(plano.limiteAulasColetivas)"
    }

    public func trocarPlano(novoPlano: Plano) { self.plano = novoPlano }
    public func atualizarNivel(novoNivel: NivelAluno) { self.nivel = novoNivel }
}

// MARK: - INSTRUTOR

class Instrutor: Pessoa {
    var especialidade: String

    init(especialidade: String, nome: String, email: String, telefone: String, cpf: String, endereco: String) {
        self.especialidade = especialidade
        super.init(nome: nome, email: email, telefone: telefone, cpf: cpf, endereco: endereco)
    }

    override func getDescricao() -> String {
        return super.getDescricao() + "\nespecialidade = \(especialidade)"
    }
}

protocol Manutencao {
    var nomeItem: String { get }
    var historico: [String] { get set }
    func realizarReparo(data: String) -> Bool
}

// MARK: - EQUIPAMENTO

class Equipamento: Manutencao {
    var nomeItem: String
    var historico: [String] = []
    var funcionando: Bool

    init(nomeItem: String, funcionando: Bool) {
        self.nomeItem = nomeItem
        self.funcionando = funcionando
    }

    func realizarReparo(data: String) -> Bool {
        if !funcionando {
            historico.append("Falha na manutenção em \(data) — equipamento defeituoso")
            print("  ⚠️  Falha: \(nomeItem) está defeituoso. Manutenção não concluída.")
            return false
        }
        historico.append("Reparo realizado em \(data)")
        print("  ✅ \(nomeItem): reparo realizado com sucesso em \(data).")
        return true
    }
}

protocol Aula {
    var nome: String { get set }
    var instrutor: Instrutor { get set }
    var categoria: CategoriaAula { get set }
    var descricao: String { get set }
}

// MARK: - TURMA COLETIVA

class TurmaColetiva: Aula {
    var nome: String
    var instrutor: Instrutor
    var categoria: CategoriaAula
    var descricao: String
    var capacidadeMinima: Int
    var capacidadeMaxima: Int
    var alunos: [Aluno] = []

    init(nome: String, instrutor: Instrutor, categoria: CategoriaAula, descricao: String, capacidadeMinima: Int, capacidadeMaxima: Int) {
        self.nome = nome
        self.instrutor = instrutor
        self.categoria = categoria
        self.descricao = descricao
        self.capacidadeMinima = capacidadeMinima
        self.capacidadeMaxima = capacidadeMaxima
    }

    func inscreverAluno(aluno: Aluno) -> Bool {
        if alunos.count >= capacidadeMaxima {
            print("  ❌ Turma \(nome) está lotada.")
            return false
        }
        if alunos.contains(where: { $0.matricula == aluno.matricula }) {
            print("  ❌ Aluno \(aluno.nome) já está inscrito na turma \(nome).")
            return false
        }
        alunos.append(aluno)
        print("  ✅ Aluno \(aluno.nome) inscrito na turma \(nome).")
        return true
    }
}

// MARK: - TREINO PERSONAL

class TreinoPersonal: Aula {
    var nome: String
    var instrutor: Instrutor
    var categoria: CategoriaAula
    var descricao: String
    var aluno: Aluno

    init(nome: String, instrutor: Instrutor, categoria: CategoriaAula, descricao: String, aluno: Aluno) {
        self.nome = nome
        self.instrutor = instrutor
        self.categoria = categoria
        self.descricao = descricao
        self.aluno = aluno
    }
}

// MARK: - ACADEMIA

class Academia {

    // Dicionários chave-valor para acesso rápido
    private var alunos: [String: Aluno] = [:]           // chave: matricula
    private var instrutores: [String: Instrutor] = [:]  // chave: cpf
    private var equipamentos: [Equipamento] = []
    private var turmas: [String: TurmaColetiva] = [:]   // chave: nome
    private var treinos: [TreinoPersonal] = []

    func cadastrarAluno(_ aluno: Aluno) -> Bool {
        // Verifica matrícula duplicada
        if alunos[aluno.matricula] != nil {
            print("  ❌ Matrícula \(aluno.matricula) já cadastrada.")
            return false
        }
        // Verifica e-mail duplicado
        if alunos.values.contains(where: { $0.email == aluno.email }) {
            print("  ❌ E-mail \(aluno.email) já está em uso.")
            return false
        }
        alunos[aluno.matricula] = aluno
        print("  ✅ Aluno \(aluno.nome) cadastrado com sucesso! Matrícula: \(aluno.matricula)")
        return true
    }

    func cadastrarInstrutor(_ instrutor: Instrutor) -> Bool {
        if instrutores[instrutor.cpf] != nil {
            print("  ❌ Instrutor com CPF \(instrutor.cpf) já cadastrado.")
            return false
        }
        if instrutores.values.contains(where: { $0.email == instrutor.email }) {
            print("  ❌ E-mail \(instrutor.email) já está em uso.")
            return false
        }
        instrutores[instrutor.cpf] = instrutor
        print("  ✅ Instrutor \(instrutor.nome) cadastrado com sucesso!")
        return true
    }

    func adicionarEquipamento(_ equipamento: Equipamento) {
        equipamentos.append(equipamento)
        print("  ✅ Equipamento '\(equipamento.nomeItem)' adicionado.")
    }

    func adicionarTurma(_ turma: TurmaColetiva) -> Bool {
        if turmas[turma.nome] != nil {
            print("  ❌ Turma '\(turma.nome)' já existe.")
            return false
        }
        turmas[turma.nome] = turma
        print("  ✅ Turma '\(turma.nome)' criada com sucesso!")
        return true
    }

    func executarManutencaoEmLote(data: String) -> [Equipamento] {
        print("\n  🔧 Iniciando manutenção em lote — data: \(data)")
        var falhas: [Equipamento] = []
        for equipamento in equipamentos {
            let ok = equipamento.realizarReparo(data: data)
            if !ok {
                falhas.append(equipamento)
            }
        }
        return falhas
    }

    func inscreverAlunoEmTurma(matricula: String, nomeTurma: String) -> Bool {
        guard let aluno = alunos[matricula] else {
            print("  ❌ Aluno com matrícula \(matricula) não encontrado.")
            return false
        }
        guard let turma = turmas[nomeTurma] else {
            print("  ❌ Turma '\(nomeTurma)' não encontrada.")
            return false
        }
        return turma.inscreverAluno(aluno: aluno)
    }

    @discardableResult
    func agendarPersonal(matricula: String, instrutor nomeInstrutor: String, nomeTreino: String, categoria: CategoriaAula, descricao: String) -> Bool {

        guard let aluno = alunos[matricula] else {
            print("  ❌ Aluno com matrícula \(matricula) não encontrado.")
            return false
        }

        // REGRA DE NEGÓCIO: plano deve permitir personal
        guard aluno.plano.possuiPersonal else {
            print("  ❌ O plano '\(aluno.plano.nome)' do aluno \(aluno.nome) NÃO inclui personal trainer.")
            print("     Faça upgrade para o Plano Anual para ter acesso.")
            return false
        }

        guard let instrutor = instrutores.values.first(where: { $0.nome == nomeInstrutor }) else {
            print("  ❌ Instrutor '\(nomeInstrutor)' não encontrado.")
            return false
        }

        let treino = TreinoPersonal(nome: nomeTreino, instrutor: instrutor, categoria: categoria, descricao: descricao, aluno: aluno)
        treinos.append(treino)
        print("  ✅ Personal agendado! Treino '\(nomeTreino)' para \(aluno.nome) com instrutor \(instrutor.nome).")
        return true
    }

    func listarAlunos() {
        if alunos.isEmpty {
            print("  Nenhum aluno cadastrado.")
            return
        }
        print("\n  ───────────────────────────────")
        for aluno in alunos.values {
            print("  👤 \(aluno.nome) | Mat: \(aluno.matricula) | Plano: \(aluno.plano.nome) | Nível: \(aluno.nivel)")
        }
        print("  ───────────────────────────────")
    }

    func listarInstrutores() {
        if instrutores.isEmpty {
            print("  Nenhum instrutor cadastrado.")
            return
        }
        print("\n  ───────────────────────────────")
        for instrutor in instrutores.values {
            print("  🏋️  \(instrutor.nome) | Especialidade: \(instrutor.especialidade) | CPF: \(instrutor.cpf)")
        }
        print("  ───────────────────────────────")
    }

    func listarEquipamentos() {
        if equipamentos.isEmpty {
            print("  Nenhum equipamento cadastrado.")
            return
        }
        print("\n  ───────────────────────────────")
        for eq in equipamentos {
            let status = eq.funcionando ? "✅ OK" : "⚠️  Defeituoso"
            print("  🔩 \(eq.nomeItem) | Status: \(status) | Reparos: \(eq.historico.count)")
        }
        print("  ───────────────────────────────")
    }

    func listarTurmas() {
        if turmas.isEmpty {
            print("  Nenhuma turma cadastrada.")
            return
        }
        print("\n  ───────────────────────────────")
        for turma in turmas.values {
            print("  📋 \(turma.nome) | Categoria: \(turma.categoria) | Alunos: \(turma.alunos.count)/\(turma.capacidadeMaxima) | Instrutor: \(turma.instrutor.nome)")
        }
        print("  ───────────────────────────────")
    }

    func listarTreinos() {
        if treinos.isEmpty {
            print("  Nenhum treino personal agendado.")
            return
        }
        print("\n  ───────────────────────────────")
        for treino in treinos {
            print("  💪 \(treino.nome) | Aluno: \(treino.aluno.nome) | Instrutor: \(treino.instrutor.nome)")
        }
        print("  ───────────────────────────────")
    }

    func buscarAluno(matricula: String) {
        guard let aluno = alunos[matricula] else {
            print("  ❌ Aluno não encontrado.")
            return
        }
        print("\n\(aluno.getDescricao())")
    }

    func buscarInstrutor(cpf: String) -> Instrutor? {
        return instrutores[cpf]
    }
}

// MARK: - MENU

let academia = Academia()

// Dados pré-carregados para facilitar os testes
func carregarDadosIniciais() {
    let inst1 = Instrutor(especialidade: "Musculação", nome: "Ana Silva", email: "ana@academia.com", telefone: "11-98888-0001", cpf: "111.111.111-11", endereco: "Rua Z, 456")
    let inst2 = Instrutor(especialidade: "Yoga", nome: "Bruno Lima", email: "bruno@academia.com", telefone: "11-98888-0002", cpf: "222.222.222-22", endereco: "Rua W, 789")
    academia.cadastrarInstrutor(inst1)
    academia.cadastrarInstrutor(inst2)

    let al1 = Aluno(matricula: "MAT-001", plano: PlanoMensal(), objetivo: .ganharMassa, peso: 75.0, altura: 1.78, nome: "Carlos Mendes", email: "carlos@email.com", telefone: "11-97777-0001", cpf: "333.333.333-33", endereco: "Rua A, 10")
    let al2 = Aluno(matricula: "MAT-002", plano: PlanoAnual(), objetivo: .perderPeso, peso: 68.0, altura: 1.65, nome: "Fernanda Costa", email: "fernanda@email.com", telefone: "11-97777-0002", cpf: "444.444.444-44", endereco: "Rua B, 20")
    academia.cadastrarAluno(al1)
    academia.cadastrarAluno(al2)

    academia.adicionarEquipamento(Equipamento(nomeItem: "Esteira 1", funcionando: true))
    academia.adicionarEquipamento(Equipamento(nomeItem: "Bicicleta Ergométrica", funcionando: false))
    academia.adicionarEquipamento(Equipamento(nomeItem: "Supino", funcionando: true))

    let turma = TurmaColetiva(nome: "Yoga Manhã", instrutor: inst2, categoria: .yoga, descricao: "Yoga para iniciantes", capacidadeMinima: 3, capacidadeMaxima: 10)
    academia.adicionarTurma(turma)

    print("\n  ℹ️  Dados iniciais carregados com sucesso!\n")
}

func exibirMenu() {
    print("""
    
    ╔══════════════════════════════════════╗
    ║        🏋️   ACADEMIA FITNESS        ║
    ╠══════════════════════════════════════╣
    ║  1. Cadastrar Aluno                  ║
    ║  2. Cadastrar Instrutor              ║
    ║  3. Adicionar Equipamento            ║
    ║  4. Criar Turma Coletiva             ║
    ║  5. Inscrever Aluno em Turma         ║
    ║  6. Agendar Treino Personal          ║
    ║  7. Executar Manutenção em Lote      ║
    ║  8. Buscar Aluno por Matrícula       ║
    ║──────────────────────────────────────║
    ║  9. Listar Alunos                    ║
    ║  10. Listar Instrutores              ║
    ║  11. Listar Equipamentos             ║
    ║  12. Listar Turmas                   ║
    ║  13. Listar Treinos Personais        ║
    ║  14. Ver Catálogo de Planos          ║
    ║──────────────────────────────────────║
    ║  0. Sair                             ║
    ╚══════════════════════════════════════╝
    Escolha uma opção: 
    """, terminator: "")
}

func lerLinha(_ prompt: String = "") -> String {
    if !prompt.isEmpty { print("  \(prompt)", terminator: "") }
    return readLine() ?? ""
}

func lerNivel() -> NivelAluno {
    print("  Nível: 1-Iniciante  2-Intermediário  3-Avançado", terminator: " → ")
    switch readLine() ?? "" {
    case "2": return .intermediario
    case "3": return .avancado
    default:  return .iniciante
    }
}

func lerPlano() -> Plano {
    print("  Plano: 1-Mensal(R$120)  2-Trimestral(R$110)  3-Anual(R$96+Personal)", terminator: " → ")
    switch readLine() ?? "" {
    case "2": return PlanoTrimestral()
    case "3": return PlanoAnual()
    default:  return PlanoMensal()
    }
}

func lerCategoria() -> CategoriaAula {
    print("  Categoria: 1-Musculação  2-Spinning  3-Yoga  4-Funcional  5-Luta", terminator: " → ")
    switch readLine() ?? "" {
    case "2": return .spinning
    case "3": return .yoga
    case "4": return .funcional
    case "5": return .luta
    default:  return .musculacao
    }
}

print("\n  Bem-vindo ao Sistema Academia FITNESS!")
print("  Deseja carregar dados iniciais de teste? (s/n) ", terminator: "")
if (readLine() ?? "").lowercased() == "s" {
    carregarDadosIniciais()
}

var rodando = true

while rodando {
    exibirMenu()
    let opcao = readLine() ?? ""

    switch opcao {

    case "1":
        print("\n  ── Cadastrar Aluno ──")
        let matricula  = lerLinha("Matrícula: ")
        let nome       = lerLinha("Nome: ")
        let email      = lerLinha("E-mail: ")
        let telefone   = lerLinha("Telefone: ")
        let cpf        = lerLinha("CPF: ")
        let endereco   = lerLinha("Endereço: ")
        let plano      = lerPlano()
        let nivel      = lerNivel()
        print("  Peso (kg): ", terminator: ""); let peso   = Float(readLine() ?? "0") ?? 0
        print("  Altura (m): ", terminator: ""); let altura = Float(readLine() ?? "0") ?? 0

        let novo = Aluno(matricula: matricula, plano: plano, objetivo: .ganharMassa, peso: peso, altura: altura, nome: nome, email: email, telefone: telefone, cpf: cpf, endereco: endereco)
        novo.atualizarNivel(novoNivel: nivel)
        academia.cadastrarAluno(novo)

    case "2":
        print("\n  ── Cadastrar Instrutor ──")
        let nome         = lerLinha("Nome: ")
        let email        = lerLinha("E-mail: ")
        let telefone     = lerLinha("Telefone: ")
        let cpf          = lerLinha("CPF: ")
        let endereco     = lerLinha("Endereço: ")
        let especialidade = lerLinha("Especialidade: ")

        let novo = Instrutor(especialidade: especialidade, nome: nome, email: email, telefone: telefone, cpf: cpf, endereco: endereco)
        academia.cadastrarInstrutor(novo)

    case "3":
        print("\n  ── Adicionar Equipamento ──")
        let nome = lerLinha("Nome do equipamento: ")
        print("  Está funcionando? (s/n) ", terminator: "")
        let ok = (readLine() ?? "s").lowercased() == "s"
        academia.adicionarEquipamento(Equipamento(nomeItem: nome, funcionando: ok))

    case "4":
        print("\n  ── Criar Turma Coletiva ──")
        let nome        = lerLinha("Nome da turma: ")
        let descricao   = lerLinha("Descrição: ")
        let categoria   = lerCategoria()
        print("  Capacidade mínima: ", terminator: ""); let capMin = Int(readLine() ?? "3") ?? 3
        print("  Capacidade máxima: ", terminator: ""); let capMax = Int(readLine() ?? "20") ?? 20

        print("  ℹ️  Use o CPF do instrutor para vinculá-lo.")
        let cpfInst = lerLinha("CPF do instrutor: ")

        guard let instEncontrado = academia.buscarInstrutor(cpf: cpfInst) else {
            print("  ❌ Instrutor com CPF '\(cpfInst)' não encontrado. Turma não criada.")
            break
        }
        let turma = TurmaColetiva(nome: nome, instrutor: instEncontrado, categoria: categoria, descricao: descricao, capacidadeMinima: capMin, capacidadeMaxima: capMax)
        academia.adicionarTurma(turma)

    case "5":
        print("\n  ── Inscrever Aluno em Turma ──")
        academia.listarAlunos()
        academia.listarTurmas()
        let matricula = lerLinha("Matrícula do aluno: ")
        let nomeTurma = lerLinha("Nome da turma: ")
        academia.inscreverAlunoEmTurma(matricula: matricula, nomeTurma: nomeTurma)

    case "6":
        print("\n  ── Agendar Treino Personal ──")
        academia.listarAlunos()
        academia.listarInstrutores()
        let matricula    = lerLinha("Matrícula do aluno: ")
        let nomeInst     = lerLinha("Nome do instrutor: ")
        let nomeTreino   = lerLinha("Nome do treino: ")
        let descricao    = lerLinha("Descrição: ")
        let categoria    = lerCategoria()
        academia.agendarPersonal(matricula: matricula, instrutor: nomeInst, nomeTreino: nomeTreino, categoria: categoria, descricao: descricao)

    case "7":
        print("\n  ── Manutenção em Lote ──")
        let data = lerLinha("Data da manutenção (dd/mm/aaaa): ")
        let falhas = academia.executarManutencaoEmLote(data: data)
        if falhas.isEmpty {
            print("\n  ✅ Todos os equipamentos passaram na manutenção!")
        } else {
            print("\n  📋 Equipamentos com FALHA (\(falhas.count)):")
            for eq in falhas {
                print("     ⚠️  \(eq.nomeItem)")
            }
        }

    case "8":
        print("\n  ── Buscar Aluno ──")
        let matricula = lerLinha("Matrícula: ")
        academia.buscarAluno(matricula: matricula)

    case "9":
        print("\n  ── Lista de Alunos ──")
        academia.listarAlunos()

    case "10":
        print("\n  ── Lista de Instrutores ──")
        academia.listarInstrutores()

    case "11":
        print("\n  ── Lista de Equipamentos ──")
        academia.listarEquipamentos()

    case "12":
        print("\n  ── Turmas Coletivas ──")
        academia.listarTurmas()

    case "13":
        print("\n  ── Treinos Personal ──")
        academia.listarTreinos()

    case "14":
        print("\n  ── Catálogo de Planos ──")
        print("  ───────────────────────────────────────────────────────")
        print("  \("Plano".padding(toLength: 20, withPad: " ", startingAt: 0)) \("Mensalidade".padding(toLength: 14, withPad: " ", startingAt: 0)) \("Duração".padding(toLength: 10, withPad: " ", startingAt: 0)) Personal")
        print("  ───────────────────────────────────────────────────────")
        for plano in catalogoPlanos {
            let personal = plano.possuiPersonal ? "✅ Sim" : "❌ Não"
            let nome = plano.nome.padding(toLength: 20, withPad: " ", startingAt: 0)
            let valor = "R$ \(plano.valorMensalidade)".padding(toLength: 14, withPad: " ", startingAt: 0)
            let duracao = "\(plano.duracaoMeses) meses".padding(toLength: 10, withPad: " ", startingAt: 0)
            print("  \(nome) \(valor) \(duracao) \(personal)")
        }
        print("  ───────────────────────────────────────────────────────")

    case "0":
        print("\n  👋 Encerrando o sistema. Até logo!")
        rodando = false

    default:
        print("\n  ⚠️  Opção inválida. Tente novamente.")
    }
}