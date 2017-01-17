PASTA_SAIDA="extracao"

mkdir $PASTA_SAIDA
cd $PASTA_SAIDA

for numero in $(seq 900)
do
  mplayer -frames $numero -vo jpeg  "../VID_20161010_110305.mp4"
  echo "mplayer -frames $numero -vo jpeg  VID_20161010_110305.mp4" 
done
