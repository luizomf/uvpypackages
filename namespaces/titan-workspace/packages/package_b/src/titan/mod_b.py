from titan.mod_a import func_a


def func_b(msg: str = "") -> None:
    func_a()
    print("PACKAGE_B", msg)
