function date_time() {

    printf "%s " "$(date +'%Y-%m-%d %H:%M:%S %Z')"

}

function main() {

    date_time

}

# Calling the main function which will call the other functions.
main

