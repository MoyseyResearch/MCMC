function chains = mcmcStep(chains)

  % the mcmcStep function takes in the current chain structure and adds a
  % new cycle to the end of each chain, each with a set of parameters that
  % somehow follows from the last cycle. This could simply mean perturbing
  % values by a set amount, or could involve a varying step size. Since you
  % already have the entire chain structure handy inside the scope of this 
  % function, you can easily find the errors and variances of the chains

  for i = 1:length(chains)

    j = length(chains{i}.cycles);
    paramsOld = chains{i}.cycles{j}.accepted.params;

    paramsNew{1} = paramsOld{1} + randn *0.75;
    paramsNew{2} = paramsOld{2} + randn *0.50;

    chains{i}.cycles{j+1}.proposed.params = paramsNew;

  end
