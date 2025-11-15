-- Criar schema

create schema modulo_pagamentos;

-- Criar tabela cliente

create table if not exists modulo_pagamentos.clientes (
   id_cliente SERIAL primary key,
   nome VARCHAR(60) not null,
   endereco VARCHAR (100) not null,
   telefone VARCHAR (15) not null,
   email VARCHAR(45) not null unique
);

-- Criar tabela pedidos

create table if not exists modulo_pagamentos.pedidos (
   id_pedido SERIAL primary key,
   id_cliente INT references modulo_pagamentos.clientes(id_cliente),
   valor_bruto DECIMAL(10,2) check (valor_bruto >= 0),
   status_pedido VARCHAR(45) not null default 'Pagamento Pendente',
   data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   constraint chk_status_pedido check (status_pedido in ('Pagamento Pendente', 'Pagamento Confirmado', 'Cancelado', 
'Entrega em andamento', 'Finalizado', 'Em separação'))
);

-- Criar tabela forma_pagamento

create table if not exists modulo_pagamentos.forma_pagamento (
   id_forma_pagamento SERIAL primary key,
   nome VARCHAR(45) not null,
   descricao VARCHAR(60),
   permite_parcelamento VARCHAR(45) not null,
   quantidade_max_parcelas INT not null,
   valor_min_parcela DECIMAL(10,2),
   percentual_juros_mes DECIMAL(5,2),
   percentual_desconto DECIMAL(5,2),
   ativo BOOLEAN DEFAULT TRUE
);

-- Criar tabela pagamentos

create table if not exists modulo_pagamentos.pagamentos (
   id_pagamento SERIAL primary key,
   id_pedido INT references modulo_pagamentos.pedidos(id_pedido),
   id_forma_pagamento INT references modulo_pagamentos.forma_pagamento(id_forma_pagamento),
   valor_total DECIMAL(10,2) check (valor_total >= 0),
   status_pagamento VARCHAR(45) not null default 'Pendente',
   quantidade_parcelas INT not null,
   constraint chk_status_pagamento check (status_pagamento in ('Pendente', 'Aprovado', 'Recusado', 'Estornado'))
);

-- Criar tabela parcelas

create table if not exists modulo_pagamentos.parcelas (
   id_parcela SERIAL primary key,
   id_pagamento INT references modulo_pagamentos.pagamentos(id_pagamento),
   numero_parcela INT not null,
   valor_parcela DECIMAL(10,2) not null,
   status_parcela VARCHAR(45) not null default 'Pendente',
   data_vencimento DATE not null,
   data_pagamento DATE,
   constraint chk_status_parcela check (status_parcela in ('Pendente', 'Paga', 'Vencida'))
);