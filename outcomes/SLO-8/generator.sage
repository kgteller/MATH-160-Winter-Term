class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        p=var("p")
        polynomial=sum([randrange(1,6)*choice([-1,1])*x^i for i in range(choice([4..7]))])
        deriv=[["second",2],["third",3]]
        shuffle(deriv)
        px= randrange(1,6)*choice([-1,1])*x^(choice([1,2]))+randrange(20,80)
        revenue=px*x
        cost_function = sum([randint(1,10)*x^n for n in range(4)])
        marginal_cost = cost_function.diff()
        marginal_revenue=revenue.diff()
        marginal_profit = marginal_revenue - marginal_cost
        sol=solve(p == px, x)
        xp=sol[0].rhs()
        Ed=-p*xp.diff()/xp
        widget = choice([
            "gadget",
            "widget",
            "gizmo",
        ])
        marginal = {
            "price": px,
            "revenue": revenue,
            "marginal_revenue": revenue.diff(),
            "cost_function": cost_function,
            "marginal_cost": marginal_cost,
            "marginal_profit": marginal_profit,
            "widget": widget,
            "Elasticity":Ed.simplify_rational(),
        }
        order=deriv[0][1]
        return {
        "marginal": marginal,
        "f":polynomial,
        "dfdx": polynomial.diff(x,order),
        "diff":deriv[0][0],
        }