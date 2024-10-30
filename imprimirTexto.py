# script simple que lee un archivo y muestra las instrucciones necesarias
# para imprimir sus contenidos en assembler (natalius)

from sys import argv

if __name__ == "__main__":
    if len(argv) < 2:
        print("Por favor suministre un nombre de archivo")
        exit()
    try:
        with open(argv[1]) as infile:
            while True:
                c = infile.read(1)
                if len(c) == 0:
                    break
                print("\t\tldi r5, %d\n\t\tstm r5, 32" % ord(c))
    except FileNotFoundError:
        print("archivo %s no encontrado" % argv[1])
