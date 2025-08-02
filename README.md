# Gerador de Guia de Viagem

## Introdução

**Objetivo:**  
Este projeto tem como objetivo gerar um guia de passeios turísticos utilizando o Amazon Bedrock. Para isso, utiliza-se uma AWS Lambda que gera um prompt personalizado e envia para o Bedrock, orquestrada por uma Step Function.

**Tecnologias Utilizadas:**  
- Terraform (Infraestrutura como Código)
- Python (Linguagem de Programação para AWS Lambda)

**Estrutura do Projeto:**  
Na raiz do projeto estão os códigos Terraform para criar os recursos na AWS. Na pasta `script` está o código Python para a Lambda que gera o prompt.

## Pré-requisitos
Ter o cliente GIT, Terraform e o AWS CLI instalado na máquina 

## Utilização
- Abra o Terminal
- Clone o Repositório:
```bash
git clone https://github.com/AleTavares/assistente_viagem.git
```
- Acesse a pasta criada
```bash
cd assistente_viagem
```
- Crie as variáveis de ambiente para a AWS com as chaves
```bash
export AWS_ACCESS_KEY_ID=[coloque aqui a sua Access Key da AWS]
export AWS_SECRET_ACCESS_KEY=[coloque aqui a sua secret key da AWS]
```
- Inicialize o Terraform
```bash
terraform init
```
- Crie o plano de execução do Terraform
```bash
terraform plan -out plan.out
```
- Aplique o plano de execução do Terraform criado
```bash
terraform apply plan.out
```

Após a execução deste código será gerada a seguinte arquitetura na sua conta da AWS:
![Arquitetura](/img/assistenteViagem.png)
