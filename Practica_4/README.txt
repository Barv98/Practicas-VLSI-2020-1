Integrantes:
-Mendoza Guillén Sergio Adrián
-Navarro Velázquez Jorge
-Ramirez Villa Brandon Alberto
-Vargas Badillo Ricardo Antonio

Descripción:
Se requiere diseñar el sistema de control de vuelo de un UAV. El vehículo cuenta con una unidad de medición inercial equipada con dos 
sensores, uno para el hemisferio derecho (Sd) y otro para el izquierdo (Si), con ambos el UAV deberá tomar la decisión sobre qué movimiento 
deberá efectuar, los cuales son: “ADELANTE”, “ATRÁS”, “GIRO IZQ”, y “GIRO DER”. El algoritmo de navegación es el siguiente:

1. El UAV se eleva encendiendo sus cuatro motores y comienza a navegar hacia el frente, (Estado 0).

2. En todo momento después del encendido, el sistema debe consultar el estado de los sensores de la siguiente forma:
 
     a) Sí “Si” está en nivel bajo:
     Consultar el estado del sensor “Sd” 
     •Sí Sd=1, se pasa al Estado 1, en donde debe activarse la salida “ATRÁS”. Inmediatamente pasa al Estado 2, y activa el “GIRO IZQ”, 
      despu´es de esto, regresa al estado de navegaci´on (Estado 0).
     • Sí Sd=0, se activa la salida “ADELANTE” y regresa al Estado 0.

     b) Sí “Si” está en nivel alto:
     Consultar el estado del sensor ”Sd” 
     •Sí Sd=0, se pasa al Estado 3, en donde debe activarse la salida “ATRÁS”. Inmediatamente después pasa al Estado 4, y activa el 
     “GIRO DER”, después de esto, regresa al estado de navegación (Estado 0).  
     • Sí Sd=1, se pasa al Estado 5 en donde se activa la salida “ATRÁS”, en el siguiente instante de tiempo, el sistema pasa al Estado 6, 
     en donde se activa “GIRO IZQ”, el siguiente estado (7), activa nuevamente “GIRO IZQ”, en los Estados 8 y 9, la salida es “ADELANTE”, 
     el Estado 10 activa la salida “GIRO DER” y el onceavo estado nuevamente activa “GIRO DER”, ﬁnalmente el siguiente estado es el 
     Estado 0.

Consideraciones de diseño

El sistema debe considerar botón de RESET.
Los estados presentes del sistema deben mostrarse en un solo display de 7 segmentos en formato hexadecimal.
Los movimientos del UAV deben presentarse en los LEDS de la tarjeta, un movimiento por LED.
Los estados de los sensores deben introducirse con SWITCHES (no botones).


Link:
https://www.youtube.com/watch?v=X3vdw4j8hOo