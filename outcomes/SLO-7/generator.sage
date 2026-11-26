class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        t=var("t")
        w=var("w")
        f="f"
        g="g"
        h="h"
        k="k"

        listvars=[x,y,t,w]
        shuffle(listvars)

        functionnames=[f,g,h,k]
        shuffle(functionnames)

        polynomial=sum([randrange(1,6)*choice([-1,1])*x^i for i in range(3)])
        fs = [1/choice([-1,1])*randrange(1,10)*sqrt((polynomial))]

        primes = [2,3,5,7]
        shuffle(primes)
        coeff=choice([-1,1])*randrange(2,10)
        fs.append(
            coeff*sqrt((x^(primes[0]/primes[1])))
        )
        fs.append(
            coeff*(polynomial)^(primes[0]/primes[1])
        )
        
        fs.append(sum([
            randrange(1,6)*choice([-1,1])*x^(choice([2..5])),
            randrange(1,6)*choice([-1,1])*x,
            randrange(1,6)*choice([-1,1]),
        ])^randrange(3,7))

        functions = [
            {
                "f":fs[i](x=listvars[i]),
                "dfdx":fs[i].diff()(x=listvars[i]),
                "fn": functionnames[i], 
                "v": listvars[i],
            }
            for i in range(len(fs))
        ]
        shuffle(functions)


        return {
        "functions": functions,
        }