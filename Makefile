task:
	@date

DIR = meltsan/guac-consulCat

update-consulta: 
	cd ${DIR}; \
	git status; \
	git remote -v; \
	git pull origin istio; \
	git status; \
	git tag -n99 | cat

create-tag:
	