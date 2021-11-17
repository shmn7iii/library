# seasar

# chr(64) = "@"
# chr(65) = "A"
# chr(66) = "B"

def encrypt(plain_text, shift_num):
    retval = ""
    for s in plain_text:
        # アルファベット外へ行ったら"A"まで巻き戻す
        if ord(s) + shift_num > 90:
            retval += chr(ord(s) + shift_num - 26)
        else:
            retval += chr(ord(s) + shift_num)
    return retval

# print(encrypt("CRYPTOGRAPHY",13))

def burute_force_attack(str):
    # 26回
    for i in range(26):
        ans = ""
        for s in str:
            # アルファベット外へ行ったら"A"まで巻き戻す
            if ord(s) - i < 65 :
                ans += chr(ord(s) - i + 26)
            else:
                ans += chr(ord(s) - i)

        print(f"鍵{i}で復号化 -> {ans}")

burute_force_attack("PELCGBTENCUL")