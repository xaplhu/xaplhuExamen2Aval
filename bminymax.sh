#!/bin/bash

while IFS=',' read -r ciudad mes anio consumo; do

 
  if [[ $ciudad_max == "" ]]; then
    ciudad_max=$ciudad
    mes_max=$mes
    anio_max=$anio
    consumo_max=$consumo
    ciudad_min=$ciudad
    mes_min=$mes
    anio_min=$anio
    consumo_min=$consumo
  fi

 
  if (( $consumo > $consumo_max )); then
    ciudad_max=$ciudad
    mes_max=$mes
    anio_max=$anio
    consumo_max=$consumo
  fi


  if (( $consumo < $consumo_min )); then
    ciudad_min=$ciudad
    mes_min=$mes
    anio_min=$anio
    consumo_min=$consumo
  fi

done < consumos.txt


echo "Ciudad de consumo máximo: $ciudad_max, Mes: $mes_max, Año: $anio_max"
echo "Ciudad de consumo mínimo: $ciudad_min, Mes: $mes_min, Año: $anio_min"
