#!/bin/bash

# A menu driven shell script sample template 
## ----------------------------------
# Step #1: Define variables
# ----------------------------------
RED='\033[0;41;30m'
STD='\033[0;0;39m'
PURPLE='\033[0;35m'

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
pause(){
    echo '*****************************************************************************************************'
    read -p "Press [Enter] key to continue..." fackEnterKey
}


consultas(){
    echo '*****************************************************************************************************'
    echo "consultas called"
    echo "*** Sincronización de consultas ***"
    echo '*****************************************************************************************************'
    export REPO_DIR=guac-consulCat
    make update-mts-repo
    make update-amis-repo
    pause
}


# do something in two()
administracion(){
	echo '*****************************************************************************************************'
    echo "administracion called"
    echo "*** Sincronización de administracion ***"
    echo '*****************************************************************************************************'
    make mts-guac-admin
    pause
}


# do something in two()
cargas(){
	echo '*****************************************************************************************************'
    echo "cargas called"
    echo "*** Sincronización de cargas ***"
    echo '*****************************************************************************************************'
    make mts-guac-cargas
    pause
}


# do something in two()
email(){
	echo '*****************************************************************************************************'
    echo "email called"
    echo "*** Sincronización de email ***"
    echo '*****************************************************************************************************'
    make mts-guac-email
    pause
}

# do something in two()
frontend(){
	echo '*****************************************************************************************************'
    echo "frontend called"
    echo "*** Sincronización de frontend ***"
    echo '*****************************************************************************************************'
    make mts-guac-frontend
    pause
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
    echo "6. Salir"
}


# read input from the keyboard and take a action
# invoke the consultas() when the user select 1 from the menu option.
# invoke the administracion() when the user select 2 from the menu option.
# invoke the email() when the user select 3 from the menu option.
# invoke the cargas() when the user select 4 from the menu option.
# invoke the frontend() when the user select 5 from the menu option.
# Exit when user the user select 6 form the menu option.
read_options(){
	local choice
	read -p "Enter choice [ 1 - 6] " choice
	case $choice in
		1) consultas ;;
		2) administracion ;;
		3) cargas ;;
        4) email ;;
        5) frontend ;;
        6) exit 0;;
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
