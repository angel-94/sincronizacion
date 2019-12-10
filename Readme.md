# Sincronización de repositorios

## ¿Qué necesitas?
- GNU make

## Prerrequisitos
- Para la ejecución de la sincronización de los repositorios definir las siguentes variables de ambiente:
```bash
    export MELTSAN_DIR=
    export AMIS_DIR=
```

1. Ejecutar el shell `sincronizacion.sh`
2. Se mostrará un menu con las opciónes disponibles de los repos a sincronizar, como el siguiente:
```js
    ~~~~~~~~~~~~~~~~~~~~~~~~~
    SINCRONIZACION DE GUAC
    ~~~~~~~~~~~~~~~~~~~~~~~~~
    1. Sincronización de guac-consultas
    2. Sincronización de guac-administración
    3. Sincronización de guac-cargas
    4. Sincronización de guac-email
    5. Sincronización de guac-front
    6. Sincronizar todo
    7. Salir
    Choise an option between [1 - 7]
```

3. Al seleccionar una de las opciones se ejecutan los siguientes pasos:
    - Se actualizan los repositorios locales tanto **Meltsan** como **Amis**, en la rama `istio`
    - Se eliminan los archivos del repositorio de la **amis** de la opción seleccionada
    - Se copian los archivos del repo de **Meltsan** al repo de la **Amis**
4. Validar los siguientes puntos:
    - Validar los cambios realizados
    - Agrega los cambios al stage
    - Crear el commit de los cambios
    - Sube los cambios a la rama `istio`
    - Crea el tag con el comando `git tag -a $TAG -m 'MENSAJE'`
    - Has push del tag con el comando `git push origin $TAG`

---

## Nota 

Dar un git checkout `src/environments/environment.prod.ts` para que no se vayan los cambios del ambiente **Meltsan** al ambiente de la **AMIS**