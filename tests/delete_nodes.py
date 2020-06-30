import sys
if len(sys.argv) > 1 and sys.argv[1] == "--pre":
    from aiida import orm
    group, _ = orm.Group.objects.get_or_create("delete-nodes")
    group.remove_nodes(group.nodes[:])
    for i in range(1000):
        node = orm.Data()
        node.store()
        group.add_nodes([node])
else:
    from aiida import orm
    from aiida.manage.database.delete.nodes import delete_nodes
    group, _ = orm.Group.objects.get_or_create("delete-nodes")
    delete_nodes([node.pk for node in group.nodes[:]], force=True)
