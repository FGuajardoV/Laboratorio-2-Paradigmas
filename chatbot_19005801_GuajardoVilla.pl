/*
Codigo Chatbot
Nombre: Francisco Guajardo Villa
Rut: 19.005.801-8
Profesor: Daniel Gacitua
Paradigmas de programacion - Usach 2018
A continuacion se explicara cada elemento de este algoritmo, se destaca que cuando un Predicado
esta escrito de la forma Predicado/N, N nos indica la aridad de este
*/

/* inicio del codigo */

/* TDA Chatbot - basado en hechos */

chatbot(1,[comprar,"Chatbot: Producto registrado, medio de pago?"]).
chatbot(1,[precio,"Chatbot: El precio es de","desea algo mas?"]).
chatbot(1,[saludo,"Chatbot: Bienvenido a la tienda, que pelicula desea adquirir hoy?"]).
chatbot(1,[despedida,"Chatbot: Gracias, disfrute la pelicula y hasta la proxima"]).
chatbot(1,[tipo,"Chatbot: Desea adquirir la version bd o dvd?"]).
chatbot(1,[sin_stock,"Chatbot: No tenemos esa pelicula, finalice el asistente"]).
chatbot(1,[salida,"Chatbot: su pedido seria "," sin mas que agregar, finalice el asistente."]).

chatbot(2,[comprar,"Chatbot: Producto registrado, medio de pago?"]).
chatbot(2,[precio,"Chatbot: El precio es de","desea algo mas?"]).
chatbot(2,[saludo,"Chatbot: Bienvenido a la tienda, que juego desea adquirir hoy?"]).
chatbot(2,[despedida,"Chatbot: Gracias, disfrute su juego y hasta la proxima"]).
chatbot(2,[tipo,"Chatbot: Para que consola lo desea? (ps4,xone,switch)"]).
chatbot(2,[sin_stock,"Chatbot: Sin existencia, finalice el asistente"]).
chatbot(2,[salida,"Chatbot: su pedido seria "," sin mas que agregar, finalice el asistente."]).

chatbot(3,[comprar,"Chatbot: Producto registrado, medio de pago?"]).
chatbot(3,[precio,"Chatbot: El precio es de","desea algo mas?"]).
chatbot(3,[saludo,"Chatbot: Bienvenido a la tienda, que manga desea adquirir hoy?"]).
chatbot(3,[despedida,"Chatbot: Gracias, disfrute su lectura y hasta la proxima"]).
chatbot(3,[tipo,"Chatbot: En que idioma lo desea, espaniol (es) o ingles (en)?"]).
chatbot(3,[sin_stock,"Chatbot: No poseemos ese tomo, finalice el asistente"]).
chatbot(3,[salida,"Chatbot: su pedido seria "," sin mas que agregar, finalice el asistente."]).

/* Costructor TDA Chatbot */

crear_chatbot(Chatbot,Seed):-
  chatbot(Seed,Chatbot).

/* Selector TDA Chatbot */

sel_instancia(Chatbot,Seed,X):-
  crear_chatbot(Chatbot,Seed),
  contiene(Chatbot,X), !.

/* Funcion de pertenencia del TDA */

es_chatbot(Seed,Lista):-
  chatbot(Seed,Lista).

/* banco de usuarios, expresado en Hechos */

user(user1,["doctor strange","bd","tarjeta","No, ya tengo lo que necesito"]).
user(user2,["overwatch","ps4","efectivo","No, ya tengo lo que necesito"]).
user(user3,["attack on titan","en","cheques","No, ya tengo lo que necesito"]).

/* Base de Datos productos - basada en hechos */

stock(juego,"ps4","god of wars","$45000").
stock(juego,"ps4","far cry 5","$42000").
stock(juego,"ps4","overwatch","$37990").
stock(juego,"ps4","nier automata","$35990").
stock(juego,"ps4","battlefield 1","$42990").
stock(juego,"xone","far cry 5","$45000").
stock(juego,"xone","battlefield 1","$42990").
stock(juego,"xone","forza horizon 3","$40980").
stock(juego,"xone","overwatch","$35990").
stock(juego,"switch","persona 5","$39990").
stock(juego,"switch","nintendo labo","$70990").
stock(juego,"switch","bayonetta","$40980").

