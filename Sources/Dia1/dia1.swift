import Foundation

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
        return "nome = \(self.nome)\nemail = \(self.email)\ntelefone = \(self.telefone)\ncpf = \(self.cpf)\nendereco = \(self.endereco)"
    }
}

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
    init() {
        super.init(nome: "Plano Mensal", valorMensalidade: 120.0, possuiPersonal: false, limiteAulasColetivas: 5, duracaoMeses: 1)
    }
}

class PlanoTrimestral: Plano {
    init() {
        super.init(nome: "Plano Trimestral", valorMensalidade: 110.0, possuiPersonal: false, limiteAulasColetivas: 10, duracaoMeses: 3)
    }
}

class PlanoAnual: Plano {
    init() {
        super.init(nome: "Plano Anual", valorMensalidade: 96.0, possuiPersonal: true, limiteAulasColetivas: 999, duracaoMeses: 12)
    }
}

var catalogoPlanos: [Plano] = [PlanoMensal(), PlanoTrimestral(), PlanoAnual()]

class Aluno: Pessoa {
    var matricula: String
    var nivel: NivelAluno = .iniciante
    private(set) var plano: Plano
    private var biometria: String
    var objetivo: Objetivo
    var peso: Float
    var altura: Float

    init(matricula: String, plano: Plano, biometria: String, objetivo: Objetivo, peso: Float, altura: Float, nome: String, email: String, telefone: String, cpf: String, endereco: String) {
        self.matricula = matricula
        self.plano = plano
        self.biometria = biometria
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

    public func trocarPlano(novoPlano: Plano) {
        self.plano = novoPlano
    }

    public func atualizarNivel(novoNivel: NivelAluno) {
        self.nivel = novoNivel
    }

    public func pagamento() -> String {
        return "O aluno \(nome) realizou o pagamento com sucesso!"
    }
}

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

var pessoa: Pessoa = Pessoa(nome: "Julia", email: "julia@email.com", telefone: "12345", cpf: "12345", endereco: "Rua X, XXX")
print(pessoa.getDescricao())

print()

var aluno: Aluno = Aluno(matricula: "MAT-001", plano: PlanoMensal(), biometria: "Normal", objetivo: .ganharMassa, peso: 70.0, altura: 1.75, nome: "Carlos", email: "carlos@email.com", telefone: "99999", cpf: "98765", endereco: "Rua Y, 123")
print(aluno.getDescricao())
print(aluno.pagamento())

print()

aluno.trocarPlano(novoPlano: PlanoAnual())
print("Plano atualizado: \(aluno.plano.nome)")
print("Mensalidade = R$ \(aluno.plano.calcularMensalidade())")

print()

aluno.atualizarNivel(novoNivel: .intermediario)
print("Novo nivel = \(aluno.nivel)")

print()

var instrutor: Instrutor = Instrutor(especialidade: "Musculação", nome: "Ana", email: "ana@academia.com", telefone: "88888", cpf: "11111", endereco: "Rua Z, 456")
print(instrutor.getDescricao())

print()

print("CATALOGO DE PLANOS")

for plano in catalogoPlanos {
    print("\(plano.nome) | R$ \(plano.valorMensalidade) | \(plano.duracaoMeses) meses")
}

