class Generator(BaseGenerator):
    def data(self):

        x = var("x")
        y = var("y")
        f="f"
        g="g"
        h="h"

        # Function Names
        functionnames=[f,g,h]
        fn = choice(functionnames)

        # Determine Domain [a,b]
        a = randrange(-11,3)
        b = a + randrange(8,11)
        interiors = list(range(a+1,b))
        shuffle(interiors)
        # Determine Range
        outputs = list(range(-4,5))
        shuffle(outputs)

        # Choose if the infinite limit is the left- or right-hand limit or both.
        vert = ["leftinf","rightinf","bothinf","vertleft","vertright"]

        # Choose the description for a removable discontinuity.
        remove = ["limneqval","specfuncval"]

        # Choose the description for a jump discontinuity (some of these could be vertical asymptotes, as well).
        jump = ["leftneqright","jumpspecleft","jumpspecright","jumpspecleftright"]

        # Choose property from each category and pair them with x-values.
        props = [choice(vert),choice(remove),choice(jump)]
        #shuffle(props)

        properties = [
            {props[0]: True,"x":interiors[0],"y1":outputs[0],"y2":outputs[1]},
            {props[1]: True,"x":interiors[1],"y1":outputs[2],"y2":outputs[3]},
            {props[2]: True,"x":interiors[2],"y1":outputs[4],"y2":outputs[5]},
        ]
        ############################
        ### Generate 3 zeros to use in polynomials
        zeros = sample([Integer(i) for i in range(-6, 7) if i != 0], 3)
        ## Construct numerator and denominator with a shared zero
        top1 = expand((x-zeros[0]) * (x-zeros[1]))
        bottom1 = expand((x-zeros[1]) * (x-zeros[2]))
        ## Evaluate the limit at the shared zero
        a1 = zeros[1]
        limf1 = limit(top1/bottom1, x=a1)


        # Plug in the Number
        ####################
        ## 2 zeros on top, 2 zeros on bottom, 5th is where we evaluate the limit
        zeros = sample([i for i in range(-6, 7) if i != 0], 5)
        ## Construct numerator and denominator, no shared zeros
        top2 = expand((x-zeros[0]) * (x-zeros[1]))
        bottom2 = expand((x-zeros[2]) * (x-zeros[3]))
        ## Evaluate somewhere else
        a2 = zeros[4]
        limf2 = limit(top2/bottom2, x=a2)

        # Rationalize
        #############
        ## Choose some values to use that will make this not terrible
        value = choice(range(1,10))
        square = choice(range(1,7))^2
        ## Create numerator and denominator
        exp1 = sqrt(x+square-value) - sqrt(square)
        exp2 = x - value
        ## Shuffle them
        fraction = [exp1, exp2]
        shuffle(fraction)
        ## Construct top and bottom
        top3 = fraction[0]
        bottom3 = fraction[1]
        ## Evaluate at the zero
        a3 = value
        limf3 = limit(top3/bottom3, x=a3)

        # Common Denominator
        ####################
        values = sample([i for i in range(-6, 7) if i != 0], 2)
        frac = 1/values[0]
        top4 = 1/(x - values[1] + values[0]) - frac
        bottom4 = x - values[1]
        a4 = values[1]
        limf4 = limit(top4/bottom4, x=a4)

        limits = [
            {"num":top1,"den":bottom1,"a":a1,"limit":limf1},
            {"num":top2,"den":bottom2,"a":a2,"limit":limf2},
            {"num":top3,"den":bottom3,"a":a3,"limit":limf3},
            {"num":top4,"den":bottom4,"a":a4,"limit":limf4},
        ]

        # remove either ratoinalize (2) or common denominator (3)
        removed = choice([0,1])
        limits.pop(removed)

        lim=sample(limits,2)


        digits = list(range(1,10))
        shuffle(digits)
        xto = [1,x] + [
            var(f"x_{digits[n]}",latex_name=f"x^{n}")
            for n in range(2,7)
        ]
        
        # bigger power on top
        powers = list(range(1,7))
        shuffle(powers)
        powers = powers[:4]
        powers.sort()
        a,b,c,d,e,f = [
            randrange(1,10)*choice([-1,1])
            for _ in range(6)
        ]
        num = sum([
            a*xto[powers[3]],
            b*xto[powers[1]],
            c
        ])
        den = sum([
            d*xto[powers[2]],
            e*xto[powers[0]],
            f
        ])
        frac = num/den
        if (powers[3]-powers[2])%2==0:
            pos_limit = a*d*Infinity
            neg_limit = a*d*Infinity
        else:
            pos_limit = a*d*Infinity
            neg_limit = -a*d*Infinity
                
        limits2 = [
            {
                "frac":frac,
                "pos_limit":pos_limit,
                "neg_limit":neg_limit,
            }
        ]
        
        # bigger power on bottom
        powers = list(range(1,7))
        shuffle(powers)
        powers = powers[:4]
        powers.sort()
        a,b,c,d,e,f = [
            randrange(1,10)*choice([-1,1])
            for _ in range(6)
        ]
        num = sum([
            a*xto[powers[2]],
            b*xto[powers[1]],
            c
        ])
        den = sum([
            d*xto[powers[3]],
            e*xto[powers[0]],
            f
        ])
        frac = num/den
        pos_limit = 0
        neg_limit = 0
        limits2.append(
            {
                "frac":frac,
                "pos_limit":pos_limit,
                "neg_limit":neg_limit,
            }
        )
        
        # same biggest powers
        powers = list(range(1,7))
        shuffle(powers)
        powers = powers[:4]
        powers.sort()
        a,b,c,d,e,f = [
            randrange(1,10)*choice([-1,1])
            for _ in range(6)
        ]
        num = sum([a*xto[powers[2]],b*xto[powers[1]],c])
        den = sum([d*xto[powers[2]], e*xto[powers[0]],f])
        frac = num/den
        pos_limit = a/d
        neg_limit = a/d
        limits2.append(
            {
                "frac":frac,
                "pos_limit":pos_limit,
                "neg_limit":neg_limit,
            }
        )
        
        lim2=sample(limits2,2)
        print(lim2)

        return {
            "fn": fn,
            "a": a,
            "b": b,
            "properties": properties,
            "limits": lim,
            "limits2": lim2,
        }