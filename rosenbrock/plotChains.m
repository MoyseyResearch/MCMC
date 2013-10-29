function [] = plotChains(chains,filename)

  for j = 1:length(chains{1}.cycles)
    for i = 1:length(chains)
      x(i,j)=chains{i}.cycles{j}.accepted.params{1};
      y(i,j)=chains{i}.cycles{j}.accepted.params{2};
      e(i,j)=chains{i}.cycles{j}.accepted.error;
    end
  end

  size(x)

  figure;

  subplot(3,2,1);
  hold on;
  for i = 1:length(chains); plot(x(i,:)); end

  subplot(3,2,2); hist(x(:),ceil(length(x(:))^0.5) );

  subplot(3,2,3);
  hold on;
  for i = 1:length(chains); plot(y(i,:)); end

  subplot(3,2,4); hist(y(:),ceil(length(y(:))^0.5) );

  subplot(3,2,5);
  hold on;
  for i = 1:length(chains); semilogy(e(i,:)); end

  subplot(3,2,6); hist(e(:),ceil(length(e(:))^0.5) );

  print( '-depsc2', filename );
