class A {
 method m2() = 2
 method m4() = self.m5()
 method m5() = 5
 method m6() = 10
}

class B inherits A {
 override method m2() = self.m3()
 method m3() = 8
 override method m4() = 1 + super()
}

class C inherits B {
 method m1() = self.m2()
 override method m3() = self.m4()
 override method m5() = 9
 method m7() = 1 + self.m6()
}

class D inherits C {
 override method m3() = 26
 override method m4() = 41
 override method m5() = 6
}

// ¿Cuál es la respuesta de new C().m1()

// Reglas:
//
// Si recibo un mensaje X:
//  |
//  └──> Voy a mi clase y
//             └──> le pido el método X   <────────────────────────┐───┐
//                    ├──> Si lo tiene, lo ejecuto                 |   |
//                    └──> Si no lo tiene, voy a su superclase y ──┘   |
//                                                                     |
// Si encuentro un super:                                              |
//  |                                                                  |
//  └──> Voy a la superclase de dónde estoy buscando el método X y ────┘
