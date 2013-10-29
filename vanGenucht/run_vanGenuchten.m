% number of chains
nc = 30;

% generates synthetic data or reads in measured data
data = mcmcData;

% sets up chains structure
chains = mcmcInitial(nc);

z = mcmcForward(chains);
for i = 1:length(chains)
  chains{i}.cycles{1}.proposed.data  = z{i};
  chains{i}.cycles{1}.proposed.error = mcmcError(z{i},data(:,2));
  chains{i}.cycles{1}.accepted = chains{i}.cycles{1}.proposed;
end

chains{1}.cycles{1}.proposed.params;

c3=0;
for c2 = 1:15
for c1 = 1:1000
  tic;
  chains = mcmcStep(chains);
  z = mcmcForward(chains);
  for i = 1:length(chains)
    j=length(chains{i}.cycles);
    chains{i}.cycles{j}.proposed.data  = z{i};
    chains{i}.cycles{j}.proposed.error = mcmcError(z{i},data(:,2));
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
  c3=c3+1;
  disp(sprintf('%i %f',c3,toc));
  if mod(c3,50)==0
    plotChains(chains,sprintf('./frames/mcmc_vanGenuchten_frame_%05d.png',c3));
  end
end
%chains = geneticStep(chains);
end
