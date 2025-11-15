-- Índices para tabela clientes
create index idx_clientes_nome on modulo_pagamentos.clientes(nome);
create index idx_clientes_email on modulo_pagamentos.clientes(email);

-- Índices para tabela pedidos
create index idx_pedidos_id_cliente on modulo_pagamentos.pedidos(id_cliente);
create index idx_pedidos_status on modulo_pagamentos.pedidos(status_pedido);
create index idx_pedidos_data on modulo_pagamentos.pedidos(data_pedido);

-- Índices para tabela pagamentos
create index idx_pagamentos_id_pedido on modulo_pagamentos.pagamentos(id_pedido);
create index idx_pagamentos_id_forma_pagamento on modulo_pagamentos.pagamentos(id_forma_pagamento);
create index idx_pagamentos_status on modulo_pagamentos.pagamentos(status_pagamento);
create index idx_pagamentos_quantidade_parcelas on modulo_pagamentos.pagamentos(quantidade_parcelas);

-- Índices para tabela parcelas
create index idx_parcelas_id_pagamento on modulo_pagamentos.parcelas(id_pagamento);
create index idx_parcelas_status on modulo_pagamentos.parcelas(status_parcela);
create index idx_parcelas_data_vencimento on modulo_pagamentos.parcelas(data_vencimento);
create index idx_parcelas_data_pagamento on modulo_pagamentos.parcelas(data_pagamento);

-- Índices para tabela forma_pagamento
create index idx_forma_pagamento_ativo on modulo_pagamentos.forma_pagamento(ativo);
create index idx_forma_pagamento_desconto on modulo_pagamentos.forma_pagamento(percentual_desconto);