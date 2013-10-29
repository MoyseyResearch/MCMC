function chains = mcmcInitial(nc)

  % the mcmcInitial function should output the initial chain structure,
  % with the first set of proposed parameters

  for i = 1:nc
    data = load('vanGenuchten1.csv');
    chains{i}.cycles{1}.proposed.params{1} = data(:,1);
    chains{i}.cycles{1}.proposed.params{2} = rand*min(data(:,1));		% swr
    chains{i}.cycles{1}.proposed.params{3} = 1000*rand;				% anw
    chains{i}.cycles{1}.proposed.params{4} = 1+10*rand;				% n
  end
