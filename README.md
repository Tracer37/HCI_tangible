# HCI tangible devices

Celem projektu jest zaimplementowanie sterowania komputerem przy pomocy dowolnych przedmiotów (tangible interfaces).  
W celu rozpoznawania zadanych obiektów użyto sieci Resnet50, którą nastepnie przystosowano i dotrenowano na docelowym zbioorze danych.

## Konfiguracja

TODO

## Kalibracja

Nie jest wymagana, zadaniem skryptu jest tylko wykrycie obiektu. Informacja o jego położeniu nie jest istotna.

## Użycie

Po uruchomieniu skryptu będą zbierane dane z wbudowanej kamerki laptopa a następnie wytrenowana wczesniej sieć będzie klasyfikować obrazy
i jeśli uzyskane zostanie określone prawdopodobieństwo, informacja o wykryciu obiektu zostanie przesłana aplikacji głównej
