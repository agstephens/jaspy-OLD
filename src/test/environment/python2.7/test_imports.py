
def test_import_iris():
    import iris
    assert (iris.__version__.count(".") == 2)

def test_import_netCDF4():
    import netCDF4
    assert (netCDF4.__version__.count(".") == 2)

def test_import_netcdftime():
    import netcdftime
    assert (netcdftime.__version__.count(".") == 2)

