from random import randrange

class Generator(BaseGenerator):
    def data(self):
        unit_cost = randrange(5, 13)
        unit_revenue = unit_cost + randrange(2, 7)
        fixed_cost = 1000 * randrange(15, 51)
        production = 100 * randrange(70, 170)
        margin = unit_revenue - unit_cost
        profit = margin * production - fixed_cost
        return {
            'unit_cost': unit_cost,
            'unit_revenue': unit_revenue,
            'fixed_cost': fixed_cost,
            'production': production,
            'margin': margin,
            'profit': profit,
        }
