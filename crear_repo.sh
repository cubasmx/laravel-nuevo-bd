#!/bin/bash

# Configuración fija
USER="cubasmx"

# Solicitar datos al usuario
echo "--- Automatización GitHub ($USER) ---"
read -p "Nombre del nuevo repositorio: " REPO_NAME
read -sp "Introduce tu Personal Access Token (PAT): " TOKEN
echo -e "\n"

# Llama a la API de GitHub para crear el repo
RESPONSE=$(curl -s -u "$USER:$TOKEN" https://api.github.com/user/repos \
    -d "{\"name\":\"$REPO_NAME\", \"private\":false}")

# Verificar si se creó exitosamente
if [[ $RESPONSE == *"\"name\": \"$REPO_NAME\""* ]]; then
    echo "✅ Repositorio '$REPO_NAME' creado con éxito en github.com/$USER/$REPO_NAME"
    
    # Opcional: Inicializar localmente y conectar
    read -p "¿Deseas inicializar este repo localmente ahora? (s/n): " INIT
    if [[ $INIT == "s" || $INIT == "S" ]]; then
        mkdir $REPO_NAME
        cd $REPO_NAME
        git init
        touch README.md
        git add README.md
        git commit -m "Initial commit"
        git branch -M main
        git remote add origin https://github.com/$USER/$REPO_NAME.git
        echo "🚀 Carpeta creada y vinculada a GitHub."
    fi
else
    echo "❌ Error al crear el repositorio. Revisa tu Token o si el nombre ya existe."
    echo "Respuesta del servidor: $RESPONSE"
fi

