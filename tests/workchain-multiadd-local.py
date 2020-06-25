import sys
if len(sys.argv) > 1 and sys.argv[1] == "--pre":
    pass
else:
    from aiida import orm, plugins
    from aiida.engine import run

    MultiplyAddWorkChain = plugins.WorkflowFactory('arithmetic.multiply_add')

    builder = MultiplyAddWorkChain.get_builder()
    builder.code = orm.load_code(label='add')
    builder.x = orm.Int(2)
    builder.y = orm.Int(3)
    builder.z = orm.Int(5)

    for i in range(20):
        run(builder)
