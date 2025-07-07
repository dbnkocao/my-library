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
git clone git@github.com:dbnkocao/my-library.git
cd my-library

# abra o VSCode
# Inicie o projeto dentro do dev container
```

## ✅ Funcionalidades implementadas
* Criação de usuário e sua respectiva biblioteca
* Busca de Livros pelo número do ISBN
* Busca de preços de livro e envio de email com o resultado da busca

## 🧠 Conceitos aplicados

Abaixo estão os conceitos aprendidos em aula e aplicados neste projeto, junto com a justificativa de sua utilização:

### 1. **Service Objects**
Utilizei services para evitar que a regra de negócio "poluísse" os controllers e models, deixando o código mais organizado.
Lugares utilizados:
* Serviço de criação de livros pelo número ISBN (services/create_book_by_isbn_service.rb)
* Serviço de busca de livro por ISBN (engines/app/services/brasilapi/isbn_service.rb)
* Serviço que busca endereço por CEP (engines/app/services/brasilapi/cep_service.rb)
* Serviço que busca preços no zoom (engines/app/services/zoom_search_service.rb)
### 2. **ActiveJob + Solid queue**
Usado para processamento assíncrono de tarefas demoradas, evitando de travar a navegação do usuário durante as tarefas que poderiam ser mais lentas.
Lugares utilizados:
* Job que busca os livros pelo zoom.(app/jobs/book_price_search_job.rb)
* Envio de email informando os menores.(app/mailers/search_prices_mailer.rb)

### 3. **Engine**
Utilizei esse conceito para encapsular as consultas a outros sites ou APIs, fazendo com que as consultas possam ser reutilizadas fácilmente em outros projetos.
Lugares utilizados:
* ThidPartyEngine (engines/third_party_engine)

### 4. **SolidProcess**
Utilizei a gem solid process para ordernar e organizar services mais complexos.
Lugares utilizados:
* Serviço de criação de livro(app/services/create_book_by_isbn_service.rb)

### 5. **Collection Cache**
Utilizado para cachear a renderização de livros e preços, para deixar o carregamento da página mais rápido.
Lugares utilizados:
* Lista de livros (app/vies/libraries/index.html.erb)
* Lista de preços (app/views/libraries/_book.html.erb)