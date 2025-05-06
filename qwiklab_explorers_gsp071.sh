#!/bin/bash
BLACK_TEXT=$'\033[0;90m'
RED_TEXT=$'\033[0;91m'
GREEN_TEXT=$'\033[0;92m'
YELLOW_TEXT=$'\033[0;93m'
BLUE_TEXT=$'\033[0;94m'
MAGENTA_TEXT=$'\033[0;95m'
CYAN_TEXT=$'\033[0;96m'
WHITE_TEXT=$'\033[0;97m'
RESET_FORMAT=$'\033[0m'
BOLD_TEXT=$'\033[1m'
UNDERLINE_TEXT=$'\033[4m'

clear


bq show bigquery-public-data:samples.shakespeare
echo 

echo "${YELLOW_TEXT}${BOLD_TEXT} Searching for words containing 'raisin' in Shakespeare's works...${RESET_FORMAT}"
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

echo "${MAGENTA_TEXT}${BOLD_TEXT} Creating a new BigQuery dataset named 'babynames'...${RESET_FORMAT}"
bq mk babynames
echo 

echo "${MAGENTA_TEXT}${BOLD_TEXT} Downloading the baby names data archive...${RESET_FORMAT}"
wget https://github.com/Titash-shil/BigQuery-Qwik-Start---Command-Line-GSP071-Updated/raw/refs/heads/main/names.zip
echo 

unzip names.zip
echo 

bq load babynames.names2010 yob2010.txt name:string,gender:string,count:integer
echo 

bq query "SELECT name,count FROM babynames.names2010 WHERE gender = 'F' ORDER BY count DESC LIMIT 5"
echo 

bq query "SELECT name,count FROM babynames.names2010 WHERE gender = 'M' ORDER BY count ASC LIMIT 5"
echo 

echo "${RED_TEXT}${BOLD_TEXT} Removing the 'babynames' dataset to clean up resources...${RESET_FORMAT}"
bq rm -r babynames
echo 

echo "${RED_TEXT}${BOLD_TEXT} Deleting the downloaded and extracted local files...${RESET_FORMAT}"
rm -f names.zip yob2010.txt
echo 

echo
echo "${MAGENTA_TEXT}${BOLD_TEXT} Subscribe to QwikLab Explorers ${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}${UNDERLINE_TEXT}https://www.youtube.com/@qwiklabexplorers${RESET_FORMAT}"
echo
