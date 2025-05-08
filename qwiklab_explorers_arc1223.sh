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


export PROJECT_ID=$(gcloud config get-value project)

echo
read -p "${GREEN_TEXT}${BOLD_TEXT}Enter the region: ${RESET_FORMAT}" REGION
echo
read -p "${GREEN_TEXT}${BOLD_TEXT}Enter the Cloud Function name: ${RESET_FORMAT}" FUNCTION_NAME
echo


mkdir -p cloud-function
cat > cloud-function/index.js <<EOF
exports.helloWorld = (req, res) => {
  res.send('Hello from Cloud Function!');
};
EOF

cat > cloud-function/package.json <<EOF
{
  "name": "cf-nodejs",
  "version": "1.0.0",
  "main": "index.js"
}
EOF



gcloud functions deploy ${FUNCTION_NAME} \
  --gen2 \
  --runtime=nodejs20 \
  --region=${REGION} \
  --source=cloud-function \
  --entry-point=helloWorld \
  --trigger-http \
  --max-instances=5 \
  --allow-unauthenticated

echo -e "\n"


cd ~


echo "${GREEN_TEXT}${BOLD_TEXT} Subscribe to QwikLab Explorers ${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}${UNDERLINE_TEXT}https://www.youtube.com/@qwiklabexplorers${RESET_FORMAT}"
echo
