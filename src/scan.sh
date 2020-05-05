for i in $(seq 0 12); do
    FILE="~/Documents/BrightSightContract/Questionaire/p0${i}.pdf"
    hp-scan -m color -s pdf -o $FILE
    echo "Saved to $FILE"
    read
done
