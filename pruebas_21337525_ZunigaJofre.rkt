#lang racket
(require "main_21337525_ZunigaJofre.rkt")


;Script de Pruebas Enunciado

;Ejemplo de un sistema de chatbots basado en el esquema del enunciado general
;Chabot0
(define op1 (option  1 "1) Viajar" 1 1 "viajar" "turistear" "conocer"))
(define op2 (option  2 "2) Estudiar" 2 1 "estudiar" "aprender" "perfeccionarme"))
(define f10 (flow 1 "Flujo Principal Chatbot 1\nBienvenido\n¿Qué te gustaría hacer?" op1 op2 op2 op2 op2 op1)) ;solo añade una ocurrencia de op2 y op1
(define f11 (flow-add-option f10 op1)) ;se intenta añadir opción duplicada            
(define cb0 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f10 f10 f10 f10))  ;solo añade una ocurrencia de f10
(define cb10(chatbot-add-flow cb0 f10))
;Chatbot1
(define op3 (option 1 "1) New York, USA" 1 2 "USA" "Estados Unidos" "New York"))
(define op4 (option 2 "2) París, Francia" 1 1 "Paris" "Eiffel"))
(define op5 (option 3 "3) Torres del Paine, Chile" 1 1 "Chile" "Torres" "Paine" "Torres Paine" "Torres del Paine"))
(define op6 (option 4 "4) Volver" 0 1 "Regresar" "Salir" "Volver"))
;Opciones segundo flujo Chatbot1
(define op7 (option 1 "1) Central Park" 1 2 "Central" "Park" "Central Park"))
(define op8 (option 2 "2) Museos" 1 2 "Museo"))
(define op9 (option 3 "3) Ningún otro atractivo" 1 3 "Museo"))
(define op10 (option 4 "4) Cambiar destino" 1 1 "Cambiar" "Volver" "Salir")) 
(define op11 (option 1 "1) Solo" 1 3 "Solo")) 
(define op12 (option 2 "2) En pareja" 1 3 "Pareja"))
(define op13 (option 3 "3) En familia" 1 3 "Familia"))
(define op14 (option 4 "4) Agregar más atractivos" 1 2 "Volver" "Atractivos"))
(define op15 (option 5 "5) En realidad quiero otro destino" 1 1 "Cambiar destino"))
(define f20 (flow 1 "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?" op3 op4 op5 op6))
(define f21 (flow 2 "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?" op7 op8 op9 op10))
(define f22 (flow 3 "Flujo 3 Chatbot1\n¿Vas solo o acompañado?" op11 op12 op13 op14 op15))
(define cb1 (chatbot 1 "Agencia Viajes"  "Bienvenido\n¿Dónde quieres viajar?" 1 f20 f21 f22))
;Chatbot2
(define op16 (option 1 "1) Carrera Técnica" 2 1 "Técnica"))
(define op17 (option 2 "2) Postgrado" 2 1 "Doctorado" "Magister" "Postgrado"))
(define op18 (option 3 "3) Volver" 0 1 "Volver" "Salir" "Regresar"))

(define f30 (flow 1 "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?" op16 op17 op18))
(define cb2 (chatbot 2 "Orientador Académico"  "Bienvenido\n¿Qué te gustaría estudiar?" 1 f30))
;Sistema
(define s0 (system "Chatbots Paradigmas" 0 cb0 cb0 cb0 cb1 cb2))
(define s1 (system-add-chatbot s0 cb0)) ;igual a s0
(define s2 (system-add-user s1 "user1"))
(define s3 (system-add-user s2 "user2"))
(define s4 (system-add-user s3 "user2"))
(define s5 (system-add-user s4 "user3"))
(define s6 (system-login s5 "user8"))
(define s7 (system-login s6 "user1"))
(define s8 (system-login s7 "user2"))
(define s9 (system-logout s8))
(define s10 (system-login s9 "user2"))

;las siguientes interacciones deben funcionar de igual manera con system-talk-rec  o system-talk-norec 
(define s11 (system-talk-rec s10 "hola"))
(define s12 (system-talk-norec s11 "1"))
(define s13 (system-talk-rec s12 "1"))
(define s14 (system-talk-norec s13 "Museo"))
(define s15 (system-talk-rec s14 "1"))
(define s16 (system-talk-norec s15 "3"))
(define s17 (system-talk-rec s16 "5"))
(display (system-synthesis s17 "user2"))

