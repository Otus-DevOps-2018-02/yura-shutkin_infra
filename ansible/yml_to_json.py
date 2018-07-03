#!/usr/bin/env python
import yaml
import json


inv_yml = open("./inventory.yml", mode="r")
inv_json = open("./inventory-conv.json", mode="ar")
data = yaml.load(inv_yml.read())
inv_json.write(json.dumps(data))

inv_json.close()
inv_yml.close()
