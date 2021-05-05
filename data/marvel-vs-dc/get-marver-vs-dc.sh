
# Download the dataset from here: https://www.kaggle.com/leonardopena/marvel-vs-dc
# key information from: https://help.imdb.com/article/contribution/titles/business-imdbpro-only/GEJUWSBB6WXH3RZ6#

cd data/marvel-vs-dc/
iconv -f windows-1252 -t utf-8 marvel-vs-dc-original.csv > ../marvel-vs-dc.csv
# rename the first column as "Id"
