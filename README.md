# **💳 Sistema de Gerenciamento de Pagamentos - Modelagem de Banco de Dados**

Este repositório documenta o processo completo de modelagem de um banco de dados relacional para um sistema de gerenciamento de pagamentos, desde a concepção conceitual até a implementação física.

## **📋 Índice**

- Estrutura do Projeto
- Ferramentas Utilizadas
- Contexto do Sistema
- Entidades e Relacionamentos
- Modelagem de Dados
- Scripts SQL
- Instruções de Uso
- Lições Aprendidas
- Licença
  

## **🏗️ Estrutura do Projeto**

```
📦 database-modeling-payments
 ┣ 📁 diagrams
 ┃ ┣ 01 - Conceitual.brm3          # Diagrama conceitual (BrModelo)
 ┃ ┣ 01 - Conceitual.png           # Imagem do diagrama conceitual
 ┃ ┣ 02 - Lógico.mwb               # Diagrama lógico (MySQL Workbench)
 ┃ ┣ 02 - Lógico.png               # Imagem do diagrama lógico
 ┃ ┗ 03 - Fisíco.png               # Imagem do diagrama Fisíco
 ┣ 📁 sql
 ┃ ┣ 04 - script_create_table.sql  # Criação de tabelas e constraints
 ┃ ┣ 05 - script_insert_table.sql  # Dados de exemplo
 ┃ ┣ 06 - script_queries.sql       # Consultas de análise
 ┃ ┣ 07 - script_indexes.sql       # Índices para otimização
 ┃ ┗ 08 - Exercícios.pdf           # Exercícios para praticar
 ┣ README.md
 ┗ LICENSE
```


## **⚙️ Ferramentas Utilizadas**

| **Ferramenta** | **Finalidade** | **Versão** |
| --- | --- | --- |
| **BrModelo** | Modelo conceitual | 3.3 |
| **MySQL Workbench** | Modelo lógico | 8.0+ |
| **PostgreSQL** | SGBD para modelo físico | 14+ |
| **DBeaver** | Interface e execução SQL | 23.0+ |



## **🎯 Contexto do Sistema**

A empresa precisa de um sistema robusto para gerenciar as transações financeiras dos seus clientes, observando as seguintes regras de negócio:

- **Clientes** realizam **Pedidos**.
- Cada **Pedido** é associado a um **Pagamento**.
- O **Pagamento** possui um **Status Assíncrono**: `Pendente`, `Aprovado`, `Recusado` ou `Estornado`.
- Um **Pagamento** utiliza uma única **Forma de Pagamento**.
- **Formas de Pagamento** definem parâmetros como **`percentual_desconto`** ou **`percentual_juros_mes`**.
- **Pagamentos** podem ser divididos em até 12 **Parcelas**, com flexibilidade para valores e datas de vencimento individuais por parcela.



 ## **🏛️ Entidades e Relacionamentos**

### **Principais Entidades**

| **Entidade** | **Descrição** | **Atributos Principais** |
| --- | --- | --- |
| **Clientes** | Cadastro de clientes | `id`, `nome`, `email`, `cpf`, `data_cadastro` |
| **Pedidos** | Registro de pedidos | `id`, `cliente_id`, `valor_total`, `data_pedido`, `status` |
| **Pagamentos** | Transações de pagamento | `id`, `pedido_id`, `forma_pagamento_id`, `valor_total`, `status` |
| **FormaPagamento** | Meios de pagamento | `id`, `nome`, `desconto`, `juros_mensal`, `parcelas_maximas` |
| **Parcelas** | Parcelas do pagamento | `id`, `pagamento_id`, `numero_parcela`, `valor`, `data_vencimento`, `status` |

### **Relacionamentos**

```
Cliente (1) ---- (N) Pedido
Pedido (1) ---- (1) Pagamento
FormaPagamento (1) ---- (N) Pagamento
Pagamento (1) ---- (N) Parcela
```

 
## **📊 Modelagem de Dados**

### **1. Modelo Conceitual**

- **Arquivo**: `diagrams/01 - Conceitual.brM3`
- **Objetivo**: Representar entidades, atributos e relacionamentos de alto nível
- **Características**: Identificação das entidades principais e seus relacionamentos básicos

![image.jpg](diagrams/01%20-%20Conceitual.png)

### **2. Modelo Lógico**

- **Arquivo**: `diagrams/02 - Lógico.mwb`
- **Objetivo**: Definir estrutura detalhada com chaves, tipos de dados e cardinalidades
- **Características**: Normalização até 3FN, definição de PKs e FKs

![image.jpg](diagrams/02%20-%20Lógico.png)

### **3. Modelo Físico**

- **Implementação**: PostgreSQL e **DBeaver**
- **Características**: Scripts executáveis, índices, constraints e dados de exemplo

![image.jpg](diagrams/03%20-%20Fisíco.png)


## **🗃️ Scripts SQL**

#### **`04 - script_create_table.sql`**

