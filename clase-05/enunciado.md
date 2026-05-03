Tenemos datos de los sueldos base docentes de varios años según cargo y dedicación, queremos poder analizar esos datos pero enfocándonos en un año, un cargo y una dedicación, así que necesitamos poder filtrar según esas características con 3 funciones distintas.

Los datos los tenemos clasificados por dedicación, categoría, año, mes.
Por ejemplo:

| Dedicación  | Categoría | Año  | Mes   | Valor          |
|-------------|-----------|------|-------|----------------|
| exclusiva   | titular   | 2025 | enero | 1.262.025,73   |
| exclusiva   | asociado  | 2025 | enero | 1.123.020,19   |


Tenemos las siguientes dedicaciones:

- Exclusiva
- Semiexclusiva
- Simple

Tenemos las siguientes categorías:

- Titular
- Asociado
- Adjunto
- JTP
- Ayudante de 1era
- Ayudante de 2da


Queremos modelar a algunos docentes:
Juan es adjunto con dedicación simple.
Tomás es jefe de trabajos prácticos con dedicación simple.
Lucas es titular con dedicación exclusiva.

1. Es muy difícil trabajar con la información en la forma en la que está dispuesta. Entonces, vamos a implementar diferentes filtros sobre los datos para poder consultar solo aquellos qué:

    a) Corresponden a cierta categoría.
    b) Corresponden a cierta dedicación.
    c) Sean de un año particular.
    d) Sean de un período (año + mes) en particular.

2. Ahora, queremos dado un docente y un año, poder consultar:

a) los sueldos que correspondan a su categoría y dedicación en ese año.
b) Cuál fue el total (la sumatoria) de los sueldos que cobró ese año.

## IPC

El Índice de Precios al Consumidor (IPC) es un indicador económico que mide la evolución promedio de los precios de una canasta de bienes y servicios básicos (alimentos, transporte, vivienda, etc.) consumidos por los hogares durante un tiempo determinado. Se utiliza principalmente para calcular la inflación y el costo de vida.

Contamos con los datos de ipc desde diciembre de 2016 hasta marzo de 2026.

La fórmula para ajustar un valor de un mes a otro utilizando el ipc es una simple regla de 3 simple:

Por ejemplo, si quisiéramos saber cuánto costaría hoy en día un alfajor que en Enero del 2020 costaba $500, se calcularía como:
500 * ipc(Marzo 2026) / ipc(Enero 2020)

3. Implementar una función `ajustadoPorIpc` que dados un valor, una fecha origen y una nueva fecha destino, nos devuelva el valor ajustado por IPC.

4. Ahora queremos, dado un sueldo de un docente en un determinado período (año + mes), ajustarlo por ipc a cada período (año + mes) del 2026.

5. Lo siguiente es hacer una comparativa: dado un período para tomar de referencia, un docente y un período destino, queremos saber qué tan por abajo o por arriba está su sueldo real de su sueldo ajustado por ipc.
Queremos comparar de 2 maneras:

    a) Por valor absoluto: Sueldo real - Sueldo ajustado por ipc.
    b) Por porcentaje: (Sueldo real - Sueldo ajustado por ipc) / Sueldo real.

6. Usar esas 2 funciones para comparar los valores de los salario mes a mes de un docente en 2026 contra los valores ajustados tomando como referencia alguna fecha en el pasado.
Queremos contestar si hay algún mes en el cual el salario real fue mayor que el salario ajustado por ipc.
Dados varios docentes, queremos saber si dado un período de referencia y un período objetivo, si a todos les dio un salario real menor al salario ajustado en ese período objetivo.

7. Finalmente, queremos hacer una consulta más:
Tomando como referencia algún período en el pasado para hacer ajustes por IPC,

    a) ¿Cuál es el acumulado de plata que viene perdiendo un docente desde octubre de 2025 hasta la fecha?
    b) ¿Cuántos sueldos de ese docente son en la actualidad?
