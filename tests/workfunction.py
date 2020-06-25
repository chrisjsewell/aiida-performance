import sys
if len(sys.argv) > 1 and sys.argv[1] == "--pre":
    pass
else:
    from aiida import orm
    from aiida.engine import calcfunction

    @calcfunction
    def multiply(x, y):
        return x * y

    in_x = orm.Int(1)
    in_y = orm.Int(2)

    for i in range(200):
        multiply(in_x, in_y)
