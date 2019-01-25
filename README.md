# IRIS Randomness

Bash script to use an IRIS (Incorporated Research Institutions for Seismology) earthquake event as a public source of randomness.

Bash script for calculating the winning lottery number using earthquake
data from IRIS (Incorporated Research Institutions for Seismology).

Assumes you want a 10-digit hex string, as per the [EffectiveAltruism.org donor lottery](https://app.effectivealtruism.org/lotteries).

The script works as follows:
- get the request from the IRIS server for the relevant event
- trim newlines from the response
- strip the response to just the numeric digits
- get the SHA256 hash of the digit string in binary
- cast the binary hash to a hexdump (only keeping the first line)
- truncate the hash to its first 10 characters

## Usage:
```
./draw_lottery_iris.sh iris_id
```

For example:

```
 ./draw_lottery_iris.sh 10998811
```

Which returns:

```

  URL:
  http://service.iris.edu/fdsnws/event/1/query?eventid=10998811&format=text

  API Response:
    #EventID | Time | Latitude | Longitude | Depth/km | Author | Catalog | Contributor | ContributorID | MagType | Magnitude | MagAuthor | EventLocationName
10998811|2019-01-24T00:52:38|-15.1354|-173.4036|10.0|us|NEIC PDE|us|us2000j82f|mb|5.5|us|TONGA ISLANDS

  Winning number (ISIS event 10998811):
    digits:  1099881120190124005238151354173403610020008255
    hash:    dd6f408f593e8117a976cf1b1b9b2855e605e982319011a51429fb848e8d
    hex:     dd6f408f59
    dec:     951054274393

```


## Old version

A previously published version of the script is preserved in `./draw_lottery_iris_old.sh`
