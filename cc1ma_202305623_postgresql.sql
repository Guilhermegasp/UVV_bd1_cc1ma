
--Após conectar no usuário padrão, digite os 2 comando abaixo para deletar usuário ou databases com os nomes já existentes.
DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS  guilherme;

--Logo digite esses comandos abaixo para criar seu usuário e dar as permissões de criar databases e outras funções.
CREATE USER guilherme WITH PASSWORD '123';
ALTER USER guilherme CREATEDB;
ALTER USER guilherme CREATEROLE;
ALTER USER guilherme WITH SUPERUSER;

--Com o usuário criado e as permissões dadas, utilize esse comando para criar seu database da uvv.
CREATE DATABASE uvv
WITH   
OWNER = guilherme 
TEMPLATE = template0 
ENCODING = "UTF8" 
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8' 
ALLOW_CONNECTIONS = true;

\c "dbname=uvv user=guilherme password=123"

--Estando conectado insira os comando abaixo para criar um esquema e dar permissão para utilizá-lo.
CREATE SCHEMA lojas AUTHORIZATION guilherme;
GRANT USAGE ON SCHEMA lojas TO guilherme;

--Devemos confirmar se o esquema padrão é o "public".
SELECT CURRENT_SCHEMA();
SHOW SEARCH_PATH;

--Devemos fazer com que tudo que o usuário "guilherme" faça fique gravado no esquema "lojas", ou seja, tornamos ele o padrão. 
ALTER USER guilherme
SET SEARCH_PATH TO lojas, "$user", public;


--Abaixo segue a criação das tabelas, começando pela tabela dos produtos.
CREATE TABLE public.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id) --A PRIMARY KEY da tabela.
);
COMMENT ON TABLE public.produtos IS 'Essa será a tabela com as informações dos produtos.';
COMMENT ON COLUMN public.produtos.produto_id IS 'Coluna com o id dos produtos da tabela dos produtos.';
COMMENT ON COLUMN public.produtos.nome IS 'Coluna com o nome do produtos na tabela dos produtos.';
COMMENT ON COLUMN public.produtos.preco_unitario IS 'Coluna com o preço unitario do produto na tabela dos produtos.';
COMMENT ON COLUMN public.produtos.detalhes IS 'Coluna com detalhes dos produtos da tabela dos produtos.';
COMMENT ON COLUMN public.produtos.imagem IS 'Coluna com imagem do produto da tabela dos produtos.';
COMMENT ON COLUMN public.produtos.imagem_mime_type IS 'Coluna com detalhes da imagem na tabela dos produtos.';
COMMENT ON COLUMN public.produtos.imagem_arquivo IS 'Coluna com detalhes da imagem na tabela dos produtos.';
COMMENT ON COLUMN public.produtos.imagem_charset IS 'Coluna com detalhes da imagem na tabela dos produtos.';
COMMENT ON COLUMN public.produtos.imagem_ultima_atualizacao IS 'Coluna com a ultima atualização da imagem do produto na tabela dos produtos.';


--Criação da tabela das lojas.
CREATE TABLE public.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id) --A PRIMARY KEY da tabela.
);
COMMENT ON TABLE public.lojas IS 'Essa será a tabela com as informações das lojas.';
COMMENT ON COLUMN public.lojas.loja_id IS 'Coluna com o id da loja da tabela das lojas.';
COMMENT ON COLUMN public.lojas.nome IS 'Coluna com o nome das lojas da tabela das lojas.';
COMMENT ON COLUMN public.lojas.endereco_web IS 'Coluna com o endereço web da loja na tabela das lojas.';
COMMENT ON COLUMN public.lojas.endereco_fisico IS 'Coluna com o endereço físico da loja na tabela das lojas.';
COMMENT ON COLUMN public.lojas.latitude IS 'Coluna com a latitude da loja na tabela das lojas.';
COMMENT ON COLUMN public.lojas.longitude IS 'Coluna com a longitude da loja na tabela das lojas.';
COMMENT ON COLUMN public.lojas.logo IS 'Coluna com a logo da loja na tabela das lojas.';
COMMENT ON COLUMN public.lojas.logo_mime_type IS 'Coluna com detalhes da logo na tabela das lojas.';
COMMENT ON COLUMN public.lojas.logo_arquivo IS 'Coluna com detalhes da logo na tabela das lojas.';
COMMENT ON COLUMN public.lojas.logo_charset IS 'Coluna com detalhes da logo na tabela das lojas.';
COMMENT ON COLUMN public.lojas.logo_ultima_atualizacao IS 'Coluna com a ultima atualização da logo da loja na tabela das lojas.';


--Criação da tabela dos estoques.
CREATE TABLE public.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id) --A PRIMARY KEY da tabela
);
COMMENT ON TABLE public.estoques IS 'Essa será a tabela com informações dos estoques.';
COMMENT ON COLUMN public.estoques.estoque_id IS 'Coluna com o id do estoque da tabela dos estoques.';
COMMENT ON COLUMN public.estoques.loja_id IS 'Coluna com o id das lojas da tabela do estoques.';
COMMENT ON COLUMN public.estoques.produto_id IS 'Coluna com o id dos produtos da tabela dos estoques.';
COMMENT ON COLUMN public.estoques.quantidade IS 'Coluna com a quantidade de estoques da tabela dos estoques.';


