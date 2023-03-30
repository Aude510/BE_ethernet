# BE contrôle d'accès au medium 4IR-SC

Stratis Karagiorgos, Romain Moulin, Aude Jean-Baptiste

# Implementation  
Notre [code](./Ethernet_Controller/Ethernet_Controller.srcs/sources_1/new/ethernet_controller.vhd) et notre [fichier de tests](./Ethernet_Controller/Ethernet_Controller.srcs/sim_1/new/test_recv_v0.vhd).
## Fonctions implémentées 
Nous avons réalisé une série de tests de notre projet dont les captures sont présentes dans [ce dossier](./captures_tests). Vous trouverez un rapport sur le projet [ici](./rapport_be_ethernet.pdf).
## Taille du circuit 
254 flip flops 
## Fréquence de fonctionnement maximale
Nous avons obtenu un WNS minimal pour une clock en contrainte à 16ns.
WNS = 0.128ns soit une fréquence de fonctionnement maximale f = 7,8GHz
