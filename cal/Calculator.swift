//
//  Calculator.swift
//  cal
//
//  Created by bb on 2021/10/7.
//

import UIKit

var memory_num : Double  = 0

class Calculator: NSObject {
    enum Operation{
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
    }
    

    
    var operations = [
        "+": Operation.BinaryOp{
            (op1,op2) in
            return op1 + op2
        },
        "-": Operation.BinaryOp{
            (op1,op2) in
            return op1 - op2
        },
        "x": Operation.BinaryOp{
            (op1,op2) in
            return op1 * op2
        },
        "/": Operation.BinaryOp{
            (op1,op2) in
            return op1 / op2
        },
        "=": Operation.EqualOp,
        ")": Operation.EqualOp,
        "%": Operation.UnaryOp{
            op in
            return op/100.0
        },
        "+/-": Operation.UnaryOp{
            op in
            return -op
        },
        "C": Operation.UnaryOp{
            _ in
            return 0
        },
        "x!":Operation.UnaryOp{
            op in
            var res:Double = 1
            if op == 0{
                return 0
            }
            var n = op
            while(n > 0){
                res *= n
                n -= 1
            }
            return res
        },
        "sin":Operation.UnaryOp{
            op in
            return sin(op)
        },
        "cos":Operation.UnaryOp{
            op in
            return cos(op)
        },
        "tan":Operation.UnaryOp{
            op in
            return tan(op)
        },
        "sinh":Operation.UnaryOp{
            op in
            return sinh(op)
        },
        "cosh":Operation.UnaryOp{
            op in
            return cosh(op)
        },
        "tanh":Operation.UnaryOp{
            op in
            return tanh(op)
        },
        "e":Operation.Constant(exp(1)),
        "pi":Operation.Constant(3.141592653589793),
        "Rand":Operation.UnaryOp{
            _ in
            return drand48();
        },
        "EE":Operation.BinaryOp{
            op1,op2 in
            var sum = op1;
            var n = op2;
            while(n > 0){
                sum *= 10;
                n -= 1;
            }
            return sum;
        },
        "ln":Operation.UnaryOp{
            op in
            return log(op)/log(exp(1))
        },
        "mr":Operation.UnaryOp{
            op in
            return memory_num
        },
        "m+":Operation.UnaryOp{
            op in
            memory_num += op
            return op
        },
        "m-":Operation.UnaryOp{
            op in
            memory_num -= op
            return op
        },
        "mc":Operation.UnaryOp{
            op in
            memory_num = 0
            return op
        },
        "1/x":Operation.UnaryOp{
            op in
            return 1/op;
        }
    ]
    
    struct Intermediate{
        var firstOp : Double
        var  waitingOperation:(Double,Double) -> Double
    }
    
    var pendingOp: Intermediate? = nil
    var pendingOp1: Intermediate? = nil
    func performOperation(operation: String,operand: Double) ->Double?{
        if let op = operations[operation]{
            switch op{
            case .BinaryOp(let function):
                pendingOp = Intermediate(firstOp: operand, waitingOperation: function)
                return nil
            case .UnaryOp(let function):
                return function(operand)
            case .EqualOp:
                return pendingOp!.waitingOperation(pendingOp!.firstOp,operand)
            case .Constant(let value):
                return value
            }
        }
        return nil
    }
    
    
    
}
