

 :- use_module(library(pce)).
 :- pce_image_directory('./imagenes').
 :- use_module(library(pce_style_item)).
 :- dynamic color/2.

 resource(img_principal, image, image('img_principal2.jpg')).
 resource(portada, image, image('videojuegos.jpeg')).
 resource(cinetosis, image, image('cinetosis.jpeg')).
 resource(estres_postraumatico, image, image('estres_postraumatico.jpeg')).
 resource(epilepsia_fotosensible, image, image('epilepsia_fotosensible.jpeg')).
 resource(acufenos, image, image('acufenos.jpeg')).
 resource(psicoticismo, image, image('psicoticismo.jpeg')).
 resource(tunel_carpiano, image, image('tunel_carpiano.jpg')).
 resource(fatiga_ocular, image, image('fatiga_ocular.jpg')).
 resource(lo_siento_diagnostico_desconocido, image, image('d_desconocido.jpg')).

 /*resource(debilidad, image, image('debilidad.jpg')).*/
 resource(irritacion, image, image('irritacion.jpg')).
 resource(miedo, image, image('miedo.jpg')).
 resource(memoria, image, image('memoria.jpg')).
 resource(vision, image, image('vision.jpg')).
 resource(espasmos, image, image('espasmos.jpg')).
 resource(nauseas, image, image('nauseas.jpg')).
 resource(ruido, image, image('ruido.jpg')).
 resource(presion, image, image('presion.jpg')).
 resource(zumbido, image, image('zumbido.jpg')).
 resource(impulsiva, image, image('impulsiva.jpg')).
 resource(agresiva, image, image('agresiva.jpg')).
 resource(apatia, image, image('apatia.jpg')).
 resource(hormigueo, image, image('hormigueo.jpg')).
 resource(manos, image, image('manos.jpg')).
 resource(lloroso, image, image('lloroso.jpg')).
 resource(borroso, image, image('borroso.jpg')).
 resource(convulsiones, image, image('convulsiones.jpg')).
 resource(mareos, image, image('mareo.jpg')).


 resource(jvh_juego, image, image('jvh_juego.jpg')).
 resource(jcli_juego, image, image('jcli_juego.jpg')).
 resource(jcppvr_juego, image, image('jcppvr_juego.jpg')).
 resource(jses_juego, image, image('jses_juego.jpg')).
 resource(jrma_juego, image, image('jrma_juego.jpg')).
 resource(jvri_juego, image, image('jvri_juego.jpg')).
 resource(descanso, image, image('descanso.jpg')).

 mostrar_imagen(Pantalla, Imagen) :- new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(100,80)).
  mostrar_imagen_tratamiento(Pantalla, Imagen) :-new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(20,100)).
 nueva_imagen(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(0,0)).
  imagen_pregunta(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(500,60)).
 mostrar_imagen_recomendacion(Pantalla, Imagen) :- new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(0,0)).

  botones:-borrado,
                send(@boton, free),
                send(@btntratamiento,free),
                send(@btnRecomendacion, free),
                mostrar_diagnostico(Enfermedad),
                %send(@texto, selection('El Diagnostico a partir de los datos es:')),
                send(@resp1, selection(Enfermedad)),%muestra en pantalla la enferm
                new(@boton, button('Iniciar consulta',
                message(@prolog, botones)
                )),

               %mostrar_recomendacion(Enfermedad),
               id_imagen_reco(Enfermedad, Recomendacion),
               new(@btnRecomendacion,button('Recomendaciones',message(@prolog,pantalla_recomendacion, Recomendacion) )),%Lo creo aqui para enviar la enfermedad ya que aqui en esta funcion es donde se realiza el diagnostico y se define la enfermedad
                new(@btntratamiento,button('Detalles y Tratamiento',
                message(@prolog, mostrar_tratamiento,Enfermedad)
                )),
                send(@main, display,@boton,point(20,450)),
                send(@main, display,@btntratamiento,point(138,450)).



  mostrar_tratamiento(X):-new(Tratam, dialog('Tratamiento')),
                          /*new(@btnRecomendacion,button('Recomendaciones',and(message(@prolog,pantalla_recomendacion) ,
                          and(message(@tratam,destroy),message(@tratam,free)) ))),                          send(@tratam, append, label(nombre, 'Explicacion: ')),*/
                          send(Tratam, display,@lblExp1,point(50,51)),
                          send(Tratam, display,@lblExp2,point(50,80)),
                          %tratamiento(X),
                          send(@lblExp1,selection('La evaluaci?n y recomendaci?n son:')),
                          mostrar_imagen_tratamiento(Tratam,X),
                          send(Tratam, display, @btnRecomendacion, point(400,51)),
                          send(Tratam, transient_for, @main),
                          send(Tratam, open_centered).

