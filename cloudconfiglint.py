#!/usr/bin/env python3

# python3 cloudconfiglint.py target-cloudconfig.yml
# searching for duplicated usernames

import argparse
import re
import subprocess
import sys
from collections import Counter
from operator import itemgetter
from pprint import pprint

from yaml import safe_load


def main(argv=None):
    parser = argparse.ArgumentParser(
        prog="cloudconfiglint.py",
        description="searching for duplicated usernames from cloudconfig.yaml",
    )
    parser.add_argument("infile", type=argparse.FileType("r"))
    args = parser.parse_args(argv)

    cc = safe_load(args.infile)
    args.infile.close()
    
    users = list(map(itemgetter("name"), cc["users"]))
    dup_users = [k for k, v in Counter(users).items() if v > 1]
    print(f"duplicated users: {dup_users}")

    print("-- extract yaml --")
    dup_users_dict = sorted(
        filter(lambda x: x["name"] in dup_users, cc["users"]), key=itemgetter("name")
    )
    pprint(list(dup_users_dict))

    print('-- grep --')
    pattern = f"^[[:space:]]*name:[[:space:]]*({'|'.join(map(re.escape, dup_users))})[[:space:]]*$"
    cmd = ["/usr/bin/env", "grep", "-HnE", "-A2", "-B1", pattern, args.infile.name]
    result = subprocess.run(cmd, capture_output=True, text=True, check=True)
    print(result.stderr)
    print(result.stdout)


if __name__ == '__main__':
    sys.exit(main())
