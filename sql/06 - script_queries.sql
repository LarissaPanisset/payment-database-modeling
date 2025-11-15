
SET search_path TO modulo_pagamentos, public;


-- Exercício 1
select 
    id_parcela,
    data_vencimento
from parcelas 
where data_vencimento between '2026-01-01' and '2026-01-31';

-- Exercício 2
select 
    pa.id_pedido,
    p.id_parcela,
    p.numero_parcela,
    p.data_vencimento 
from parcelas p
inner join pagamentos pa on p.id_pagamento = pa.id_pagamento 
where pa.id_pedido = 2;

-- Exercício 3
select 
    COUNT(p.id_pedido) as quantidade_pedidos
from pagamentos p 
inner join pedidos pe on p.id_pedido = pe.id_pedido 
where pe.id_cliente = 3;

-- Exercício 4
select
    c.id_cliente,
    c.nome
from clientes c
inner join pedidos p on c.id_cliente = p.id_cliente 
inner join pagamentos pa on p.id_pedido = pa.id_pedido 
where pa.status_pagamento = 'Pendente';

-- Exercício 5
select
   c.id_cliente,
   SUM(pa.valor_total) as total_gasto
from clientes c 
inner join pedidos p on c.id_cliente = p.id_cliente
inner join pagamentos pa on p.id_pedido = pa.id_pedido
group by c.id_cliente
order by c.id_cliente;

-- Exercício 6
select
   c.nome,
   SUM(p1.valor_parcela) as total_a_pagar
from clientes c 
inner join pedidos p on c.id_cliente = p.id_cliente
inner join pagamentos pa on p.id_pedido = pa.id_pedido
inner join parcelas p1 on p1.id_pagamento = pa.id_pagamento
where p1.status_parcela = 'Pendente'
group by c.nome;

-- Exercício 7
select
   c.nome
from clientes c 
inner join pedidos p on c.id_cliente = p.id_cliente
inner join pagamentos pa on p.id_pedido = pa.id_pedido
where pa.id_forma_pagamento = 4
group by c.id_cliente, c.nome;

-- Exercício 8
select
   p.id_pagamento
from pagamentos p
inner join forma_pagamento f on f.id_forma_pagamento = p.id_forma_pagamento 
where f.percentual_desconto = 0;

-- Exercício 9
select
   pa.id_pagamento,
   pa.quantidade_parcelas
from pagamentos pa 
where pa.quantidade_parcelas > 3;

-- Exercício 10
select
   c.nome,
   COUNT(p.id_pedido) as total_de_pedidos
from clientes c 
inner join pedidos p on c.id_cliente = p.id_cliente
group by c.nome
order by total_de_pedidos desc
limit 3;

-- Exercício 11
select
case EXTRACT(MONTH from p.data_vencimento)
      WHEN 01 THEN 'Janeiro'
      WHEN 02 THEN 'Fevereiro'
      WHEN 03 THEN 'Março'
      WHEN 04 THEN 'Abril'
      WHEN 05 THEN 'Maio'
      WHEN 06 THEN 'Junho'
      WHEN 07 THEN 'Julho'
      WHEN 08 THEN 'Agosto'
      WHEN 09 THEN 'Setembro'
      WHEN 10 THEN 'Outubro'
      WHEN 11 THEN 'Novembro'
      WHEN 12 THEN 'Dezembro'
   END as mes,
   SUM(p.valor_parcela) as total_a_pagar
from parcelas p
group by 
   EXTRACT(MONTH from p.data_vencimento),
   case EXTRACT(MONTH from p.data_vencimento)
      WHEN 1 THEN 'Janeiro'
      WHEN 2 THEN 'Fevereiro'
      WHEN 3 THEN 'Março'
      WHEN 4 THEN 'Abril'
      WHEN 5 THEN 'Maio'
      WHEN 6 THEN 'Junho'
      WHEN 7 THEN 'Julho'
      WHEN 8 THEN 'Agosto'
      WHEN 9 THEN 'Setembro'
      WHEN 10 THEN 'Outubro'
      WHEN 11 THEN 'Novembro'
      WHEN 12 THEN 'Dezembro'
   END
order by EXTRACT(MONTH from p.data_vencimento);


-- Exercício 12
WITH calculo_variacao as (
   select
      p.id_pedido,       
      ((p1.valor_total - p.valor_bruto) / p.valor_bruto) * 100 as variacao_percentual
   from pedidos p
   inner join pagamentos p1 on p.id_pedido = p1.id_pedido 
)
select
   id_pedido,                                       
   ROUND(variacao_percentual, 2) as variacao_percentual,
   'acréscimo' as situacao  -- Como filtramos apenas >5%, sempre será "A MAIS"
from calculo_variacao                                   
where variacao_percentual > 5;  -- Apenas onde o valor pago é MAIOR que o valor bruto

-- Exercício 13
select
    c.nome,
    COUNT(p.id_pedido) as total_pedidos
from clientes c
inner join pedidos p on p.id_cliente = c.id_cliente
inner join pagamentos p1 on p1.id_pedido = p.id_pedido
group by c.id_cliente, c.nome
having COUNT(p.id_pedido) > 1 
   AND COUNT(distinct p1.id_forma_pagamento) > 1;
