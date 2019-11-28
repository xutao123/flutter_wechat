class A {
  String _name;
  void a() {
    print('fun a => by a');
  }

  void s() {
    print('fun s => by a');
  }
}

///extends和implements的区别：
/// extends可以不用实现所有方法
/// implements必须实现所有方法和成员变量，不管方法是否是abstract(抽象方法不需要abstract来修饰，方法体为空即为抽象方法)
class B implements A {
  @override
  String _name;

  @override
  void a() {
    print('fun a => by b');
  }

  @override
  void s() {
  }
}

class C {
  void a() {
    print('fun a => by c');
  }

  void c() {
    print('fun c => by c');
  }

  void s() {
    print('fun s => by c');
  }
}

class E {
  String e = 'eeee';

  void s() {
    print('fun s => by e');
  }
}

///方法调用时，先以本类中有的方法为准，
/// 如果本类中没有这个方法(extends的子类不算本类)，则从右到左来查找方法
class D extends A with C, E {
  void a() {
    print('fun a => by d');
  }

  void c() {
    print('fun c => by d');
  }
}

/// fun a => by d
/// fun s => by e
/// fun c => by d
///  D is E false
/// fun a => by b
/// B is A true
void show() {
  D d = new D();
  d.a();
  d.s();
  d.c();
  print("D is E ${D is E}");

  B b = B();
  b.a();
  print("B is A ${b is A}");
}
