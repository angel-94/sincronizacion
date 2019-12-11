
export GIT_USER=$1
export GIT_PASSWORD=$2

STD='\033[0;0;39m'
PURPLE='\033[0;35m'

export AMIS=/guac/amis
export MELTSAN=/guac/meltsan

export URL_MELTSAN_GIT=https://github.com/meltsan
export URL_AMIS_GIT=https://${GIT_USER}:${GIT_PASSWORD}@github.com/amis-dev

export AMIS_COMPANY="AMIS"
export MELTSAN_COMPANY="Meltsan"

export CURRENT_DIR=$(pwd)


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

define_env_variables


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
        if [ -d "$repo" ] 
        then
            echo "Repository $repo from $MELTSAN_COMPANY exists." 
        else
            echo "Cloning $repo repository from $MELTSAN_COMPANY..."
            cd $MELTSAN
            git clone $URL_MELTSAN_GIT/$repo.git
            cd $CURRENT_DIR
        fi
    done
}


clone_repo_amis() {
    for repo in "${REPOS[@]}"
    do
        if [ -d "$repo" ] 
        then
            echo "Repository $repo from $AMIS_COMPANY exists." 
        else
            cd $AMIS
            echo "Cloning $repo repository from $AMIS_COMPANY..."
            git clone $URL_AMIS_GIT/$repo.git
            cd $CURRENT_DIR
        fi
    done
}


define_env_variables() {
    PWD=$(pwd)
    echo "La ruta actual es = $PWD"
    MELTSAN_DIR=$PWD/$MELTSAN
    AMIS_DIR=$PWD/$AMIS
}


clone_repo_mts

if [[ -z "${GIT_USER}" && -z "${GIT_PASSWORD}" ]]; then
	echo -e "${PURPLE}No cuentas con usuario en el repositorio de la $AMIS_COMPANY ${STD}"
	exit 1
else
  	echo "Descargando los repos de la $AMIS_COMPANY"
    clone_repo_amis
fi