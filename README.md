# vim-pycall
Python call helper for vimscript 🐍

* only py3 implemented

## install

```toml
# dein.toml
[[plugins]]
repo = 'ousttrue/vim-pycall'
```

## example

open `sample.py` by nvim

```py
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
```

on nvim

`:py3file %`

call python function and get result

`:echo PyCall('hello')`

list OK

`:echo PyCall('hello_dir')`

dictionary OK

`:echo PyCall('hello_dict')['hoge']`

argument OK

`:echo PyCall('hello_arg', 1)`

`:echo PyCall('hello_arg', "src")`

