#!/bin/bash


if [[ -z "$1" ]]; then
  echo "Debes especificar la ciudad como parámetro"
  exit 1
fi

ciudad=$1
total_consumo=0
n_consumos=0


while IFS=',' read -r ciudad_actual mes anio consumo; do

  if [[ $ciudad_actual == $ciudad ]]; then
    total_consumo=$(( $total_consumo + $consumo ))
    n_consumos=$(( $n_consumos + 1 ))
  fi

done < consumos.txt

if (( $n_consumos > 0 )); then
  media_consumo=$(echo "scale=2; $total_consumo / $n_consumos" | bc)
  
 
  if (( $(echo "$media_consumo < 400" | bc -l) )); then
    echo "La media de consumo en $ciudad es de: $media_consumo, y su calificación ecológica es: ECO"
  else
    echo "La media de consumo en $ciudad es de: $media_consumo, y su calificación ecológica es: NO ECO"
  fi
else
  echo "No se encontraron consumos para la ciudad especificada"
fi
