% developed by Baihan Lin, Apr 2014
% Ebola Modeling
% Data Fitting

function d_opt = sir_ps_optimize(Idat, Ddat, tspan, d0)

p0 = d0(1:2);
y0 = d0(3:5);
p_opt = fminsearch(@sir_disc_nested, p0);

    function disc = sir_p_disc_nested(p)
        disc = sir_discrepancy(p, Idat, Ddat, tspan, y0);
    end

y0_opt = fminsearch(@sir_y0_disc_nested, y0);

    function disc = sir_y0_disc_nested(y)
        disc = sir_discrepancy(p_opt, Idat, Ddat, tspan, y);
%         disc = sir_discrepancy(p0, Idat, Ddat, tspan, y);
    end

pnew_opt = fminsearch(@sir_disc_nested, p_opt);

    function disc = sir_disc_nested(p)
        disc = sir_discrepancy(p, Idat, Ddat, tspan, y0_opt);
    end

d_opt = [pnew_opt, y0_opt];

end