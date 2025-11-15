-- Inserir dados na tabela clientes

insert into modulo_pagamentos.clientes(nome, endereco, telefone, email)
values 
    ('Ana Silva', 'Rua Osvaldo, nº 43', '(11) 99239-4569', 'ana.silva@email.com'),
    ('Bruno Costa', 'AV. Dennis Vasco, nº 02', '(22) 2778-5435', 'bruno.costa@email.com'),
    ('Carla Mendes', 'rua São Paulo, S/N', '(22) 99823-8937', 'carla.mendes@email.com'),
    ('Daniel Rocha', 'Rua Jorge Alves, 22', '(11) 9934-5121', 'daniel.rocha@email.com'),
    ('Eduarda Pereira', 'Rua São Pedro, número 11', '(51) 998232390', 'eduarda.pereira@email.com'),
    ('Felipe Martins', 'rua princesa vitória, numéro 248', '(21) 9832-3475', 'felipe.martins@email.com'),
    ('Gabriela Lima', 'Rua dos Santos, 194', '(11) 2778-3775', 'gabriela.lima@email.com'),
    ('Henrique Souza', 'Rua Goias, nº 55', '(11) 9996-2263', 'henrique.souza@email.com'),
    ('Isabela Ramos', 'Rua Valter Campos, nº 36', '(11) 9923-5473', 'isabela.ramos@email.com'),
    ('Joao Alves', 'Rua Dias Costas, nº 102', '(11) 99834-7583', 'joao.alves@email.com');

-- Inserir dados na tabela pedidos

insert into modulo_pagamentos.pedidos(id_cliente, valor_bruto, status_pedido)
values
    (1, 275.00, 'Pagamento Confirmado'),
    (3, 543.55, 'Pagamento Pendente'),
    (9, 435.00, 'Finalizado'),    
    (4, 543.00, 'Pagamento Confirmado'),
    (10, 632.00, 'Pagamento Pendente'),
    (2, 122.00, 'Finalizado'),
    (5, 854.00, 'Pagamento Pendente'),
    (6, 2035.22, 'Pagamento Pendente'),
    (3, 1323.25, 'Pagamento Confirmado'),
    (6, 234.00, 'Pagamento Confirmado'),
    (7, 258.00, 'Finalizado'),
    (8, 643.98, 'Pagamento Pendente'),    
    (5, 345.99, 'Entrega em andamento'),
    (9, 782.98, 'Pagamento Pendente');

-- Inserir dados na tabela forma_pagamentos

insert into modulo_pagamentos.forma_pagamento(nome, descricao, permite_parcelamento, quantidade_max_parcelas, valor_min_parcela,
percentual_juros_mes, percentual_desconto, ativo)
values 
   ('Cartão Crédito', 'Pagamento com cartão', TRUE, 12, 50.00, 2, 0, TRUE),
   ('Cartão Débito', 'Pagamento a vista no cartão', FALSE, 1, 0, 0, 5, TRUE),
   ('PIX', 'Pagamento a vista no PIX', FALSE, 1, 0, 0, 10, TRUE),
   ('Dinheiro', 'Pagamento a vista no dinheiro', FALSE, 1, 0, 0, 10, TRUE),
   ('Boleto', 'Pagamento a vista no boleto', FALSE, 1, 0, 0, 5, TRUE);

-- Inserir dados na tabela pagamentos

insert into modulo_pagamentos.pagamentos(id_pedido, id_forma_pagamento, valor_total, status_pagamento, quantidade_parcelas)
values
    (1, 4, 247.5, 'Aprovado', 1),
    (2, 1, 587.03, 'Pendente', 4),
    (3, 3, 391.5, 'Aprovado', 1),    
    (4, 4, 488.7, 'Aprovado', 1),
    (5, 1, 682.56, 'Pendente', 6),
    (6, 3, 109.8, 'Aprovado', 1),
    (7, 1, 939.4, 'Pendente', 5),
    (8, 1, 2157.33, 'Pendente', 3),
    (9, 4, 1190.92, 'Aprovado', 1),
    (10, 2, 222.30, 'Aprovado', 1),
    (11, 4, 232.20, 'Aprovado', 1),
    (12, 1, 682.62, 'Pendente', 3),    
    (13, 3, 328.69, 'Aprovado', 1),
    (14, 1, 845.62, 'Pendente', 4);



