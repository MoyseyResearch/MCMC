% number of chains
nc = 50;

% generates synthetic data or reads in measured data
data = mcmcData;

% sets up chains structure
chains = mcmcInitial(nc);
z = mcmcForward(chains);
for i = 1:length(chains)
  chains{i}.cycles{1}.proposed.data  = z{i};
  chains{i}.cycles{1}.proposed.error = mcmcError(z{i},data);
  chains{i}.cycles{1}.accepted = chains{i}.cycles{1}.proposed;
end

for c1 = 1:3
for c2 = 1:500
  chains = mcmcStep(chains);
  z = mcmcForward(chains);
  for i = 1:length(chains)
    j=length(chains{i}.cycles);
    chains{i}.cycles{j}.proposed.data  = z{i};
    chains{i}.cycles{j}.proposed.error = mcmcError(z{i},data);
    if chains{i}.cycles{j}.proposed.error < chains{i}.cycles{j-1}.accepted.error
      chains{i}.cycles{j}.accepted = chains{i}.cycles{j}.proposed;
      chains{i}.cycles{j}.rejected = chains{i}.cycles{j-1}.accepted;
    elseif log(chains{i}.cycles{j-1}.accepted.error-chains{i}.cycles{j}.proposed.error)<rand
      chains{i}.cycles{j}.accepted = chains{i}.cycles{j}.proposed;
      chains{i}.cycles{j}.rejected = chains{i}.cycles{j-1}.accepted;
    else
      chains{i}.cycles{j}.accepted = chains{i}.cycles{j-1}.accepted;
      chains{i}.cycles{j}.rejected = chains{i}.cycles{j}.proposed;
    end
  end
end
chains = geneticStep(chains);
end

plotChains(chains,'mcmc_rosenbrock.eps')
