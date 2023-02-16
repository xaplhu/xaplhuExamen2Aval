#!/bin/bash

ciudad = $1;

while [ $(find ./datos -name "*$ciudad*" | wc -l) -eq 0 ]; do
  echo "La ciudad $ciudad no existe. Introduzca una ciudad válida:"
 
 read ciudad

done

total_consumo=0

for archivo in $(find ./datos -name "*$ciudad*"); do

  consumo=$(awk '{sum += $2} END {print sum}' $archivo)
  total_consumo=$(($total_consumo + $consumo))
done

echo "El total de consumo de $ciudad es: $total_consumo"
