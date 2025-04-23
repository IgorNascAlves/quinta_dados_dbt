### 📝 `README.md`

# 🏗️ Projeto Lakehouse com DBT + MySQL

Este projeto demonstra uma arquitetura de **Lakehouse local** utilizando **MySQL + Docker + DBT**, organizada em camadas **Bronze**, **Silver** e **Gold**, seguindo o modelo de arquitetura de dados em medalhas.


## 📌 Objetivo

Simular um ambiente de dados com:
- Ingestão de dados brutos (Bronze)
- Limpeza e padronização (Silver)
- Agregações e métricas analíticas (Gold)

Usando:
- 🐬 **MySQL 8** via Docker
- 🧙 **DBT (Data Build Tool)**
- 🐍 Python + Virtualenv
- Arquitetura modular e escalável

---

## 🧱 Arquitetura (Medalhas)

```
+-----------+         +-----------+         +-----------+
|  Bronze   |  --->   |  Silver   |  --->   |   Gold    |
| raw data  |         | cleansed  |         | KPIs, BI  |
+-----------+         +-----------+         +-----------+
```

- **Bronze**: dados brutos (ingestão direta no MySQL)
- **Silver**: dados tratados com lógica de negócio
- **Gold**: visão analítica e sumarizações

---

## 🚀 Setup Rápido

### 1. Clone o projeto

```bash
git clone https://github.com/seu-usuario/seu-repo.git
cd seu-repo
```

### 2. Suba o MySQL com Docker

```bash

docker stop mysql-lakehouse

docker rm mysql-lakehouse

docker run --name mysql-lakehouse \
  -e MYSQL_ROOT_PASSWORD=<SUA_SENHA_AQUI> \
  -e MYSQL_DATABASE=lakehouse_bronze \
  -p 3307:3306 \
  -d mysql:8.3
```

> A porta 3307 foi usada para evitar conflitos locais.

### 3. Popular o banco com dados de exemplo

```bash
docker exec -i mysql-lakehouse \
  mysql -uroot -p<SUA_SENHA_AQUI> lakehouse_bronze < populate_mysql.sql
```

---

## ⚙️ DBT Setup

### 1. Crie e ative o ambiente virtual (opcional)

```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
```

### 2. Instale o DBT

```bash
pip install dbt-mysql
```

### 3. Configure o perfil DBT

No arquivo `~/.dbt/profiles.yml`, adicione:

```yaml
lakehouse:
  target: dev
  outputs:
    dev:
      type: mysql
      server: 127.0.0.1
      port: 3307
      user: root
      password: <SUA_SENHA_AQUI>
      schema: lakehouse_bronze  # inicial, será sobrescrito por cada camada
```

---

## 🏃 Comandos Úteis

```bash
# Preparar o ambiente
dbt clean
dbt deps

# Testar conexão
dbt debug

# Rodar os modelos
dbt run

# Visualizar docs gerados
dbt docs generate
dbt docs serve

```

---

## 📂 Estrutura do Projeto

```
models/
├── bronze/
│   └── schema.yml             # Fonte de dados bruta
├── silver/
│   └── stg_orders.sql         # Limpeza e transformações
├── gold/
    └── orders_summary.sql     # Métricas finais
```

---

## 📊 Resultado

Exemplos de queries após rodar o `dbt run`:

```sql
-- Bronze
SELECT * FROM lakehouse_bronze.raw_orders;

-- Silver
SELECT * FROM lakehouse_silver.stg_orders;

-- Gold
SELECT * FROM lakehouse_gold.orders_summary;
```

---

## 🧠 Observações

- Esse projeto usa múltiplos bancos (schemas) MySQL para simular camadas do Lakehouse.
- É ideal para apresentações, POCs ou estudo de pipelines analíticos modernos.

---
