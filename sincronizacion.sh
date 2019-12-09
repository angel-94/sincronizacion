#!/bin/bash

# A menu driven shell script sample template 
## ----------------------------------
# Step #1: Define variables
# ----------------------------------
STD='\033[0;0;39m'

RED='\033[0;41;30m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
LIGHT_GREEN='\033[0;92m'
CYAN='\033[0;96m'

CONSUTAS=guac-consulCat
ADMINISTRACION=guac-adminCat
CARGAS=guac-cargasBatch
EMAIL=guac-emailDispatch
FRONT=guac-frontend

BRANCH=istio

BOLD=$(tput bold)

# ~/git-meltsan.sh

# First validate if env variable exist
if [[ -z "${MELTSAN_DIR}" ]]; then
	echo -e "${PURPLE}Hay que definir la variable 'export MELTSAN_DIR=...'"
	exit 1
else
  	echo ""
fi

# First validate if env variable exist
if [[ -z "${AMIS_DIR}" ]]; then
	echo -e "${PURPLE}Hay que definir la variable 'export AMIS_DIR=...'"
	exit 1
else
  	echo ""
fi


# ----------------------------------
# Step #2: User defined function
# ----------------------------------
pause() {
	print_line
    read -p "Press [Enter] key to continue..." fackEnterKey
}


# do something in two()
print_asterisk() {
	printf '*%.0s' {1..100} && printf '\n'
}


# do something in two()
print_line() {
	printf '\n\n'
}


# do something in two()
print_final_message() {
	echo -e "${CYAN}"
	print_asterisk
	echo -e "Ahora entrar al siguiente directorio:"
	echo -e "${BOLD}${AMIS_DIR}/${REPO_DIR} ${STD}"
	print_asterisk
	echo -e "${CYAN}Ahora asegurate de seguir los siguientes pasos"
	echo -e "1.- Valida los cambios efectuados"
	echo -e "2.- Agrega los cambios al stage"
	echo -e "1.- Crear el commit de los cambios"
	echo -e "1.- Sube los cambios a la rama ${BRANCH}"
	echo -e "1.- Crea el tag con el comando --- git tag -a guac-front-v0.0.22 -m 'MENSAJE' ---"
	echo -e "1.- Has push del tag con el comando --- git push origin TAG"
	print_asterisk
	echo -e "${STD}"
}


# do something in two()
common_commands() {
	print_asterisk
	echo -e "${GREEN}*** Sincronización de ${STD}${BOLD} ---${REPO_DIR}---${STD}${GREEN} ***"
	echo -e "${GREEN}*** bajamos cambios del repo de meltsan ***${STD}"
    print_asterisk
    make update-mts-repo -s

	print_line
	print_asterisk
	print_asterisk
	echo -e "${GREEN}*** bajamos cambios del repo de amis ***${STD}"
	print_asterisk
	print_asterisk
	print_line
    
	make update-amis-repo -s
	
	delete_files_amis_repo
	copy_mts_files_to_amis

	print_final_message

    pause
}


# do something in two()
consultas() {
	export REPO_DIR=${CONSUTAS}
    common_commands
}


# do something in two()
administracion() {
	export REPO_DIR=${ADMINISTRACION}
    common_commands
}


# do something in two()
cargas() {
	export REPO_DIR=${CARGAS}
    common_commands
}


# do something in two()
email() {
	export REPO_DIR=${EMAIL}
    common_commands
}


# do something in two()
frontend() {
	export REPO_DIR=${FRONT}
    common_commands
}


# do something in two()
execute_all() {
	consultas
	administracion
	cargas
	email
	frontend
}


# do something in two()
delete_files_amis_repo() {
	print_line
	print_line
	cd ${AMIS_DIR}/${REPO_DIR}
	print_asterisk
	echo -e "${BOLD}*** Borrar archivos del siguiete directorio ***${STD}"
	pwd
	print_asterisk
	yes | rm -rf *
}


# do something in two()
copy_mts_files_to_amis() {
	
	print_asterisk
	echo -e "${BOLD}*** Ejecutamos el siguiente comando -> \n cp -rf ${MELTSAN_DIR}/${REPO_DIR}/* ${AMIS_DIR}/${REPO_DIR}${STD}"
	print_asterisk

	cp -rf ${MELTSAN_DIR}/${REPO_DIR}/* ${AMIS_DIR}/${REPO_DIR}

	cd ${AMIS_DIR}/${REPO_DIR}
	git status
	print_asterisk
	echo -e "${BOLD}*** Movemos todos los archivos al siguiente directorio ${AMIS_DIR}/${REPO_DIR}${STD}"
	print_asterisk
}


# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo " SINCRONIZACION DE GUAC "
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Sincronización de guac-consultas"
	echo "2. Sincronización de guac-administración"
	echo "3. Sincronización de guac-cargas"
    echo "4. Sincronización de guac-email"
    echo "5. Sincronización de guac-front"
	echo "6. Sincronizar todo"
    echo "7. Salir"
}


# read input from the keyboard and take a action
# invoke the consultas() when the user select 1 from the menu option.
# invoke the administracion() when the user select 2 from the menu option.
# invoke the email() when the user select 3 from the menu option.
# invoke the cargas() when the user select 4 from the menu option.
# invoke the frontend() when the user select 5 from the menu option.
# invoke the execute_all() when the user select 6 from the menu option.
# Exit when user the user select 7 form the menu option.
read_options(){
	local choice
	read -p "Choise an option between [1 - 7] " choice
	case $choice in
		1) consultas ;;
		2) administracion ;;
		3) cargas ;;
        4) email ;;
        5) frontend ;;
        6) execute_all ;;
		7) exit 0;;
		*) echo -e "${RED}Error opción no valida...${STD}" && sleep 2
	esac
}


# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP


# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
	show_menus
	read_options
done
