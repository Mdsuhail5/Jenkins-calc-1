from app import add, sub

def test_add():
    assert add(5,3)==8
    
def test_sub():
    assert sub(5,3)==2