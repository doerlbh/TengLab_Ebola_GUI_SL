% developed by Baihan Lin, Apr 2014
% Ebola Modeling
% Data Fitting

function p_opt = seir_optimize(Idat, Ddat, tspan, y0, p0)

p_opt = fminsearch(@seir_disc_nested, p0);

    function disc = seir_disc_nested(p)
        disc = seir_discrepancy(p, Idat, Ddat, tspan, y0);
    end

end