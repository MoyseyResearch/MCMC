function chains = geneticStep(chains,data)

  % the elite percentage are the highest-fitness members of the population
  % this percentage is unmodified by the genetic algorithm
  elite = 0.40;

  % first, sort chains by 'fitness' or error
  unsorted=0;
  while ( unsorted<length(chains)-1 )
    unsorted=0;
    for i = 1:length(chains)-1
      if chains{i}.cycles{end}.accepted.error>chains{i+1}.cycles{end}.accepted.error
        temp = chains{i+1};
        chains{i+1} = chains{i};
        chains{i}   = temp;
      else
        unsorted=unsorted+1;
      end
    end
  end

  % crossover phase; each non-elite member has a chance of having its parameters overwritten
  % by the parameters of a lower-error chain
  for i = ceil(elite*length(chains)):length(chains)
  for j = 1:length(chains)
    if i~=j
      for k = 1:length(chains{i}.cycles{end}.accepted.params)
        if log(chains{j}.cycles{end}.accepted.error-chains{i}.cycles{end}.accepted.error) > rand & rand<0.3
          chains{j}.cycles{end}.accepted.params{k} = chains{i}.cycles{end}.accepted.params{k};
        end
      end
    end
  end
  end