stock(pelicula,"dvd","chucrut: el retorno del completo","$16660").
stock(pelicula,"dvd","doctor strange","$15090").
stock(pelicula,"dvd","guardians of the galaxy","$14980").
stock(pelicula,"dvd","ballerina","$9900").
stock(pelicula,"dvd","blade runner 2049","$9800").
stock(pelicula,"bd","chucrut: el retorno del completo","$36660").
stock(pelicula,"bd","doctor strange","$25090").
stock(pelicula,"bd","guardians of the galaxy","$24980").
stock(pelicula,"bd","ballerina","$19900").
stock(pelicula,"bd","blade runner 2049","$19800").

stock(manga,"en","attack on titan","$1").
stock(manga,"en","food wars","$10990").
stock(manga,"en","seven deadly sins","$10980").
stock(manga,"en","my hero academia","$12990").
stock(manga,"es","shingeki no kyojin","$2").
stock(manga,"es","shokugeki no souma","$9840").
stock(manga,"es","nanatsu no taizai","$8490").
stock(manga,"es","boku no hero academia","$10990").

/* Predica sin_stock/2 nos indicara con un true si es que la combinacion nombre-tipo no existe
dentro del entorno de la base de datos definida, a travez de consultas a esta
Dom: Nombre y Tipo son del tipovariable string
Metas: true si se cumple que no pertenecen, false caso contrario
Clausulas: consulta a la base de datos */

sin_stock(Nombre,Tipo):-
  not(stock(_,Tipo,Nombre,_)).

/* Predicado obtener_fecha/1 nos entregara una variable lista la cual nos indicara la fecha en formato [Hora,Minutos,Dia,Mes,Anio].
Estan las sentencias: get_time/1 que nos entrega el string de la fecha en segundos.
                      stamp_date_time/3 que nos entrega la fecha en formato date(Y,M,D,H,Mn,S,Off,TZ,DST).
                      date_time_value/3 nos retorna el elemento de la fecha que le solicitamos.
Predicados con relacion a uso de fecha obtenidos de http://www.swi-prolog.org/pldoc/man?section=timedate
Dom: una lista en formato ya explicado.
Metas: entregar una lista con los datos solicitados en las consultas .
Clausulas: siempre este predicado funcionara si existe un reloj en sistema, si se le entrega una lista en forma manual
lo mas seguro que retorne false por la precision del uso del reloj */

obtener_fecha([Hora,":",Minutos,"-",Dia,"/",Mes,"/",Anio]):-
  get_time(TimeStamp),
  stamp_date_time(TimeStamp, Date, local),
  date_time_value(year, Date, Anio), date_time_value(month, Date, Mes), date_time_value(day, Date, Dia),
  date_time_value(hour, Date, Hora), date_time_value(minute, Date, Minutos).

/* Predicado crear_string_fecha/1 nos retorna en la variable String la fecha en formato de texto "Hora:Minutos-Dia/Mes/Anio".
Estan las sentencias: obtener_fecha/1, la cual nos entrega la lista de la obtener_fecha.
                      atomic_list_concat/3 la cual concadena strings con el elemento que deseamos atomic_list_concat(_,elem,Res).
                      atom_string/2 que nos retorna la frase en Atom en formato string.
Predicados de uso de strings obtenidos de http://www.swi-prolog.org/pldoc/man?section=string-predicates
Dom: ingresa un String
Metas: entregar el String en formato solicitado para el uso en el Log */

crear_string_fecha(String):-
  obtener_fecha(Lista),
  atomic_list_concat(Lista, '', Atom),
  atom_string(Atom, String).

/* Predicado agregar/3, el cual, de forma recursiva nos entrega la concadenacion
de dos listas, caso base es cuando la primera lista este vacia.
Funcion modificadora de los TDA lista, Funcion obtenida de las PPTs de la clase */