(define s18 (system-talk-norec s10 "hola"))
(define s19 (system-talk-norec s18 "1"))
(define s20 (system-talk-norec s19 "1"))
(define s21 (system-talk-norec s20 "Museo"))
(define s22 (system-talk-norec s21 "1"))
(define s23 (system-talk-norec s22 "3"))
(define s24 (system-talk-norec s23 "5"))
(display (system-synthesis s24 "user2"))

(system-simulate s0 5 32131)

;................Mi Script


(define my-op01(option 1 "1)Noticias nacionales" 1 1 "nacional" "Chile" "NACIONALES"))
(define my-op02(option 2 "2)Noticias internacionales" 2 1 "INTER" "internacional" "extranjero"))
(define my-op03(option 3 "3)Por tema" 3 1 "tema" "TOPICO" "otras"))

(define my-op11(option 1 "1)Noticias de Santiago" 1 2 "Santiago" "capital" "RM"))
(define my-op12(option 2 "2)Noticias de Valparaiso" 1 2 "Valparaiso" "Quinta region"))
(define my-op13(option 3 "3)Noticias de Antofagasta" 1 2 "NORTE" "Antofagasta"))
(define my-op14(option 4 "4)Noticias de Chiloe" 1 2 "Sur" "chiloe"))
(define my-op15(option 5 "5)Volver" 0 1  "volver" "ATRAS" "Regresar"))

(define my-op16(option 1 "1)Robo a un banco" 1 2 "ROBO" "banco" "Asalto"))
(define my-op17(option 2 "2)Proximos proyectos para la ciudad" 1 2 "proximo" "Proyectos"))
(define my-op18(option 3 "3)Volver" 1 1  "volver" "ATRAS" "Regresar"))

(define my-op21(option 1 "1)Noticias de USA" 2 2 "usa" "Norteamerica" "ESTADOS UNIDOS"))
(define my-op22(option 2 "2)Noticias de Brasil" 2 1 "BRASIL"))
(define my-op23(option 3 "3)Noticias de Francia" 2 1 "Francia" "Europa"))
(define my-op24(option 4 "4)Volver" 0 1  "volver" "ATRAS" "Regresar"))

(define my-op25(option 1 "1)Elon Musk anuncia nuevo proyecto" 2 2 "ELON" "Musk" "nuevo"))
(define my-op26(option 2 "2)Estados Unidos anuncia nuevos estadios para el proximo mundial de futbol" 2 2 "mundial" "Futbol"))
(define my-op27(option 3 "4)Volver" 2 1  "volver" "ATRAS" "Regresar"))

(define my-op31(option 1 "1)Noticias de Economia" 3 2 "Economia" "FINANZAS"))
(define my-op32(option 2 "2)Noticias de Deporte" 3 3 "DEPORTES" "deporte" "Ejercicio"))
(define my-op33(option 3 "3)Volver" 0 1  "volver" "ATRAS" "Regresar"))

(define my-op34(option 1 "1)Cambia el valor del dolar" 3 2  "cambio" "DOLAR" "Valor"))
(define my-op35(option 2 "2)Proyecto para reducir la inflación" 3 2 "reducir" "INFLACION"))
(define my-op36(option 3 "3)Volver" 3 1  "volver" "ATRAS" "Regresar"))

(define my-op37(option 1 "1)Mundial de Futbol 2026" 3 3 "MUNDIAL" "futbol" "2026"))
(define my-op38(option 2 "2)Juegos Olimpicos 2024" 3 3"juegos" "OLIMPIADAS" "Olimpicos" "JJOO" "2024"))
(define my-op39(option 3 "3)Volver" 3 1  "volver" "ATRAS" "Regresar"))

(define my-flow01 (flow 1 "Flujo Inicial Chatbot0\n Bienvenido\n ¿Qué tipo de noticia quieres ver?" my-op01 my-op01 my-op02 my-op01 my-op03))

(define my-flow11(flow 1 "Flujo 1 Chatbot1\n Bienvenido\n ¿De dónde quieres ver noticias?" ))

(define my-flow12(flow 2 "Flujo 2 Chatbot1\n Bienvenido\n ¿Que noticia quieres ver?" my-op16 my-op17 my-op18 ))

(define my-flow21(flow 1 "Flujo 1 Chatbot2\n Bienvenido\n ¿De dónde quieres ver noticias?" my-op21 my-op22 my-op23 my-op24))

(define my-flow22(flow 2 "Flujo 2 Chatbot2\n Bienvenido\n ¿Que noticia quieres ver?" my-op25 my-op26 my-op27 ))

