# Gerador de Guia de Viagem
## Introdução
**Objetivo:** Gerar um gia de passeios utilizando o Amazon Bedrock e pra isso vamos utilizar uma lambda que gera um prompt e envia para o Bedrock, orquestrada por uma stepfunction

**Tecnologias:** 
Terraform e python.

**Estrutura do Projeto:** 
Na raiz do projeto estão os codigos terraform para criar os recursos na AWS, na pasta script vai estar o codigo python para a lambda que gera o prompt

## Pré-requisitos
Ter o cliente GIT, Terraform e o AWS CLI instalado na maquina 

## Utilização
- Abra o Terminal
- Clone o Repositorio:
```bash
git clone https://github.com/AleTavares/assistente_viagem.git
```
- acesse a pasta criada
```bash
cd assistente_viagem
```
- Crie as variaveis de ambiente para a AWS com as chaves
```bash
export AWS_ACCESS_KEY_ID=[coloque aqui a sua Access Key da AWS]
export AWS_SECRET_ACCESS_KEY=[coloque aqui a sua secret key da AWS]

```
- Inicialize o Terraform
```bash
terraform init
```
- crie o plano de execução do terraform
```bash
terraform plan -out plan.out
```
- Aplique o plano de execução do terraform criado
```bash
terraform apply plan.out
```

Após a execução deste código sera gerada a seguinte arquitetura na sua conta da AWS:
![Arquitetura](/img/assistenteViagem.png)