agregar([],[ELEM], ELEM).
agregar([X|Xs], [X|Ys], ELEM):- agregar(Xs, Ys, ELEM).

/* Predicado contiene/2, el cual, de forma recursiva nos indica si un Elementos
X pertenece a la lista [X|Xs].
Funcion de pertenencia de los TDA lista, Funcion obtenida de las PPTs de la clase */

contiene([X|_], X).
contiene([_|Xs], Y):- contiene(Xs, Y).

/* Predicado contar/2, el cual nos retorna el largo de una lista, si es que lo solicitamos, de forma recursivas,
de esta forma tambien confirma si un numero corresponde a los elementos que contiene una lista
caso base o condicion de borde, cuando la lista esta vacia
Funcion obtenida de las PPTs de la clase */

contar([], 0).
contar([_|L], C):- contar(L,C_ant), C is C_ant+1.

/* Predicado resto/2, este predicado nos retornara la cola de una lista que ingresemos */

resto([_|Xs],Xs).

/* Predicado seleccionar_elemento_lista/3 el cual, de forma recursiva comprueba si un elemento Y esta en la
posicion N de una lista, caso base cuando el N que buscamos sea 1, de esa forma entrega el primer elemento
de la sublista */

seleccionar_elemento_lista([Y|_], 1, Y).
seleccionar_elemento_lista([_|Xs], N, Y):-
  N2 is N - 1, seleccionar_elemento_lista(Xs, N2, Y).

/* Predicado crear_mensaje_chatbot/4 el cual recibe tres elementos, consultando seleccionar_elemento_lista/3 Para
escoger la frase del cahtbot y uniendolas con atomic_list_concat/3, transformando luego ese elemento formato atom a string
mediante atom_string/2, extraidos de la documentacion oficial http://www.swi-prolog.org/pldoc/man?section=manipatom */

crear_mensaje_chatbot(Lista,NombreElemento,Tipo,Res):-
  seleccionar_elemento_lista(Lista,1,Parte1), seleccionar_elemento_lista(Lista,2,Parte2),
  stock(_,Tipo,NombreElemento,Precio),
  atomic_list_concat([Parte1,Precio,Parte2], ' ', Atom), atom_string(Atom, Res).

/* Predicado buscar_elemento/3 recibe una lista de listas, con este predicado se logra extraer el 1 elemento de
un elemento n de una lista, se utiliza la consulta de seleccionar_elemento_lista/3 | este predicado tambien
puede verificar si cierto elemento Elem pertenece a el elemento N de una lista Log */

buscar_elemento(Log,N,Elem):-
  seleccionar_elemento_lista(Log,N,Aux),
  seleccionar_elemento_lista(Aux,1,Elem).

/* Funcion beginDialog/4, Predicado que nos permite comenzar una conversacion con nuestro Chatbot, indicando con un delimitador
y la fecha.
Dom: ingresa las variables: Chatbot, el cual correspondera a nuestro TDA; InputLog que en esta funcion corresponde
a una lista vacia; Seed, corresponde a el "vendedor" al cual estara dirigida la conversacion, (movies-1,games-2,mangas-3);
OutputLog que sera nuestra variable solicitada, la cual recibira como retorno nuestra lista Log actualizada con la iniciacion del
dialogo.
Metas: Entregar una lista con el Log actualizado.
Clausulas: Corresponde a la busqueda de la seed dentro del TDA chatbot, cuando la encuentra nos retorna lo solicitado, utilizando
las sentencias de resto/2, crear_string_fecha/1, agregar/3. */

beginDialog(Chatbot,InputLog,Seed,OutputLog):-
  sel_instancia(Chatbot,Seed,saludo), resto(Chatbot,Resto), crear_string_fecha(Fecha), agregar(Resto,Dialogo,Fecha),
  agregar(InputLog,Aux,["BeginDialog",Fecha]),
  agregar(Aux,OutputLog,Dialogo),!.

