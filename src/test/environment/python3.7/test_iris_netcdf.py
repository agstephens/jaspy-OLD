
def test_iris_cf_units_compatibility():
    import cf_units
    from iris.time import PartialDateTime as PDT
    tu = cf_units.Unit('hours since 1970-01-01 0:0:0', calendar='360_day')
    pdt1 = PDT(1970, 2, 1, 0, 0, 0)
    tu.date2num(pdt1)

