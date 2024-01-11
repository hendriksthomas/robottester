#!/usr/bin/env python

# Modules
from pygnmi.client import gNMIclient
import psycopg2

def gnmiGet(host, paths, port="57400", user="admin", password="admin" ):
    paths = [paths]
    with gNMIclient(target=(host, port), username=user,
                    password=password, insecure=True) as gc:
        result = gc.get(path=paths, encoding='json')
    return result


def gnmiSet(host, path, payload, port=57400, user="admin", password="admin"):
    with gNMIclient(target=(host, port), username=user,
                    password=password, insecure=True) as gc:
        result = gc.set(update=[(path,payload)], encoding='json')
    return result