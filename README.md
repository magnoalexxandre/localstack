# Projeto Terraform com LocalStack

Este projeto demonstra como usar o Terraform para provisionar infraestrutura da AWS em um ambiente de desenvolvimento local, utilizando o LocalStack para simular os serviços da AWS. O ambiente é orquestrado com Docker Compose.

O código Terraform neste exemplo provisiona uma simples instância EC2.

## Tecnologias Utilizadas

- **Terraform**: Ferramenta de Infraestrutura como Código (IaC) para provisionar recursos.
- **LocalStack**: Simulador de serviços da nuvem AWS que roda em um contêiner Docker.
- **Docker & Docker Compose**: Para criar e gerenciar o ambiente de contêineres.

## Pré-requisitos

Antes de começar, garanta que você tenha os seguintes softwares instalados:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (ou Docker Engine com Docker Compose).
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) (o binário precisa estar acessível no PATH do seu sistema).
- Uma conta no [LocalStack Web App](https://app.localstack.cloud) para visualização dos recursos.

## Configuração

1.  **Clone este repositório:**
    ```sh
    git clone <url-do-seu-repositorio>
    cd localstack_terraform
    ```

2.  **Configure a API Key do LocalStack:**
    - Crie uma conta gratuita no [LocalStack Web App](https://app.localstack.cloud) para obter uma API Key.
    - Abra o arquivo `docker-compose.yaml`.
    - Encontre a linha `LOCALSTACK_API_KEY=sua_api_key_aqui` e substitua `sua_api_key_aqui` pela sua chave real.

    ```yaml
    # docker-compose.yaml
    services:
      localstack:
        # ...
        environment:
          - LOCALSTACK_API_KEY=sua_api_key_aqui # <-- SUBSTITUA AQUI
          # ...
    ```

## Como Executar

Com os pré-requisitos e a configuração concluídos, siga os passos abaixo para provisionar a infraestrutura.

1.  **Inicie o Ambiente LocalStack:**
    Execute o comando abaixo na raiz do projeto para iniciar o contêiner do LocalStack em modo "detached" (background).
    ```sh
    docker-compose up -d --build
    ```
    Aguarde um minuto para que o LocalStack esteja totalmente operacional.

2.  **Navegue até o diretório do Terraform:**
    ```sh
    cd terraform
    ```

3.  **Inicialize o Terraform:**
    Este comando prepara o diretório de trabalho para os outros comandos do Terraform, baixando os providers necessários.
    ```sh
    terraform init
    ```

4.  **Planeje as Mudanças:**
    O comando `plan` cria um plano de execução para você revisar. Ele mostra quais recursos o Terraform irá criar, alterar ou destruir.
    ```sh
    terraform plan
    ```

5.  **Aplique as Mudanças:**
    Este comando aplica as mudanças planejadas, criando de fato a instância EC2 no ambiente LocalStack.
    ```sh
    terraform apply
    ```
    Digite `yes` quando solicitado para confirmar.

## Verificando os Recursos

- **Via Console Web:** Após o `terraform apply` ser concluído com sucesso, acesse o seu dashboard no [LocalStack Web App](https://app.localstack.cloud). Navegue até a seção do EC2 para visualizar a instância que foi criada.
- **Via AWS CLI:** Você também pode configurar a [AWS CLI para apontar para o LocalStack](https://docs.localstack.cloud/user-guide/integrations/aws-cli/) e listar os recursos via linha de comando.

## Destruindo o Ambiente

Para remover todos os recursos criados pelo Terraform no LocalStack, execute:

```sh
# No diretório /terraform
terraform destroy
```

Para parar e remover os contêineres do Docker, execute:

```sh
# Na raiz do projeto
docker-compose down
```
