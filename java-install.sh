#!/bin/bash

PURPLE='\033[0;35m'
NC='\033[0m'
VERSAO=17
jar_url="https://github.com/guilhermesnto/jar-individual/raw/main/Nexus/target/Nexus-1.0-jar-with-dependencies.jar"
jar_nome="Nexus-1.0-jar-with-dependencies.jar"


# Nome da empresa
EMPRESA="Nexus"

# Função para instalar o Java e executar o arquivo JAR
installJavaNexus() {
    echo -e "${PURPLE}[${EMPRESA}]:${NC} Olá usuário, serei seu assistente para instalação do Java e execução do arquivo JAR!"
    echo -e "${PURPLE}[${EMPRESA}]:${NC} Verificando se você possui o Java instalado na sua máquina..."
    sleep 2

    # Verifica se o Java está instalado
    java -version
    if [ $? -eq 0 ]; then
        echo -e "${PURPLE}[${EMPRESA}]:${NC} Você já possui o Java instalado na sua máquina!"
    else
        echo -e "${PURPLE}[${EMPRESA}]:${NC} Não foi encontrada nenhuma versão do Java na sua máquina, mas iremos resolver isso!"
        while true; do
            echo -e "${PURPLE}[${EMPRESA}]:${NC} Você deseja instalar o Java na sua máquina (S/N)?"
            read inst
            if [ "$inst" == "S" ]; then
                break
            elif [ "$inst" == "N" ]; then
                echo -e "${PURPLE}[${EMPRESA}]:${NC} Você optou por não instalar o Java por enquanto."
                return
            else
                echo -e "${PURPLE}[${EMPRESA}]:${NC} Opção inválida. Por favor, insira 'S' para sim ou 'N' para não."
            fi
        done

        echo -e "${PURPLE}[${EMPRESA}]:${NC} Ok! Você decidiu instalar o Java na máquina, uhul!"
        echo -e "${PURPLE}[${EMPRESA}]:${NC} Adicionando o repositório!"
        sudo add-apt-repository ppa:linuxuprising/java
        if [ $VERSAO -eq 17 ]; then
            echo -e "${PURPLE}[${EMPRESA}]:${NC} Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
            sudo apt-get install openjdk-17-jdk -y
            clear

            echo -e "${PURPLE}[${EMPRESA}]:${NC} Java instalado com sucesso!"
            echo -e "${PURPLE}[${EMPRESA}]:${NC} Vamos atualizar os pacotes..."
            sudo apt update && sudo apt upgrade -y
            clear
        fi
    fi

    # Verificando se a nossa aplicacao ja esta instalada!

    if [ ! -f "$jar_nome" ]; then
        sudo apt install wget -y
        echo -e "${PURPLE}[${EMPRESA}]:${NC} Baixando o arquivo JAR..."
        sudo wget "$jar_url" -O "$jar_nome"
        if [ $? -eq 0 ]; then
            echo -e "${PURPLE}[${EMPRESA}]:${NC} Arquivo JAR baixado com sucesso!"
            echo -e "${PURPLE}[${EMPRESA}]:${NC} Agora vamos executar o arquivo JAR..."
            java -jar "$jar_nome"
        else
            echo -e "${PURPLE}[${EMPRESA}]:${NC} Erro ao baixar o arquivo JAR do GitHub"
        fi
    else
        echo -e "${PURPLE}[${EMPRESA}]:${NC} Arquivo ja instalado!"
        echo -e "${PURPLE}[${EMPRESA}]:${NC} Executando o arquivo!"
        java -jar "$jar_nome"
    fi
}

# Main script - functions
installJavaNexus
