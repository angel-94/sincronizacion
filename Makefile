COMMON = printf '*%.0s' {1..100} && printf '\n'
PURPLE=\033[0;35m
BLUE=\033[0;34m
STD=\033[0;0;39m
LIGHT_GREEN=\033[0;93m

update-mts-repo: 
	cd ${MELTSAN_DIR}/${REPO_DIR}; \
	${COMMON}; \
	echo "${BLUE}*** git checkout istio ***${STD}"; \
	git checkout istio; \
	${COMMON}; \
	echo "${BLUE}*** git remote -v ***${STD}"; \
	git remote -v; \
	${COMMON}; \
	echo "${BLUE}*** git pull origin istio ***${STD}"; \
	git pull origin istio; \
	${COMMON}; \
	echo "${BLUE}*** git status ***${STD}"; \
	git status; \
	${COMMON}; \
	echo "${BLUE}*** git tag -n99 | cat ***${STD}"; \
	git tag -n99 | cat; \
	${COMMON}


update-amis-repo: 
	cd ${AMIS_DIR}/${REPO_DIR}; \
	${COMMON}; \
	echo "${LIGHT_GREEN}*** git checkout istio ***${STD}"; \
	git checkout istio; \
	${COMMON}; \
	echo "${LIGHT_GREEN}*** git remote -v ***${STD}"; \
	git remote -v; \
	${COMMON}; \
	echo "${LIGHT_GREEN}*** git pull origin istio ***${STD}"; \
	git pull origin istio; \
	${COMMON}; \
	echo "${LIGHT_GREEN}*** git status ***${STD}"; \
	git status; \
	${COMMON}; \
	echo "${LIGHT_GREEN}*** git tag -n99 | cat ***${STD}"; \
	git tag -n99 | cat; \
	${COMMON}