```sql
-- Exemplo de criação de tabelas

create table if not exists modulo_pagamentos.clientes (
   id_cliente SERIAL primary key,
   nome VARCHAR(60) not null,
   endereco VARCHAR (100) not null,
   telefone VARCHAR (15) not null,
   email VARCHAR(45) not null unique
);

create table if not exists modulo_pagamentos.pedidos (
   id_pedido SERIAL primary key,
   id_cliente INT references modulo_pagamentos.clientes(id_cliente),
   valor_bruto DECIMAL(10,2) check (valor_bruto >= 0),
   status_pedido VARCHAR(45) not null default 'Pagamento Pendente',
   data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   constraint chk_status_pedido check (status_pedido in ('Pagamento Pendente', 'Pagamento Confirmado', 'Cancelado',
'Entrega em andamento', 'Finalizado', 'Em separação'))
);
```

#### **`05 - script_insert_table.sql`**

- Dados de exemplo para todas as tabelas
- Cenários de teste para diferentes formas de pagamento
- Casos de uso realistas para análise

#### **`06 - script_queries.sql`**

Consultas

1. Listar as parcelas para um determinado mês (exemplo: janeiro de 2026).
2. Listar todas as parcelas de um pedido específico, mostrando o número da parcela e a data de vencimento.
3. Contar  todos os pedidos de um cliente específico.
4. Listar os clientes que ainda têm pagamentos pendentes.
5. Mostrar o total pago por cada cliente
6. Mostrar todas as parcelas em Pendente  com o nome do cliente e valor que falta a pagar
7. Selecionar os clientes que pagaram com o dinheiro.
8. Selecionar todos os pagamentos em que não foram aplicados qualquer tipo de desconto.
9. Selecionar pagamentos parcelados acima de 3x.
10. Listar os 3 clientes que mais realizaram pedidos.
11. Mostrar a evolução mensal do volume de pagamentos.
12. Listar os pedidos onde o valor total pago é superior em mais de 5% ao valor bruto do pedido, mostrando a porcentagem exata do acréscimo.
13. Listar clientes que fizeram mais de um pedido e utilizam formas de pagamento diferentes.

#### **`07 - script_indexes.sql`**

```sql
-- Exemplo de criação de indices
create index idx_clientes_nome on modulo_pagamentos.clientes(nome);
create index idx_clientes_email on modulo_pagamentos.clientes(email);

create index idx_pedidos_id_cliente on modulo_pagamentos.pedidos(id_cliente);
create index idx_pedidos_status on modulo_pagamentos.pedidos(status_pedido);
create index idx_pedidos_data on modulo_pagamentos.pedidos(data_pedido);
```

## **🚀 Instruções de Uso**

### **Visualizando os Diagramas**

1. **Modelo Conceitual**:
    
    ```bash
    # Abrir com BrModelo
    Abra o arquivo diagrams/01 - Conceitual.brM3 no BrModelo
    ```
    
2. **Modelo Lógico**:
    
    ```bash
    # Abrir com MySQL Workbench
    Abra o arquivo diagrams/02 - Lógico.mwb no MySQL Workbench
    ```
    

### **Executando no PostgreSQL**

1. **Conectar ao banco**:
    
    ```sql
    -- Via DBeaver ou psql
    \c nome_do_seu_banco
    ```
    
2. **Executar scripts em ordem**:
    
    ```sql
    \i sql/04 - script_create_table.sql
    \i sql/05 - script_insert_table.sql
    \i sql/07 - script_indexes.sql
    ```
    
3. **Testar consultas**:
    
    ```sql
    \i sql/06 - script_queries.sql
    ```
    

## **💡 Principais Aprendizados Técnicos**

- **Aplicação da modelagem em camadas (conceitual → lógico → físico)** garantindo estrutura consistente e evolução segura do modelo.
- **Normalização até 3FN**, eliminando redundâncias e assegurando integridade dos dados.
- **Definição precisa de PKs, FKs, UNIQUE e CHECK**, aplicando regras de negócio diretamente no banco.
- **Modelagem de pagamentos parcelados** com relacionamento 1:N e controle individual de vencimento, status e valor.
- **Implementação de domínios de status** utilizando constraints para prevenir estados inválidos.
- **Estruturação de tabelas com tipos adequados** (BOOLEAN, DECIMAL, TIMESTAMP) e defaults inteligentes.
- **Criação de índices otimizados** para acelerar consultas e melhorar performance do modelo.
- **Escrita de consultas SQL analíticas e operacionais** usando JOINs, agregações, subconsultas e filtros compostos.
- **Simulação de cenários financeiros reais**, incluindo juros, descontos, parcelamentos e diferentes métodos de pagamento.
- **Organização modular dos scripts SQL**, separando DDL, inserts, queries e índices para facilitar manutenção.
- **Utilização de ferramentas especializadas** (BrModelo, MySQL Workbench, PostgreSQL e DBeaver) em cada etapa do projeto.
- **Visão sistêmica da modelagem**, entendendo como decisões estruturais impactam performance, relatórios e evolução futura.

## **🪪 Licença**

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](https://license/) para detalhes  |  Feito com 💙 por LARISSA PANISSET