/* Funcion sendMessage/5, predicado que nos permite actualizar el Log con el mensaje ingresado por el usuario junto a
la respuesta del chatbot, verificando en que parte de la conversacion se encuentra mediante el largo de esta.
Dom: recibe el Msg, el cual es un string que contiene el mensaje del usuario; Chatbot, el cual toma el valor del TDA Chatbot;
InputLog, que corresponde a la lista con la conversacion actualizada; Seed, corresponde a el "vendedor" al cual estara
dirigida la conversacion, (movies-1,games-2,mangas-3); OutputLog que sera nuestra variable solicitada, la cual recibira como
retorno nuestra lista Log actualizada.
Metas: Entregar un Log actualizado con el mensaje del usuario y la respuesta del chatbot.
Clausulas: existen varias clausulas, las cuales se explicaran detenidamente en el codigo... */

sendMessage(Msg,Chatbot,InputLog,Seed,OutputLog):-

  /* basicamente verifica si en el log solo esta presente la iniciacion del dialogo, por lo cual el Chatbot
  debera de responder solicitando el producto que el usuario desea */
  contar(InputLog,Largo), Largo = 2, sel_instancia(Chatbot,Seed,tipo),
  resto(Chatbot,Resto), crear_string_fecha(Fecha), agregar(Resto,Dialogo,Fecha),
  agregar(InputLog,Aux,[Msg,Fecha]), agregar(Aux,OutputLog,Dialogo),!;

  /* Luego de verificar que producto recibe, en esta seccion se verificara que la combinacion Nombre-Tipo existen
  en nuestra base de datos de productos, si no solicitara reiniciar el programa */
  contar(InputLog,Largo), Largo = 4, sel_instancia(Chatbot,Seed,sin_stock),
  resto(Chatbot,Resto), crear_string_fecha(Fecha),
  buscar_elemento(InputLog,3,NombreProducto),
  sin_stock(NombreProducto,Msg), agregar(Resto,Dialogo,Fecha),
  agregar(InputLog,Aux,[Msg,Fecha]), agregar(Aux,OutputLog,Dialogo),!;

  /* Como no ingreso en la clausula anterior, prosigue con la conversacion normal, aqui verifica informa al usuario que la
  compra ya fue ingresada y solicitara medio de pago */
  contar(InputLog,Largo), Largo = 4, sel_instancia(Chatbot,Seed,comprar),
  resto(Chatbot,Resto), crear_string_fecha(Fecha), agregar(Resto,Dialogo,Fecha),
  agregar(InputLog,Aux,[Msg,Fecha]), agregar(Aux,OutputLog,Dialogo),!;

  /* aqui, siguiendo el conducto de la conversacion le indicara al usuario el precio del producto y preguntara si desea
  algo mas, por motivos de alcance este chatbot no puede concretar una respuesta a un si, por lo que se evaluara Como
  siempre "no", delimitando al usuario a solo adquirir un producto */
  contar(InputLog,Largo), Largo = 6, sel_instancia(Chatbot,Seed,precio),
  resto(Chatbot,Resto), crear_string_fecha(Fecha),
  buscar_elemento(InputLog,3,NombreProducto), buscar_elemento(InputLog,5,TipoProducto),
  crear_mensaje_chatbot(Resto,NombreProducto,TipoProducto,Dialogo),
  agregar(InputLog,Aux,[Msg,Fecha]), agregar(Aux,OutputLog,[Dialogo,Fecha]),!;

  /* Aqui, informa al usuario los detalles de su compra, y solicitara a este que finalice la conversacion con el Predicado
  endDialog/4 */
  contar(InputLog,Largo), Largo = 8, sel_instancia(Chatbot,Seed,salida),
  resto(Chatbot,Resto), crear_string_fecha(Fecha),
  seleccionar_elemento_lista(Resto,1,Parte1), seleccionar_elemento_lista(Resto,2,Parte2),
  buscar_elemento(InputLog,3,NombreP), buscar_elemento(InputLog,5,TipoP), stock(_,TipoP,NombreP,Precio),
  atomic_list_concat([Parte1,"(",NombreP,"/",TipoP,")"," pagando ",Precio,Parte2], '', Atom), atom_string(Atom, StrDialog),
  agregar(InputLog,Aux,[Msg,Fecha]), agregar(Aux,OutputLog,[StrDialog,Fecha]),!.

