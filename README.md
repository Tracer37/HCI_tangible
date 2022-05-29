# HCI tangible devices

Celem projektu jest zaimplementowanie sterowania w grze przy pomocy dowolnych przedmiotów (tangible interfaces).  
W celu rozpoznawania zadanych obiektów użyto jako sieci bazowej ResNet-50, którą nastepnie przystosowano i dotrenowano na docelowym zbiorze danych.

## Konfiguracja

Wymagane jest zainstolowanie dodatkowych modułów MATLABA:
- *DeepLearning Toolbox*
- *Computer Vision Toolbox*

Warto róznież zaopatrzyć sie w:
- *Parallel processing Toolbox*

## Kalibracja

Nie jest wymagana, zadaniem skryptu jest tylko wykrycie obiektu. Informacja o jego (dokładnym) położeniu nie jest istotna.

## Użycie

Po uruchomieniu skryptu będą zbierane dane z wbudowanej kamerki laptopa a następnie wytrenowana wczesniej sieć będzie klasyfikować obrazy.
Jeśli uzyskane zostanie określone prawdopodobieństwo, informacja o wykryciu obiektu zostanie przesłana aplikacji głównej.

## Prezentacja działania

W celu zademonstrowania działania aplikacji nagrano film - ```Prezentacja_działania.mp4```, który prezentuje rezultaty na podstawie kilku z pośród przewidzianych w projekcie obiektów.
