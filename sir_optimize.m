function p_opt = sir_optimize(Idat, Ddat, tspan, y0, p0)

p_opt = fminsearch(@sir_disc_nested, p0);

    function disc = sir_disc_nested(p)
        disc = sir_discrepancy(p, Idat, Ddat, tspan, y0);
    end

end