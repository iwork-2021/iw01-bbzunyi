//
//  Calculator.swift
//  cal
//
//  Created by bb on 2021/10/7.
//

import UIKit

var memory_num : Double  = 0

class Calculator: NSObject {
    
    var rad : Bool = true
    var _2ndpressed : Bool = false
    var RadCorrect : Double = 1
    enum Operation{
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
    }
    
    func RadorDeg(){
        RadCorrect = (rad) ? 1:180/Double.pi
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
        "÷": Operation.BinaryOp{
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
        "AC": Operation.UnaryOp{
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
        "sin^-1":Operation.UnaryOp{
            op in
            return asin(op)
        },
        "cos^-1":Operation.UnaryOp{
            op in
            return acos(op)
        },
        "tan^-1":Operation.UnaryOp{
            op in
            return atan(op)
        },
        "sinh^-1":Operation.UnaryOp{
            op in
            return asinh(op)
        },
        "cosh^-1":Operation.UnaryOp{
            op in
            return acosh(op)
        },
        "tanh^-1":Operation.UnaryOp{
            op in
            return atanh(op)
        },
        "e":Operation.Constant(exp(1)),
        "π":Operation.Constant(Double.pi),
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
        "logy":Operation.BinaryOp{
            op1,op2 in
            return log(op1)/log(op2)
        },
        "log2":Operation.UnaryOp{
            op in
            return log2(op)
        },
        "log10":Operation.UnaryOp{
            op in
            return log10(op)
        },
        "x^2":Operation.UnaryOp{
            op in
            return op*op
        },
        "x^3":Operation.UnaryOp{
            op in
            return pow(op, 3)
        },
        "x^y":Operation.BinaryOp{
            op1,op2 in
            return pow(op1, op2)
        },
        "y^x":Operation.BinaryOp{
            op1,op2 in
            return pow(op2, op1)
        },
        "2^x":Operation.UnaryOp{
            op in
            return pow(2, op)
        },
        "e^x":Operation.UnaryOp{
            op in
            return exp(op)
        },
        "10^x":Operation.UnaryOp{
            op in
            return pow(10, op)
        },
        "2√x":Operation.UnaryOp{
            op in
            return sqrt(op)
        },
        "3√x":Operation.UnaryOp{
            op in
            return pow(op,1.0/3.0)
        },
        "y√x":Operation.BinaryOp{
            op1,op2 in
            return pow(op1,1.0/op2)
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
        RadorDeg()
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
