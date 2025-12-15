from titan.mod_a import func_a


def func_b(msg: str = "") -> str:
    func_a()
    print("PACKAGE_B", msg)
    return msg
