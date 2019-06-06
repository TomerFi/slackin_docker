#!/bin/sh

# parse_variables.sh
#
# Parse and spit-out the slackin server variables based on the supplied variables:
# SLACK_SUBDOMAIN, SLACK_API_TOKEN, SLACK_CHANNELS, GOOGLE_CAPTCHA_SECRET, GOOGLE_CAPTCHA_SITEKEY
#
# For use with secrets or configs, use the _FILE counterpart variables:
# SLACK_SUBDOMAIN_FILE, SLACK_API_TOKEN_FILE, SLACK_CHANNELS_FILE, GOOGLE_CAPTCHA_SECRET_FILE, GOOGLE_CAPTCHA_SITEKEY_FILE

display_usage() {
    echo "\t\nPlease set the requiered environment variables prior to running the script,"
    echo "you can also set the variables on-the-fly while running this script as in the following example.\t\n"
    echo "Usage example:"
    echo "--------------"
    echo "SLACK_SUBDOMAIN=subdomain.slack.com \\"
    echo "SLACK_API_TOKEN=thisisADUmmytoKe1Nf89orr \\"
    echo "SLACK_CHANNELS=my_channel \\"
    echo "GOOGLE_CAPTCHA_SECRET=1AdumMySECRETADUMMysecReta2DUmmYsECR3etA \\"
    echo "GOOGLE_CAPTCHA_SITEKEY=1AdummySITEKEY23ADUMM4ysi5keAaDuMMy6si78 \\"
    echo "sh $0\t\n"
    echo "Pro-Tip:"
    echo "You can replace the variables name with their '_FILE' prefixed counterpart and use files containing the values instead of the actual values.\t\n"
}


[ -n "${SLACK_SUBDOMAIN_FILE}" ] && subdomain=$(cat ${SLACK_SUBDOMAIN_FILE}) || subdomain="$SLACK_SUBDOMAIN"

[ -n "${SLACK_API_TOKEN_FILE}" ] && token=$(cat ${SLACK_TOKEN_FILE}) || token="$SLACK_API_TOKEN"

[ -n "${SLACK_CHANNELS_FILE}" ] && channels=$(cat ${SLACK_CHANNELS_FILE}) || channels="$SLACK_CHANNELS"

[ -n "${GOOGLE_CAPTCHA_SECRET_FILE}" ] && secret_key=$(cat ${GOOGLE_CAPTCHA_SECRET_FILE}) || secret_key="$GOOGLE_CAPTCHA_SECRET"

[ -n "${GOOGLE_CAPTCHA_SITEKEY_FILE}" ] && site_key=$(cat ${GOOGLE_CAPTCHA_SITEKEY_FILE}) || site_key="$GOOGLE_CAPTCHA_SITEKEY"

if [ -z "$subdomain"  ] || [ -z "$token"  ] || [ -z "$channels"  ] || [ -z "$secret_key"  ] || [ -z "$site_key"  ]
then
  display_usage
  exit 1
fi

echo "$channels $subdomain $token $secret_key $site_key"
