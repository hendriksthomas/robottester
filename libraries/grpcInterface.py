#!/usr/bin/env python

# Modules
from pygnmi.client import gNMIclient

def gnmiGet(host, port="57400", user="admin", password="admin"):
    paths = ['openconfig-interfaces:interfaces', 'openconfig-network-instance:network-instances']

    with gNMIclient(target=(host, port), username=user,
                    password=password, insecure=True) as gc:
        result = gc.get(path=paths, encoding='json')
    print(f"{host}: {result}\n\n")
    return f"{host}: {result}\n\n"