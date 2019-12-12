STD='\033[0;0;39m'
PURPLE='\033[0;35m'
BOLD=$(tput bold)

# do something in two()
print_asterisk() {
	printf '*%.0s' {1..100} && printf '\n'
}


if [[ -n "$1" && -n "$2" ]]
then
    export GIT_USER=$1
    export GIT_PASSWORD=$2
else
    print_asterisk
    echo "$BOLD Para clonar los repos de guac de amis se necesita user y pass de un usuario como parametros. $STD"
    echo "Ejemplo $PURPLE./create-directories.sh user pass $STD"
    read -p "Deseas continuar [y,N]? " desition
    if [[ $desition == "y" || $desition == "Y" ]]
    then
        echo "Continuamos..."
    else
        echo "Saliendo..."
        exit 0 ;
    fi
fi


export CURRENT_DIR=$(pwd)
export AMIS=$CURRENT_DIR/guac/amis
export MELTSAN=$CURRENT_DIR/guac/meltsan

export URL_MELTSAN_GIT=https://github.com/meltsan
export URL_AMIS_GIT=https://${GIT_USER}:${GIT_PASSWORD}@github.com/amis-dev

export AMIS_COMPANY="AMIS"
export MELTSAN_COMPANY="Meltsan"


if [ -d "${MELTSAN}" ] 
then
    echo "Directory ${MELTSAN} exists." 
else
    echo "Creating ${MELTSAN} directory ..."
    mkdir -p ${MELTSAN}
fi

if [ -d "${AMIS}" ] 
then
    echo "Directory ${AMIS} exists." 
else
    echo "Creating ${AMIS} directory ..."
    mkdir -p ${AMIS}
fi

define_env_variables() {
    PWD=$(pwd)
    print_asterisk
    echo "-> La ruta actual es = $BOLD $PWD $STD"
    export MELTSAN_DIR=$PWD/$MELTSAN
    export AMIS_DIR=$PWD/$AMIS
}


declare -a REPOS=(
    "guac-consulCat"
    "guac-adminCat"
	"guac-cargasBatch"
	"guac-emailDispatch"
	"guac-frontend"
    )


clone_repo_mts() {
    for repo in "${REPOS[@]}"
    do
        if [ -d "$MELTSAN/$repo" ] 
        then
            print_asterisk
            echo "Repository $BOLD $repo $STD from $MELTSAN_COMPANY exists." 
        else
            print_asterisk
            cd $MELTSAN
            echo "Cloning $BOLD $repo $STD repository from $MELTSAN_COMPANY..."
            git clone $URL_MELTSAN_GIT/$repo.git
            cd $CURRENT_DIR
        fi
    done
}


clone_repo_amis() {
    for repo in "${REPOS[@]}"
    do
        if [ -d "$AMIS/$repo" ] 
        then
            print_asterisk
            echo "Repository $BOLD $repo $STD from $AMIS_COMPANY exists." 
        else
            print_asterisk
            cd $AMIS
            echo "Cloning $BOLD $repo $STD repository from $AMIS_COMPANY..."
            git clone $URL_AMIS_GIT/$repo.git
            cd $CURRENT_DIR
        fi
    done
}


define_env_variables
clone_repo_mts


if [[ -z "${GIT_USER}" && -z "${GIT_PASSWORD}" ]]; then
    print_asterisk
	echo -e "${PURPLE}No cuentas con usuario en el repositorio de la $AMIS_COMPANY ${STD}"
	exit 1
else
    print_asterisk
  	echo "Descargando los repos de la $AMIS_COMPANY"
    clone_repo_amis
fi