--Criação da tabela dos clientes.
CREATE TABLE public.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id) --A PRIMARY KEY da tabela.
);
COMMENT ON TABLE public.clientes IS 'Essa é a tabela que tera as informações dos clientes.';
COMMENT ON COLUMN public.clientes.cliente_id IS 'Coluna com o id do cliente da tabela dos clientes.';
COMMENT ON COLUMN public.clientes.email IS 'Coluna com o email dos clientes da tabela dos clientes.';
COMMENT ON COLUMN public.clientes.nome IS 'Coluna com o nome dos clientes da tabela dos clientes.';
COMMENT ON COLUMN public.clientes.telefone1 IS 'Coluna com o telefone 1 dos clientes da tabela dos clientes.';
COMMENT ON COLUMN public.clientes.telefone2 IS 'Coluna com o telefone 2 dos clientes da tabela dos clientes.';
COMMENT ON COLUMN public.clientes.telefone3 IS 'Coluna com o telefone 3 dos clientes da tabela dos clientes.';


--Criação da tabela dos envios.
CREATE TABLE public.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id) --A PRIMARY KEY da tabela.
);
COMMENT ON TABLE public.envios IS 'Essa será a tabela com as informações dos envios.';
COMMENT ON COLUMN public.envios.envio_id IS 'Coluna com o id de envio da tabela dos envios.';
COMMENT ON COLUMN public.envios.loja_id IS 'Coluna com o id da loja da tabela dos envios.';
COMMENT ON COLUMN public.envios.cliente_id IS 'Coluna com o id dos clientes da tabela dos envios.';
COMMENT ON COLUMN public.envios.endereco_entrega IS 'Coluna com o endereço de entrega da tabela dos envios.';
COMMENT ON COLUMN public.envios.status IS 'Coluna com o status da tabela de envios.';


CREATE TABLE public.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE public.pedidos IS 'Essa será a tabela com informações dos pedidos.';
COMMENT ON COLUMN public.pedidos.pedido_id IS 'Coluna com o id dos pedidos da tabela pedidos.';
COMMENT ON COLUMN public.pedidos.data_hora IS 'Coluna com a data e hora da tabela dos pedidos.';
COMMENT ON COLUMN public.pedidos.cliente_id IS 'Coluna com o id do cliente da tabela de pedidos.';
COMMENT ON COLUMN public.pedidos.status IS 'Coluna com o status do pedido da tabela dos pedidos.';
COMMENT ON COLUMN public.pedidos.loja_id IS 'Coluna com o id da loja da tabela dos pedidos.';


--Criação da tabela de itens pedidos.
CREATE TABLE public.pedido_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedido_id__produto_id PRIMARY KEY (pedido_id, produto_id) --Há 2 PRIMARY KEY nessa tabela.
);
COMMENT ON TABLE public.pedido_itens IS 'Essa será a tabela com as informações de pedidos de itens.';
COMMENT ON COLUMN public.pedido_itens.pedido_id IS 'Coluna com o id dos pedidos da tabela de pedidos de itens.';
COMMENT ON COLUMN public.pedido_itens.produto_id IS 'Coluna com o id dos produtos da tabela de pedidos de itens.';
COMMENT ON COLUMN public.pedido_itens.numero_da_linha IS 'Coluna com o número da linha da tabela de pedido de itens.';
COMMENT ON COLUMN public.pedido_itens.preco_unitario IS 'Coluna com o preço unitario dos itens pedidos da tabela dos pedido de itens.';
COMMENT ON COLUMN public.pedido_itens.quantidade IS 'Coluna com a quantidade de pedidos da tabela pedido de itens.';
COMMENT ON COLUMN public.pedido_itens.envio_id IS 'Coluna com o id de envio da tabela de pedido de itens.';

--Abaixo segue os comandos para criação dos relacionamentos.
ALTER TABLE public.pedido_itens ADD CONSTRAINT produtos_pedido_itens_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedido_itens ADD CONSTRAINT envios_pedido_itens_fk
FOREIGN KEY (envio_id)
REFERENCES public.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedido_itens ADD CONSTRAINT pedidos_pedido_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES public.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- Adicionando restrição de preço unitário na tabela dos produtos.
ALTER TABLE produtos
ADD CONSTRAINT preco_negativo_produtos CHECK (preco_unitario >= 0);

-- Adicionando restrição de preço unitário negativo na tabela de pedido_itens.
ALTER TABLE pedido_itens
ADD CONSTRAINT preco_negativo_pedido_itens CHECK (preco_unitario >= 0);

-- Adicionando restrição da quantidade não ser negativa na tabela de estoques.
ALTER TABLE estoques
ADD CONSTRAINT restricao_quantidade_nao_negativa CHECK (quantidade >= 0);

-- Adicionando restrição da quantidade não ser negativa na tabela de pedido_itens.
ALTER TABLE pedido_itens
ADD CONSTRAINT restricao_quantidade_nao_negativa_pedido_itens CHECK (quantidade >= 0);

-- Adicionando restrição que garante que o endereço web ou físico, um deles, estaja assinalado.
ALTER TABLE lojas
ADD CONSTRAINT endereco_preenchido
CHECK ((endereco_web IS NOT NULL) OR (endereco_fisico IS NOT NULL));

-- Adicionado restrição de status para a tabela pedidos.
ALTER TABLE pedidos
ADD CONSTRAINT restricao_status_pedidos CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Adicionado restrição de status para a tabela envios.
ALTER TABLE envios
ADD CONSTRAINT restricao_status_envios CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));
