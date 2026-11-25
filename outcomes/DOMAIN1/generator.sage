"""CheckIt / SageMath generator for rational-function domains."""
from random import choice, randrange


class Generator(BaseGenerator):
    def data(self):
        # Distinct integer zeros; occasionally reproduce the original roots (-4, 1).
        r1 = choice([-6, -5, -4, -3, -2, -1])
        r2 = choice([1, 2, 3, 4, 5, 6])
        a = randrange(1, 7)
        leading = choice([1, 2, 3])
        b = -leading * (r1 + r2)
        c = leading * r1 * r2
        # Preformat the polynomial so negative coefficients do not create '+ -'.
        def term(coef, power):
            if coef == 0:
                return ''
            sign = '+' if coef > 0 else '-'
            mag = abs(coef)
            body = ('' if mag == 1 and power else str(mag)) + ('x' if power == 1 else ('x^2' if power == 2 else ''))
            return ' ' + sign + ' ' + body
        denominator = str(leading) + 'x^2' + term(b, 1) + term(c, 0)
        return {
            'numerator': a,
            'denominator': denominator,
            'factored_denominator': r'{}(x-({}))(x-({}))'.format(leading, r1, r2),
            'root_left': r1,
            'root_right': r2,
            'domain': r'(-\infty,{})\cup({},{})\cup({},\infty)'.format(r1, r1, r2, r2),
        }
