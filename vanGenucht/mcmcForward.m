function dataPredicted = mcmcForward(chains)

  % the mcmcForward function should take in the current chain structure,
  % and return a data structure. The output data could be a single number, 
  % a time-series, a 2D array, or just about anything that can fit in a 
  % cell array. It will also need to be compatible with the mcmcError function

  for i = 1:length(chains)
    j   = length(chains{i}.cycles);
    sw  = chains{i}.cycles{j}.proposed.params{1};
    swr = chains{i}.cycles{j}.proposed.params{2};
    anw = chains{i}.cycles{j}.proposed.params{3};
    n   = chains{i}.cycles{j}.proposed.params{4};
    rhow = 1000;  % kg/m^3
    g = 9.81;     % m/s^2
    m = 1-1/n;    % unitless
    dataPredicted{i} = (rhow*g/anw) * (((sw-swr)/(1-swr)).^(-1/m)-1).^(1/n);

  end
