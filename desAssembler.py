
tipo1 = ['ldi', 'ldm', 'stm', 'adi']
tipo2 = ['cmp', 'add', 'sub', 'and', 'oor', 'xor']
tipo3 = ['jmp', 'jpz', 'jnz', 'jpc', 'jnc', 'csr', 'csz', 'cnz', 'csc', 'cnc']
tipo4 = ['sl0', 'sl1', 'sr0', 'sr1', 'rrl', 'rrr', 'not']
tipo5 = ['ret', 'nop']
# instruccion   opcode
# Diccionario de opcodes a instrucciones
opcodes = {
    'ldi': 2, 'ldm': 3, 'stm': 4, 'cmp': 5, 'add': 6, 'sub': 7, 'and': 8,
    'oor': 9, 'xor': 10, 'jmp': 11, 'jpz': 12, 'jnz': 13, 'jpc': 14, 'jnc': 15,
    'csr': 16, 'ret': 17, 'adi': 18, 'csz': 19, 'cnz': 20, 'csc': 21, 'cnc': 22,
    'sl0': 23, 'sl1': 24, 'sr0': 25, 'sr1': 26, 'rrl': 27, 'rrr': 28, 'not': 29, 'nop': 30
}

# Crear el diccionario opcode_to_instruction después de definir 'opcodes'
opcode_to_instruction = {v: k for k, v in opcodes.items()}

jumplist = {}


def decode_instruction(hex_instruction):
    # Convierte la instrucción en hexadecimal a un entero
    instruction = int(hex_instruction, 16)
    
    # Extrae el opcode (primeros 5 bits más significativos)
    opcode = instruction >> 11
    # Resto de bits dependerá del tipo de instrucción
    
    # Verifica que el opcode sea válido
    if opcode not in opcode_to_instruction:
        return "Invalid opcode"
    
    # Identifica la instrucción y tipo basado en el opcode
    inst = opcode_to_instruction[opcode]
    if inst in tipo1:
        reg = (instruction >> 8) & 0x7  # Extrae el registro (3 bits)
        addr = instruction & 0xFF       # Extrae la dirección (8 bits)
        return f"{inst} r{reg}, {addr}"
    elif inst in tipo2:
        reg1 = (instruction >> 8) & 0x7  # Primer registro (3 bits)
        reg2 = (instruction >> 5) & 0x7  # Segundo registro (3 bits)
        return f"{inst} r{reg1}, r{reg2}"
    elif inst in tipo3:
        addr = instruction & 0x7FF       # Dirección (11 bits)
      	# Verificar si la dirección ya esta asociada a un label
        if addr in jumplist:
            label = jumplist[addr]
        else:
            label = "j%04d" % (len(jumplist) + 1)
            jumplist[addr] = label
        return f"{inst} {label}"
    elif inst in tipo4:
        reg = (instruction >> 8) & 0x7   # Registro (3 bits)
        return f"{inst} r{reg}"
    elif inst in tipo5:
        return inst
    else:
        return "Unknown instruction type"

def desassemble(file_path):
    with open(file_path, 'r') as file:
        hex_lines = file.readlines()
    
    assembly_lines = []
    for hex_line in hex_lines:
        hex_line = hex_line.strip()
        assembly_instruction = decode_instruction(hex_line)
        assembly_lines.append("\t\t" + assembly_instruction)
    
    # Añadir los labels guardados
    for addr in jumplist:
        assembly_lines[addr] = jumplist[addr] + assembly_lines[addr][1:]
    return assembly_lines

# Ejemplo de uso
def main():
    file_path = 'PingProfe.mem'  # Archivo de entrada hexadecimal
    assembly_code = desassemble(file_path)
    
    with open('output.asm', 'w') as output_file:
        for line in assembly_code:
            output_file.write(line + '\n')
    
    print("Desensamblado completado. Código assembler guardado en 'output.asm'.")

if __name__ == "__main__":
    main()
