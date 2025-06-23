Avaliação MBA

# Avaliação MBA on Rails

## Disciplina: Arquitetura de Aplicações Web com Rails

### Nossa avaliação será feita em duas etapas:

1a. - Desenvolvimento de um projeto pessoal usando Ruby on Rails aplicando os conceitos que foram aprendidos durante a disciplina. O prazo para entrega é 30/06/25.

2a - Avaliação objetiva com algumas perguntas que será envia por Internet, onde o aluno se indetifica, lê a pergunta e responde selecionando uma das opções disponíveis. Nessa avaliação o aluno também deverá enviar o link do repositório do projeto desenvolvido na primeira avaliação.

#### Critérios de aceitação da 1a avaliação

- O aluno deve implementar um projeto pessoal feito em RoR utilizando o que foi aprendido durante as aulas.
- O projeto deve **OBRIGATORIAMENTE** usar **dev container**.
- O projeto deve **OBRIGATORIAMENTE** implementar **pelo menos 5 conceitos** que foram apresentados nas aulas.
- O aluno deve escrever no README do projeto cada um dos conceitos que aplicou e explicar o motivo da utilização do mesmo.
- O aluno deve disponibilizar o projeto em um repositório do github e enviar o link no formulário da 2 avaliação.
- O aluno deve seguir o exemplo do README abaixo.

#### Exemplo do README

----------------------------------------
Aluno: Daniel Barbosa do Nascimento
Email: dbnkocao@gmail.com

# Meu catálogo de livros

Este é um projeto desenvolvido como parte do curso de Ruby on Rails. O objetivo é aplicar os conceitos aprendidos em aula para criar uma aplicação web funcional, bem estruturada e com boas práticas de desenvolvimento.

## 📦 Tecnologias Utilizadas

- [Ruby](https://www.ruby-lang.org/pt/) 3.4.4
- [Ruby on Rails](https://rubyonrails.org/) 8.0.2
- [PostgreSQL](https://www.postgresql.org/) 17

## 🚀 Como rodar o projeto localmente

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/nome-do-projeto.git
cd nome-do-projeto

# abra o VSCode
# Inicie o projeto dentro do dev container
```

## ✅ Funcionalidades implementadas

Descreva aqui as principais funcionalidades da sua aplicação. Por exemplo:

-

## 🧠 Conceitos aplicados

Abaixo estão os conceitos aprendidos em aula e aplicados neste projeto, junto com a justificativa de sua utilização:

### 1. **Service Objects**
Serviços de Busca de livro
Serviços para criar o livro


Utilizados para encapsular regras de negócio complexas fora dos models e controllers, mantendo o código mais limpo e testável. Podemos observar no projeto a classe TAL que faz isso e isso onde podemos comprovar o benefício da utilização desse conceito.

### 2. **ActiveJob + Solid queue**
* Busca de livro no brasil api
* Envio de email informando o retorno ou não do livrto
Usado para processamento assíncrono de tarefas demoradas, como envio de e-mails, sem bloquear o fluxo da aplicação. Aqui escolhi usar esse conceito pois se enviasse o email ficaria com a tela bloqueada para o usuário e isso acaba causando um empobrecimento na UX.

### 3. **Design Patterns como Form Objects ou Presenters**

Aplicados para organizar melhor o código em casos onde os formulários possuem lógica de validação ou exibição mais complexa. Escolhi usar o PATTERN para possibilitar desacoplar tal classe e assim ter o benefício disso disso e disso.

> _Em resumo, inclua pelo menos 5 conceitos que utilizou, a justificativa de cada um e como isso te ajudou no projeto._
----------------------------------------

### Engine

### Query Objects

### Iterator/
Utilizado para enfileirar a busca e criação de livro
### Concern

### Cache
Salva o cache do livro, caso seja pesquisado novamente

RuboCop: estilo, complexidade, boas práticas.
Bullet, Prosopite: detecta queries N+1 em tempo de desenvolvimento.
