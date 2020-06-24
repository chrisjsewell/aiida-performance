import sys
if len(sys.argv) > 1 and sys.argv[1] == "--pre":
    pass
else:
    from aiida import orm

    for i in range(1000):
        orm.Data().store()
