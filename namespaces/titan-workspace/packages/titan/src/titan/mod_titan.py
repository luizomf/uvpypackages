from titan.mod_b import func_b


def func_titan(msg: str = "") -> str:
    func_b()
    print("TITAN 1", msg)
    return msg
