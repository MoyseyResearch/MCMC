function dataPredicted = mcmcForward(chains)

  % the mcmcForward function should take in the current chain structure,
  % and return a data structure. The output data could be a single number, 
  % a time-series, a 2D array, or just about anything that can fit in a 
  % cell array. It will also need to be compatible with the mcmcError function

  for i = 1:length(chains)
    j = length(chains{i}.cycles);
    x(i) = chains{i}.cycles{j}.proposed.params{1};
    y(i) = chains{i}.cycles{j}.proposed.params{2};
    dataPredicted{i} = 1 - x(i)^2 + 100*( y(i)-x(i)^2 )^2;
  end
