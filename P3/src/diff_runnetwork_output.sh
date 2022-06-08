#!/bin/bash

# ARGS:
# $1: FULL PATH DO ARQUIVO QUE _FIZEMOS_(output do nosso runnetworkexpansion.m)
# $2: FULL PATH DO ARQUIVO QUE NOS DERAM PARA COMPARAR

# ------------------------------------
# ### Preparando os arquivos dados ###

# Removendo outras colunas, deixando apenas os dados que temos de output

#cut -d, -f2-10 --complement mmc2_s2a.csv >> mmc2_s2a_cut.csv
CUTE="cut_${2}"
echo $CUTE
cut -d, -f2-10 --complement $2 > "${CUTE}"

# Removendo as headers
#tail -n +3 mmc2_s2a_cut.csv > mmc2_s2a_cut2.csv
tail -n +3 $CUTE > "2_${CUTE}"

# Removendo o caracter "
#tr -d '"' < mmc2_s2a_cut2.csv > mmc2_s2a_cut.csv
tr -d '"' < "2_${CUTE}" > $CUTE

# Finalmente checando as diferenças.
#diff mmc2_s2a_cut.csv  fig1_mets.csv --report-identical-files # (sem diffs!!)
diff $CUTE $1 -y # (sem diffs!!)
