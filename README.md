# ServiceMonitor App

### Project Setup
El proyecto se creó con
* Ruby 3.1.2p20
* Rails 7.0.4
* BD SqLite3 integrada ya integrada por defecto

Y para el front -> https://github.com/jecarvaj/service-monitor-front
* Vue 3 + Pinia
* Bootstrap



Instalación de gemas
```
bundle install
```

Crear BD y migraciones
```
rails db:create
rails db:migrate
```
Correr seeders
```
rails db:seed
```
##### El backend debe quedar corriendo en ``` http://localhost:3000 ```

## Estructura Proyecto
### Modelos
* _Company_ -> Representa la empresa a la que se le presta el servicio
* _User_ -> Usuario de sistema, puede ser Agente o Admin
* _Service_ -> Servicio de monitoreo, se asocia a una Company, tiene fecha de inicio y término
* _ScheduleDay_ -> Representa un dia de la semana asociada a un servicio, está compuesto por bloques horarios según se defina
* _ScheduleBlock_ -> Bloque horario. Corresponde a una hora de trabajo y se asocia con ScheduleDay, cada bloque puede ser asociada a un solo Usuario Agente, pero ademas puede tener varios Agentes disponibles para tomar ese bloque 

### Controladores
* _ServiceController_ -> Contiene los métodos necesarios para interactuar con el front

### Services Objects
* _GenerateScheduleService_ -> Contiene la lógica y lo necesario para generar los bloques horarios de cada servicio creado, a partir de un hash ```dia: [horaInicio, horaTermino]```
* _AssignShiftsService_ -> Contiene la lógica para la asignación de bloques horarios a cada agente disponible de manera equitativa

---------------------------------------

### Algoritmo Propuesto
* Asignar bloques con un solo agente disponible
* Comenzar conteo de cantidad de bloques por cada agente (se actualiza luego de cada asignacion)
* Calcular la cantidad de bloques consecutivos que pueden ser tomados por cada agente en cada día, y asignárselo al que pueda tomar la mayor cantidad de bloques seguidos el mismo día.
* En el caso de que en el punto anterior varios agentes retornen la misma cantidad, entonces se asignará el bloque al agente que tenga la menor cantidad de bloques tomados, a no ser que el bloque anterior haya sido tomado por uno de estos agentes, en cuyo caso se repetirá la asignación para disminuir los cambios de turno

### Suposiciones
* Cada Company puede tener uno o varios servicios activos
* El nro de la semana se calcula tomando la semana 1 como la semana en la que comenzó el servicio

## Features APP
* Inicio de sesión
* Mostrar y editar disponibilidad de agentes
* Al editar la disponibilidad se recalcula la asignacion 
* Admin puede editar disponibilidad de todos los agentes
* Agentes solo pueden editar su propia disponibilidad
* Edición de turnos permite marcar todos los bloques al mismo tiempo, en vez de uno en uno
* Visualización de turnos asignados
* Vista 'Agentes' con imagen random justforfun
* Formulario para crear nuevos servicios. Funcional pero no validado

## Screenshots según ejemplo enviado
Edición turnos disponibles vista Admin
![image](https://user-images.githubusercontent.com/16392061/201613946-2761cdb1-c448-4e1c-96e7-95ddd48d12c9.png)

Turnos confirmados y ordenados automáticamente
![image](https://user-images.githubusercontent.com/16392061/201614159-80367cdc-a970-4f04-af8a-5ad5e2f8f135.png)
