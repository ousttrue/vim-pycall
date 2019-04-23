if !has('python3')
    echo 'not has python3'
    finish
endif

" include guard
if exists('g:pycall_loaded')
    finish
endif
let g:pycall_loaded = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python utility
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
py3 << _EOF_
import io
import vim


def py_dispatch(name, ret_name, args):
    # dispatch function
    value = globals()[name](*args)

    if value:
        # return to vim by let
        value = to_vim(value)
        command = f'let {ret_name} = {value}'
        try:
            vim.command(command)
        except vim.error as e:
            print('error', command)
            print('error', e)

def quote(src):
    return "'" + src.replace("'", "''") + "'"

def to_vim(o):
    with io.StringIO() as output:

        def traverse(o):
            if isinstance(o, dict):
                output.write('{')
                for k, v in o.items():
                    traverse(k) # require string
                    output.write(':')
                    traverse(v)
                    output.write(',')
                output.write('}')

            elif isinstance(o, list):
                output.write('[')
                for i, v in enumerate(o):
                    traverse(v)
                    output.write(',')
                output.write(']')

            else:
                # primitives
                if isinstance(o, bool):
                    if o:
                        output.write('1')
                    else:
                        output.write('0')
                if not o:
                    output.write('0')
                elif isinstance(o, (int, float)):
                    output.write(str(o))
                else:
                    # quote string
                    output.write(f"{quote(o)}")


        traverse(o)
        value = output.getvalue()
        return value
_EOF_

function! Py3Call(name, ...)
    py3 py_dispatch(vim.eval('a:name'), 'l:ret', vim.eval('a:000'))
    if exists('l:ret')
        return l:ret
    endif
endfunction