-- Inserir dados na tabela parcelas

-- Pagamento 1 (ID 1) - Dinheiro - 1 parcela
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento, data_pagamento)
values
    (1, 1, 247.5, 'Paga', '2025-11-09', '2025-11-09');

-- Pagamento 2 (ID 2) - Cartão Crédito - 4 parcelas
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento)
values
    (2, 1, 146.76, 'Pendente', '2025-12-09'),
    (2, 2, 146.76, 'Pendente', '2026-01-09'),
    (2, 3, 146.76, 'Pendente', '2026-02-09'),
    (2, 4, 146.76, 'Pendente', '2026-03-09');

-- Pagamento 3 (ID 3) - PIX - 1 parcela
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento, data_pagamento)
values
    (3, 1, 391.5, 'Paga', '2025-11-09', '2025-11-09');

-- Pagamento 4 (ID 4) - Dinheiro - 1 parcela
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento, data_pagamento)
values
    (4, 1, 488.7, 'Paga', '2025-11-09', '2025-11-09');

-- Pagamento 5 (ID 5) - Cartão Crédito - 6 parcelas
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento)
values
    (5, 1, 113.76, 'Pendente', '2025-12-09'),
    (5, 2, 113.76, 'Pendente', '2026-02-09'),
    (5, 3, 113.76, 'Pendente', '2026-02-09'),
    (5, 4, 113.76, 'Pendente', '2026-03-09'),
    (5, 5, 113.76, 'Pendente', '2026-04-09'),
    (5, 6, 113.76, 'Pendente', '2026-05-09');

-- Pagamento 6 (ID 6) - PIX - 1 parcela
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento, data_pagamento)
values
    (6, 1, 109.8, 'Paga', '2025-11-09', '2025-11-09');

-- Pagamento 7 (ID7) - Dinheiro - 5 parcelas
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento)
values
    (7, 1, 187.88, 'Pendente', '2025-12-09'),
    (7, 2, 187.88, 'Pendente', '2026-01-09'),
    (7, 3, 187.88, 'Pendente', '2026-02-09'),
    (7, 4, 187.88, 'Pendente', '2026-03-09'),
    (7, 5, 187.88, 'Pendente', '2026-04-09');
    
-- Pagamento 8 (ID 8) - Dinheiro - 3 parcelas
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento)
values
    (8, 1, 719.11, 'Pendente', '2025-12-09'),
    (8, 2, 719.11, 'Pendente', '2026-01-09'),
    (8, 3, 719.11, 'Pendente', '2026-02-09');

-- Pagamento 9 (ID 9) - Dinheiro - 1 parcela
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento, data_pagamento)
values
    (9, 1, 1190.92, 'Paga', '2025-11-09', '2025-11-09');


-- Pagamento 10 (ID 10) - Crédito Débito - 1 parcela
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento, data_pagamento)
values
    (10, 1, 222.30, 'Paga', '2025-11-09', '2025-11-09');

-- Pagamento 11 (ID 11) - Dinheiro - 1 parcela
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento, data_pagamento)
values
    (11, 1, 232.20, 'Paga', '2025-11-09', '2025-11-09');

-- Pagamento 12 (ID 12) - Cartão Crédito - 3 parcelas
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento)
values
    (12, 1, 227.54, 'Pendente', '2025-12-09'),
    (12, 2, 227.54, 'Pendente', '2026-01-09'),
    (12, 3, 227.54, 'Pendente', '2026-02-09');

-- Pagamento 13 (ID 13) - PIX - 1 parcela
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento, data_pagamento)
values
    (13, 1, 328.69, 'Paga', '2025-11-09', '2025-11-09');

-- Pagamento 14 (ID 14) - Cartão Crédito - 4 parcelas
insert into modulo_pagamentos.parcelas(id_pagamento, numero_parcela, valor_parcela, status_parcela, data_vencimento)
values
    (14, 1, 211.40, 'Pendente', '2025-12-09'),
    (14, 2, 211.40, 'Pendente', '2026-01-09'),
    (14, 3, 211.40, 'Pendente', '2026-02-09'),
    (14, 4, 211.40, 'Pendente', '2026-03-09');
 