(define my-flow31(flow 1 "Flujo 1 Chatbot3\n Bienvenido\n ¿Que tema te interesa?" my-op31 my-op32 my-op33 ))

(define my-flow32(flow 2 "Flujo 2 Chatbot3\n Bienvenido\n ¿Que noticia quieres ver?" my-op34 my-op35 my-op36 ))

(define my-flow33(flow 3 "Flujo 3 Chatbot3\n Bienvenido\n ¿Que noticia quieres ver?" my-op37 my-op38 my-op39 ))

(define my-flow010 (flow-add-option my-flow01 my-op01))

(define my-flow111 (flow-add-option my-flow11 my-op11))
(define my-flow112 (flow-add-option my-flow111 my-op12))
(define my-flow113 (flow-add-option my-flow112 my-op13))
(define my-flow114 (flow-add-option my-flow113 my-op14))
(define my-flow115 (flow-add-option my-flow114 my-op15))

(define my-cb0 (chatbot 0 "Inicial" "Bienvenido\n" 1 my-flow010 my-flow010))

(define my-cb1 (chatbot 1 "Noticias Nacionales" "Bienvenido\n" 1 my-flow115 my-flow12 my-flow010))

(define my-cb2 (chatbot 2 "Noticias Internacionales" "Bienvenido\n" 1 my-flow21 my-flow22 ))

(define my-cb3 (chatbot 3 "Noticias por tema" "Bienvenido\n" 1))

(define my-cb01(chatbot-add-flow my-cb0 my-flow010))

(define my-cb31(chatbot-add-flow my-cb3 my-flow31))
(define my-cb32(chatbot-add-flow my-cb31 my-flow32))
(define my-cb33(chatbot-add-flow my-cb32 my-flow33))

(define my-s00(system "Chatbots Noticias" 0 ))

(define my-s10(system "Chatbots Noticias" 0 my-cb01 my-cb1 my-cb2 my-cb33 my-cb01 my-cb3))

(define my-s20(system "Chatbots Noticias" 0 my-cb33 my-cb01 my-cb1 my-cb2))

(define my-s01(system-add-chatbot my-s00 my-cb01))
(define my-s02(system-add-chatbot my-s01 my-cb1))
(define my-s03(system-add-chatbot my-s02 my-cb2))
(define my-s04(system-add-chatbot my-s03 my-cb33))

(define my-s11(system-add-chatbot my-s10 my-cb01))

(define my-s05(system-add-user my-s04 "user1"))
(define my-s12(system-add-user my-s11 "user1"))
(define my-s13(system-add-user my-s12 "user2"))
(define my-s14(system-add-user my-s13 "user5"))
(define my-s21(system-add-user my-s20 "user1"))



(define my-s06(system-logout my-s05))

(define my-s07(system-login my-s06 "user1"))

(define my-s15(system-login my-s14 "user1"))

(define my-s16(system-logout my-s15))
(define my-s22(system-login my-s21 "user1"))

(define my-s23(system-logout my-s22))

(define my-s24(system-login my-s23 "user2"))
(define my-s25(system-add-user my-s24 "user3"))
 
(define my-s26(system-login my-s25 "user3"))


(define my-s08(system-talk-rec my-s07 "Hola"))
(define my-s09(system-talk-rec my-s08 "nacional"))
(define my-s010(system-talk-rec my-s09 "1"))

(define my-s17(system-talk-rec my-s16 "hola"))

(define my-s27(system-talk-rec my-s26 "Hola"))
(define my-s28(system-talk-rec my-s27 "1"))
(define my-s29(system-talk-rec my-s28 "RM"))

(define my-s011(system-talk-norec my-s010 "atras"))
(define my-s012(system-talk-norec my-s011 "VOLVER"))
(define my-s013(system-talk-norec my-s012 "3"))

(define my-s18(system-talk-norec my-s16 "hola"))

(display(system-synthesis my-s29 "user3"))
(display(system-synthesis my-s010 "user1"))

(display(system-synthesis my-s013 "user1"))

(display(system-synthesis my-s29 "user2"))

(define my-s210(system-simulate my-s29 4 1407))
(display(system-synthesis my-s210 "user1407"))

(define my-s014(system-simulate my-s04 4 1407))
(display(system-synthesis my-s014 "user1407"))

(define my-s19(system-simulate my-s18 6 121121))
(display(system-synthesis my-s19 "user121121"))

