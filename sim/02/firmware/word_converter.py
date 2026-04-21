import re

# convertes the riscv64-unknown-elf-gcc verilog output to be a list one word per line.
# also changes the endianess

#input_file = "firmware.hex"
input_file = "program.hex"
output_file = "firmware_words.hex"

bytes_list = []

with open(input_file, "r") as f:
    for line in f:
        line = line.strip()

        if not line:
            continue

        # Ignore address markers like @00000000
        if line.startswith("@"):
            continue

        # Split whitespace-separated byte tokens
        tokens = line.split()

        for tok in tokens:
            tok = tok.strip()
            if re.fullmatch(r"[0-9a-fA-F]{2}", tok):
                bytes_list.append(int(tok, 16))

# Pad to multiple of 4 bytes
while len(bytes_list) % 4 != 0:
    bytes_list.append(0)

with open(output_file, "w") as f:
    for i in range(0, len(bytes_list), 4):
        b0 = bytes_list[i + 0]
        b1 = bytes_list[i + 1]
        b2 = bytes_list[i + 2]
        b3 = bytes_list[i + 3]

        word = b0 | (b1 << 8) | (b2 << 16) | (b3 << 24)
        f.write(f"{word:08x}\n")
