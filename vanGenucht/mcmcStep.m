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

    paramsNew{1} = paramsOld{1};
    paramsNew{2} = paramsOld{2} + randn *0.005;
    paramsNew{3} = paramsOld{3} + randn *1.500;
    paramsNew{4} = paramsOld{4} + randn *0.800;

    while paramsNew{2}>=0.21 || paramsNew{2}<=0
      paramsNew{2} = paramsOld{2} + randn *0.005;
    end
    while paramsNew{3}<=0
      paramsNew{3} = paramsOld{3} + randn *1.500;
    end
    while paramsNew{4}<=1
      paramsNew{4} = paramsOld{4} + randn *0.800;
    end

    chains{i}.cycles{j+1}.proposed.params = paramsNew;

  end
