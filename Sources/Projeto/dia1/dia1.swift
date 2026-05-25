class Pessoa {
    var nome: String
    var email: String
    var telefone: String
    let cpf: String
    var endereco: String
    // data de nascimento
    // sexo
    init(nome: String, email: String, telefone: String, cpf: String, endereco: String) {
        self.nome = nome
        self.email = email
        self.telefone = telefone
        self.cpf = cpf
        self.endereco = endereco
    }
    public func getDescricao() -> String {
        return "nome = \(self.nome)\nemail = \(self.email)\ntelefone = \(self.telefone)\ncpf = \(cpf)\nendereco = \(endereco)"
    }
}
 
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
 
class Aluno: Pessoa {
    private var plano: String
    private var biometria: String
    private var objetivo: Objetivo
    private var peso: Float
    private var altura: Float
    init(plano: String, biometria: String, objetivo: Objetivo, peso: Float, altura: Float, nome: String, email: String, telefone: String, cpf: String, endereco: String) {
        self.plano = plano
        self.biometria = biometria
        self.objetivo = objetivo
        self.peso = peso
        self.altura = altura
        super.init(nome: nome, email: email, telefone: telefone, cpf: cpf, endereco: endereco)
    }
    public func trocarPlano(novoPlano: String) {
        self.plano = novoPlano
    }
    public func pagamento() -> String {
        return "O aluno \(nome) realizou o pagamento com sucesso!"
    }
}
 
var pessoa: Pessoa = Pessoa(nome: "Julia", email: "julia@email.com", telefone: "12345", cpf: "12345", endereco: "Rua X, XXX")
print(pessoa.getDescricao())