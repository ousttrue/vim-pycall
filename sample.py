import vim


def hello():
    return 'hello vim-pycall'


def hello_dict():
    return {
        'hoge': 'fuga',
    }


def hello_dict2():
    return {
        'hoge': True,
    }


def hello_dir():
    return dir(vim)


def hello_arg(o):
    return type(o)
