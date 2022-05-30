namespace Quantum.QSharpApplication1 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    // Устанавливает кубит в нужное состояние (сделал для разминки)
    operation Set (desired: Result, q1: Qubit) : () {
        body {
            let current = M(q1);
            if (desired != current) { 
                X(q1);
			}
        }
    }
    

    // Задание 3.1  
    operation Super(qs: Qubit[], bits: Bool[]) : () {
        body {   
            // Предварительно зануляем кубиты
            for (q in qs) {
                Set(Zero, q);
            }

            H(qs[0]);
            for (i in 1..Length(qs) - 1) {
                 if (bits[i]) {
                     CNOT(qs[0], qs[i]); 
                 } 
            }                  
        }
    }

    // Задание 3.2
    operation Determine1(qs: Qubit[]) : Int {
        body {   
            mutable ones = 0;
            for (q in qs) {
                if (M(q) == One) { 
                    set ones = ones + 1; 
                }
            }

            if (ones == 1) {
                return 1;
            } 
            else {
                return 0;
            }                
        }
    }

    // Задание 3.3
    // в условии указано ровно два кубита, поэтому разумнее передавать их как два параметра, а не как массив
    operation Determine2(q1: Qubit, q2: Qubit) : Int {
        if (M(q1) == Zero) {
            if (M(q2) == Zero) { return 0; } 
            else { return 1; }
        }
        else {
             if (M(q2) == Zero) { return 2; } 
             else { return 3; }
        }
    }

    // Задание 3.4
    // Оракул для f(x) = (bx) mod 2
    operation Oracle(x : Qubit[], y : Qubit, b : Int[]) : () {
        body {
            for (i in 0..Length(x) - 1) {
                if (b[i] == 1) {
                    CNOT(x[i], y);
                } 
                else {
                    Set(Zero, y);
                }
            }
        }
    } 
}