/* Funcion endDialog/4, predicado que nos permitira finalizar un dialogo, indicando con un delimitador + la hora
Dom: recibe la variable Chatbot, el cual toma el valor del TDA Chatbot; InputLog, que corresponde a la lista con la
conversacion actualizada; Seed, corresponde a el "vendedor" al cual estara dirigida la conversacion,
(movies-1,games-2,mangas-3); OutputLog que sera nuestra variable solicitada, la cual recibira como
retorno nuestra lista Log actualizada con el delimitador endDialog + la hora.
Meta: Entregar una lista actualizada con la conversacion
Clausulas: Corresponde a la busqueda de la seed dentro del TDA chatbot, cuando la encuentra nos retorna lo solicitado, utilizando
las sentencias de resto/2, crear_string_fecha/1, agregar/3.*/

endDialog(Chatbot,InputLog,Seed,OutputLog):-
  sel_instancia(Chatbot,Seed,despedida), resto(Chatbot,Resto), crear_string_fecha(Fecha), agregar(Resto,Dialogo,Fecha),
  agregar(InputLog,Aux,Dialogo),
  agregar(Aux,OutputLog,["EndDialog",Fecha]),!.


/* Funcion logToStr/2, predicado que nos permitira transformar el Log a un string, para ser mas entendible por el usuario
Dom: recibira Log, el cual pertenece a una lista con la conversacion y lo que deseamos obtener que es el StrRep, que seria
una variable del tipo String.
Meta: transformar una lista de listas en un string ordenado.
Clausulas: */

/*  */

%elem_to_string(X,String):-
%  seleccionar_elemento_lista(X,1,Aux1), seleccionar_elemento_lista(X,2,Aux2),
%  atomic_list_concat([Aux2,Aux1], ' || ', Atom), atom_string(Atom,String).

%logToStr([],_).
%logToStr([Log|ColaLog],StrRep):-
%  elem_to_string(Log,String), string_concat(StrRep,String,NuevoStrRep),
%  logToStr(ColaLog,NuevoStrRep).

/* Funcion test/5, predicado que permite probar el chatbot con unas respuestas de usuario ya predefinidas en el mundo cerrado
en el cual se esta trabajando, lo que hace es entregar un Log con la conversacion completa.
Dom: recibe la variable user, el cual toma el valor del usuario definido en los hechos; InputLog, que corresponde a la
lista vacia, por ser inicio de conversacion; Seed, corresponde a el "vendedor" al cual estara dirigida la conversacion,
(movies-1,games-2,mangas-3); OutputLog que sera nuestra variable solicitada, la cual poseera toda la conversacion.
Meta: probar nuestro programa sin necesidad de ingresar los elementos manualmente, retornando un Log correcto.
Clausulas: basicamente se tiene que corroborar todo lo visto anteriormente, ya que se utilizan las sentencias beginDialog/4,
sendMessage/5 y endDialog/4
Como nota: al no necesitar ciertos paramentros, estos se reemplazan por un _ para asi no generar las alertas de "Singleton variables". */

test(User,_,InputLog,Seed,OutputLog):-
  user(User,Lista),
  beginDialog(_,InputLog,Seed,Out1),
  seleccionar_elemento_lista(Lista,1,Aux), sendMessage(Aux,_,Out1,Seed,Out2),
  seleccionar_elemento_lista(Lista,2,Aux2), sendMessage(Aux2,_,Out2,Seed,Out3),
  seleccionar_elemento_lista(Lista,3,Aux3), sendMessage(Aux3,_,Out3,Seed,Out4),
  seleccionar_elemento_lista(Lista,4,Aux4), sendMessage(Aux4,_,Out4,Seed,Out5),
  endDialog(_,Out5,Seed,OutputLog).

/* Fin Codigo */
