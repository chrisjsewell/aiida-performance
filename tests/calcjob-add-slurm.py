import sys
if len(sys.argv) > 1 and sys.argv[1] == "--pre":
    pass
else:
    from aiida import orm
    from aiida.engine import run

    code = orm.load_code(label='add-slurm')
    builder = code.get_builder()
    builder.x = orm.Int(1)
    builder.y = orm.Int(2)

    for i in range(4):
        run(builder)
