function chains = mcmcInitial(nc)

  % the mcmcInitial function should output the initial chain structure,
  % with the first set of proposed parameters

  for i = 1:nc
    chains{i}.cycles{1}.proposed.params{1} = 100*randn;
    chains{i}.cycles{1}.proposed.params{2} = 100*randn;
  end