/*tratamiento(X):- send(@lblExp1,selection('De Acuerdo Al Diagnostico El Tratamiento Es:')),
                 mostrar_imagen_tratamiento(Tratam,X).
*/%%incorporo este metodo dentro de mostrar_tratamiento porque antes creaba un objeto @tratam cada vez que se accedia a esa pantalla el cual, ocasionaba que ocurriera un error de duplicidad
% ------------------------------------------------------------------------
pantalla_recomendacion(X):- new(Recomendacion, dialog('Juegos recomendados')),
                                                      %tratamiento(X),
                         %send(@lblExp1,selection('De Acuerdo Al Diagnostico El Tratamiento Es:')),
                         mostrar_imagen_recomendacion(Recomendacion,X),

                         send(Recomendacion, transient_for, @main),
                         send(Recomendacion, open_centered).
% ------------------------------------------------------------------------


   preguntar(Preg,Resp):-new(Di,dialog('Colsultar Datos')),
                        new(L2,label(texto,'Responde las siguientes preguntas')),
                        id_imagen_preg(Preg,Imagen),
                        imagen_pregunta(Di,Imagen),
                        new(La,label(prob,Preg)),
                        new(B1,button(si,and(message(Di,return,si)))),
                        new(B2,button(no,and(message(Di,return,no)))),
                        send(Di, gap, size(25,25)),
                        send(Di,append(L2)),
                        send(Di,append(La)),
                        send(Di,append(B1)),
                        send(Di,append(B2)),
                        send(Di,default_button,'si'),
                        send(Di,open_centered),get(Di,confirm,Answer),
                        free(Di),
                        Resp=Answer.

