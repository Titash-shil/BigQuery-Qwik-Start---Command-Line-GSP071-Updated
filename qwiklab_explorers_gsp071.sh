
bq show bigquery-public-data:samples.shakespeare
echo 

bq query --use_legacy_sql=false \
'SELECT
  word,
  SUM(word_count) AS count
 FROM
  `bigquery-public-data`.samples.shakespeare
 WHERE
  word LIKE "%raisin%"
 GROUP BY
  word'
echo 

bq query --use_legacy_sql=false \
'SELECT
  word
 FROM
  `bigquery-public-data`.samples.shakespeare
 WHERE
  word = "huzzah"'
echo 

bq mk babynames
echo 

wget https://github.com/Titash-shil/BigQuery-Qwik-Start---Command-Line-GSP071-Updated/blob/main/names.zip
echo 

unzip names.zip
echo 

bq load babynames.names2010 yob2010.txt name:string,gender:string,count:integer
echo 

bq query "SELECT name,count FROM babynames.names2010 WHERE gender = 'F' ORDER BY count DESC LIMIT 5"
echo 

bq query "SELECT name,count FROM babynames.names2010 WHERE gender = 'M' ORDER BY count ASC LIMIT 5"
echo 

bq rm -r babynames
echo 

rm -f names.zip yob2010.txt
echo 

