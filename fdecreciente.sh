#!/bin/bash

declare -A consumos

while IFS=',' read -r ciudad mes anio consumo; do
  if [[ $anio -eq 2022 && ( $ciudad == "Valencia" || $ciudad == "Madrid" || $ciudad == "Barcelona" ) ]]; then
    if [[ -z "${consumos[$ciudad]}" ]]; then
      consumos[$ciudad]=$consumo
    else
      consumos[$ciudad]="${consumos[$ciudad]},$consumo"
    fi
  fi
done < consumos.txt

declare -A medias

for ciudad in Valencia Madrid Barcelona; do
  mes=1
  for consumo in $(echo "${consumos[$ciudad]}" | tr ',' ' '); do
    if [[ -z "${medias[$ciudad]}" ]]; then
      medias[$ciudad]="$consumo"
    else
      medias[$ciudad]="${medias[$ciudad]},$consumo"
    fi
    mes=$(( $mes + 1 ))
  done
done

for ciudad in Valencia Madrid Barcelona; do
  mes=1
  for consumo in $(echo "${medias[$ciudad]}" | tr ',' ' '); do
    if [[ -z "${medias_totales[$mes]}" ]]; then
      medias_totales[$mes]="$consumo"
    else
      medias_totales[$mes]="${medias_totales[$mes]},$consumo"
    fi
    mes=$(( $mes + 1 ))
  done
done

for mes in {1..12}; do
  for ciudad in Valencia Madrid Barcelona; do
    consumo_mes=$(echo "${medias[$ciudad]}" | cut -d "," -f $mes)
    consumo_mes_anterior=$(echo "${medias[$ciudad]}" | cut -d "," -f $(( $mes - 1 )))

    if [[ -n $consumo_mes_anterior && $consumo_mes -gt $consumo_mes_anterior ]]; then
      break
    fi

    if [[ $ciudad == "Barcelona" && $mes -eq 12 ]]; then
      echo "La ciudad $ciudad tuvo un consumo decreciente durante todo el año 2022."
    fi
  done
done
