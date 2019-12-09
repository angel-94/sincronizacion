COMMON = printf '*%.0s' {1..100} '\n'

update-mts-repo: 
	${COMMON}; \
	cd ${MELTSAN_DIR}/${REPO_DIR}; \
	git status; \
	${COMMON}; \
	git checkout istio
	${COMMON}; \
	git remote -v; \
	${COMMON}; \
	git pull origin istio; \
	${COMMON}; \
	git status; \
	${COMMON}; \
	git tag -n99 | cat
	${COMMON}; \

update-amis-repo: 
	${COMMON}; \
	cd ${MELTSAN_DIR}/${REPO_DIR}; \
	git status; \
	${COMMON}; \
	git checkout istio
	${COMMON}; \
	git remote -v; \
	${COMMON}; \
	git pull origin istio; \
	${COMMON}; \
	git status; \
	${COMMON}; \
	git tag -n99 | cat
	${COMMON}; \

