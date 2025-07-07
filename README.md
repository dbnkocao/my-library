# Avaliação MBA on Rails

## Disciplina: Arquitetura de Aplicações Web com Rails

Aluno: Daniel Barbosa do Nascimento

Email: dbnkocao@gmail.com

# Meu catálogo de livros

Este é um projeto desenvolvido como parte do curso de Ruby on Rails. O objetivo é aplicar os conceitos aprendidos em aula para criar uma aplicação web funcional, bem estruturada e com boas práticas de desenvolvimento.

## 📦 Tecnologias Utilizadas

- [Ruby](https://www.ruby-lang.org/pt/) 3.4.4
- [Ruby on Rails](https://rubyonrails.org/) 8.0.2
- [PostgreSQL](https://www.postgresql.org/) 17
- [Bootstrap](https://getbootstrap.com/docs/5.0/getting-started/introduction/) 5.0.2
- [Bootstrap Icons](https://icons.getbootstrap.com/) 1.13.1

## 🚀 Como rodar o projeto localmente

```bash
# Clone o repositório
git clone git@github.com:dbnkocao/my-library.git
cd my-library

# abra o VSCode
# Inicie o projeto dentro do dev container
```
Ao iniciar o projeto será criado o seguinte usuário:

**usuário:** user@email.com

**senha:** 123456

Que terá alguns livros adicionados de exemplo a sua biblioteca. Também é possível criar novos usuários através do botão **sign up**.

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
Usado para processamento assíncrono de tarefas demoradas, evitando de travar a navegação do usuário, durante as tarefas que poderiam ser mais lentas.

Lugares utilizados:
* Job que busca os livros pelo zoom.(app/jobs/book_price_search_job.rb)
* Envio de email informando os menore Preços.(app/mailers/search_prices_mailer.rb)

### 3. **Engines**
Utilizei esse conceito para encapsular as consultas a outros sites ou APIs, fazendo com que as consultas possam ser reutilizadas fácilmente em outros projetos.

Lugares utilizados:
* ThidPartyEngine (engines/third_party_engine)

### 4. **SolidProcess**
Utilizei a gem solid process para ordernar e organizar services mais complexos.

Lugares utilizados:
* Serviço de criação de livro(app/services/create_book_by_isbn_service.rb)

### 5. **Collection Cache**
Utilizado para cachear a renderização de livros e preços, otimizando o carregamento da página.

Lugares utilizados:
* Lista de livros (app/vies/libraries/index.html.erb)
* Lista de preços (app/views/libraries/_book.html.erb)