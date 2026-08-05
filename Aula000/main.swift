print("Olá, Mundo!")

func imprimirTaboada(num: Int) -> Void {
    for i in 1...10 {
        print("\(num) * \(i) = \(num * i)")
    }
}

imprimirTaboada(num: 7)
