% developed by Baihan Lin, Apr 2014
% Ebola Modeling
% Data Fitting

function p_opt = sir_popsize_optimize(Idat, Ddat, tspan, d0)

p_opt = fminsearch(@sir_disc_nested, d0);

    function disc = sir_disc_nested(d0)
        disc = sir_popsize_discrepancy(d0, Idat, Ddat, tspan);
    end

end