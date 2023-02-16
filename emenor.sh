#!/bin/bash

declare -A medias
while IFS=',' read -r ciudad mes anio consumo; do
  if [[ -z "${medias[$ciudad]}" ]]; then
    medias[$ciudad]=$consumo
  else
    medias[$ciudad]=$(( ${medias[$ciudad]} + $consumo ))
  fi
done < consumos.txt

for ciudad in "${!medias[@]}"; do
  n_consumos=$(grep -c "^$ciudad," datos_consumo.csv)
  media_consumo=$(echo "scale=2; ${medias[$ciudad]} / $n_consumos" | bc)
  echo "La media de consumo en $ciudad es de: $media_consumo"
done

ciudad_min=""
media_min=""

for ciudad in "${!medias[@]}"; do
  n_consumos=$(grep -c "^$ciudad," datos_consumo.csv)
  media_consumo=$(echo "scale=2; ${medias[$ciudad]} / $n_consumos" | bc)
  if [[ -z $media_min ]] || (( $(echo "$media_consumo < $media_min" | bc -l) )); then
    ciudad_min=$ciudad
    media_min=$media_consumo
  fi
done

echo "La ciudad con la media de consumo más baja es: $ciudad_min, con una media de $media_min"
