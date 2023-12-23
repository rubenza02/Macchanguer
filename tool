#!/usr/bin/env python3

import argparse
import re
import subprocess
from termcolor import colored
import signal
import sys

def def_handler(sign, frame):
    print(colored(f"\n[+]Saliendo del programa....", 'blue'))
    sys.exit(1)

signal.signal(signal.SIGINT, def_handler)

def get_arguments():
    parser = argparse.ArgumentParser(description="Herramienta para cambiar la direccion MAC de una interfaz de red")
    parser.add_argument("-i", "--interface", required=True, dest="interface", help="Nombre de la interfaz de red")
    parser.add_argument("-m", "--mac", required=True, dest="mac_addres", help="Nueva direccion MAC para la interfaz de red")

    return parser.parse_args()

def is_valid_input(interface, mac_addres):

    is_valid_interface = re.match(r'^[e][n|t][s|h]\d{1,2}$', interface)
    is_valid_mac_addres = re.match(r'^([A-Fa-f0-9]{2}[:]){5}[A-Fa-f0-9]{2}$', mac_addres)

    return is_valid_interface and is_valid_mac_addres

    print(is_valid_mac_addres)



def changue_mac_addres(interface, mac_addres):

    if is_valid_input(interface, mac_addres):
        subprocess.run(["ifconfig", interface, "down"])
        subprocess.run(["ifconfig", interface, "hw", "ether", mac_addres])
        subprocess.run(["ifconfig", interface, "up"])

        print(colored(f"\n[+]La mac ha sido cambiada correctamente\n", 'green'))

    else:
        print(colored(f"\n[!]Los datos introducidos no son correctos\n"), 'blue')


def main():
    args = get_arguments()
    changue_mac_addres(args.interface, args.mac_addres)

if __name__ == "__main__":
    main()