% ------------------------------------------------------------------------
  interfaz_principal:-new(@main,dialog('Sistema Experto',
        size(1000,1000))),
        new(@texto, label(nombre,'El Diagnostico a partir de los datos es:',font('times','roman',18))),
        new(@resp1, label(nombre,'',font('times','roman',22))),
        new(@lblExp1, label(nombre,'',font('times','roman',14))),
        new(@lblExp2, label(nombre,'',font('times','roman',14))),
        new(@salir,button('Salir',and(message(@main,destroy),message(@main,free)))),
        new(@boton, button('Iniciar consulta',message(@prolog, botones))),

        new(@btntratamiento,button('??Tratamiento?')),
        new(@btnRecomendacion,button('Recomendacion')),/*Estos dos botones se crean aqui para despues ser eliminados al ingresar a la funcion botones:- debido a que se requiere crear de nuevo especificamente en esa funcion porque es donde se deduce la enfermedad y luego cada boton envia ese parametro a su funcion respectiva. SI no se hiciera de esta forma provoca el error de que el objeto ya existe*/

       %new(@btnRecomendacion,button('Recomendaciones',message(@prolog,pantalla_recomendacion))),%lo defino desde aqui para que no se vuelva a crear el objeto y arroje el error [PCE error: @pce/pce: Object @btnRecomendacion already exists]

        nueva_imagen(@main, img_principal),
        send(@main, display,@boton,point(138,450)),
        %send(@main, display,@texto,point(20,20)),
        send(@main, display,@salir,point(300,450)),
        send(@main, display,@resp1,point(20,250)),
        send(@main,open_centered).

       borrado:- send(@resp1, selection('')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  crea_interfaz_inicio:- new(@interfaz,dialog('Bienvenido al Sistema Experto Diagnosticador',
  size(1000,1000))),

  mostrar_imagen(@interfaz, portada),

  new(BotonComenzar,button('Iniciar',and(message(@prolog,interfaz_principal) ,
  and(message(@interfaz,destroy),message(@interfaz,free)) ))),
  new(BotonSalir,button('Salir',and(message(@interfaz,destroy),message(@interfaz,free)))),
  send(@interfaz,append(BotonComenzar)),
  send(@interfaz,append(BotonSalir)),
  send(@interfaz,open_centered).

  :-crea_interfaz_inicio.

conocimiento('estres_postraumatico',
['?Te irritas facilmente?', '?Te asustas con facilidad?',
'?Tienes problemas de memoria?']).

conocimiento('epilepsia_fotosensible',
['?Tiene anomal?as en la visi?n?', '?Ha tenido espasmos?',
'?Ah tenido convulsiones?','?Tiene n?useas al jugar videojuegos?']).

conocimiento('cinetosis',
['?Tiene mareos continuos?,?Es sensible al ruido?',
'?Ha experimentado p?rdida de la orientacion?', '?Es usted una persona con ansiedad o miedo?']).

conocimiento('acufenos',
['?Es sensible al sonido?', '?Sufre de presi?n alta?',
 '?Ha tenido zumbidos repentinos o se?as de traumatismo o cerumen excesivo?']).

conocimiento('psicoticismo',
['?Se identifica como una persona impulsiva?', '?Se identifica como una persona agresiva?',
 '?Es una persona con apat?a?']).

conocimiento('tunel_carpiano',
['?Ha tenido hormigueo en la mano al jugar?', '?Ha tenido entumecimiento en la mano al jugar?']).

conocimiento('fatiga_ocular',
['?Tiene ojos llorosos?',
 '?Tiene visi?n borrosa o doble?']).

id_imagen_preg('?Te irritas facilmente?','irritacion').
id_imagen_preg('?Te asustas con facilidad?','miedo').
id_imagen_preg('?Tienes problemas de memoria?','memoria').

id_imagen_preg('?Tiene anomal?as en la visi?n?','vision').
id_imagen_preg('?Ha tenido espasmos?','espasmos').
id_imagen_preg('?Ah tenido convulsiones?','convulsiones').
id_imagen_preg('?Tiene n?useas al jugar videojuegos?','nauseas').

id_imagen_preg('?Tiene mareos continuos?','mareos').
id_imagen_preg('?Es sensible al ruido?','ruido').
id_imagen_preg('?Ha experimentado p?rdida de la orientacion?','desorientacion').
id_imagen_preg('?Es usted una persona con ansiedad o miedo?','miedo').

id_imagen_preg('?Es sensible al sonido?','ruido').
id_imagen_preg('?Sufre de presi?n alta?','presion').
id_imagen_preg('?Ha tenido zumbidos repentinos o se?as de traumatismo o cerumen excesivo?','zumbido').

id_imagen_preg('?Se identifica como una persona impulsiva?','impulsiva').
id_imagen_preg('?Se identifica como una persona agresiva?','agresiva').
id_imagen_preg('?Es una persona con apat?a?','apatia').

id_imagen_preg('?Ha tenido hormigueo en la mano al jugar?','hormigueo').
id_imagen_preg('?Ha tenido entumecimiento en la mano al jugar?','manos').
/*id_imagen_preg('?Tiene debilidad en la mano?','debilidad').*/

id_imagen_preg('?Tiene ojos llorosos?','lloroso').
id_imagen_preg('?Tiene visi?n borrosa o doble?','borroso').

/*BASE DE CONOCIMIENTOS para las recomendaciones basadas en cada enfermedad*/

id_imagen_reco('estres_postraumatico','jvh_juego').
id_imagen_reco('epilepsia_fotosensible','jcli_juego').
id_imagen_reco('cinetosis','jcppvr_juego').
id_imagen_reco('acufenos','jses_juego').
id_imagen_reco('psicoticismo','jrma_juego').
id_imagen_reco('tunel_carpiano','jvri_juego').
id_imagen_reco('fatiga_ocular','descanso').



 /* MOTOR DE INFERENCIA: Esta parte del sistema experto se encarga de
 inferir cual es el diagnostico a partir de las preguntas realizadas
 */
:- dynamic conocido/1.

  mostrar_diagnostico(X):-haz_diagnostico(X),clean_scratchpad.
  mostrar_diagnostico(lo_siento_diagnostico_desconocido):-clean_scratchpad .

  haz_diagnostico(Diagnosis):-
                            obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas),
                            prueba_presencia_de(Diagnosis, ListaDeSintomas).


obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas):-
                            conocimiento(Diagnosis, ListaDeSintomas).


prueba_presencia_de(Diagnosis, []).
prueba_presencia_de(Diagnosis, [Head | Tail]):- prueba_verdad_de(Diagnosis, Head),
                                              prueba_presencia_de(Diagnosis, Tail).


prueba_verdad_de(Diagnosis, Sintoma):- conocido(Sintoma).
prueba_verdad_de(Diagnosis, Sintoma):- not(conocido(is_false(Sintoma))),
pregunta_sobre(Diagnosis, Sintoma, Reply), Reply = 'si'.


pregunta_sobre(Diagnosis, Sintoma, Reply):- preguntar(Sintoma,Respuesta),
                          process(Diagnosis, Sintoma, Respuesta, Reply).


process(Diagnosis, Sintoma, si, si):- asserta(conocido(Sintoma)).
process(Diagnosis, Sintoma, no, no):- asserta(conocido(is_false(Sintoma))).


clean_scratchpad:- retract(conocido(X)), fail.
clean_scratchpad.


conocido(_):- fail.

not(X):- X,!,fail.
not(_).








