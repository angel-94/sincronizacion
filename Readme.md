# Sincronización de repositorios

## ¿Qué necesitas?
- GNU make

## Presequisitos
- Para la ejecución de la sincronización de los repositorios definir las siguentes variables de ambiente:
```bash
    export MELTSAN_DIR=
    export AMIS_DIR=
```

1. Ejecutar el shell `sincronizacion.sh`
  Este paso borra los archivos y copia los de las carpetas en /home/appmanager/amis_gcp_mts
  Por lo que hay que ejecutar previamente los scripts:
   /home/appmanager/amis_gcp_mts/deploy_gcp.sh
   /home/appmanager/amis_gcp_mts/deploy_gcp_istio.sh
2. Entrar a cada carpeta y dar un git status para ver archivos cambiaron.
3. Revisar si hay archivos borrados, dar un git rm por cada uno.
4. dar un git add .
5. dar un git commit
6. git push origin istio
7. Para el caso del repo guac-frontend
    dar un git checkout src/environments/environment.prod.ts
    para que no se vayan los cambios del ambiente apuntando a mts, ya que aqui esta apuntando a ambiente amis