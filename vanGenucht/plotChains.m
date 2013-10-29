function [] = plotChains(chains,filename)

  for j = 1:length(chains{1}.cycles)
    for i = 1:length(chains)
      x(i,j)=chains{i}.cycles{j}.accepted.params{2};
      y(i,j)=chains{i}.cycles{j}.accepted.params{3};
      z(i,j)=chains{i}.cycles{j}.accepted.params{4};
      e(i,j)=chains{i}.cycles{j}.accepted.error;
    end
  end

  figure;

  subplot(4,2,1);
  hold on;
  for i = 1:length(chains);
    plot(x(i,:));
  end
  xlim([0,15000]);
  ylabel('Srw');

  subplot(4,2,2);
  if size(x,2)>1000
    xhist = x(:,end-1000:end);
  else
    xhist = x(:,:);
  end
  xhist = xhist(:);
  hist(xhist,50);
  set(gca,'xlim',[0 0.25]);
  ylabel('Srw');

  subplot(4,2,3);
  hold on;
  for i = 1:length(chains);
    plot(y(i,:));
  end
  xlim([0,15000]);
  ylabel('alpha');

  subplot(4,2,4);
  if size(y,2)>1000
    yhist = y(:,end-1000:end);
  else
    yhist = y(:,:);
  end
  yhist = yhist(:);
  hist(yhist,50);
  set(gca,'xlim',[0 1000]);
  ylabel('alpha');

  subplot(4,2,5);
  hold on;
  for i = 1:length(chains);
    plot(z(i,:));
  end
  xlim([0,15000]);
  ylabel('n');

  subplot(4,2,6);
  if size(z,2)>1000
    zhist = z(:,end-1000:end);
  else
    zhist = z(:,:);
  end
  zhist = zhist(:);
  hist(zhist,50);
  set(gca,'xlim',[0 20]);
  ylabel('n');

  subplot(4,2,7);
  hold on;
  for i = 1:length(chains);
    loglog(e(i,:));
  end
  xlim([10,15000]);
  xlabel('Iterations');
  ylabel('Log Error');

  subplot(4,2,8);
  hold on;
  for i = 1:length(chains)
    swr = chains{i}.cycles{end}.accepted.params{2};
    chains{i}.cycles{end}.accepted.params{1} = linspace(swr,1,1000);
    chains{i}.cycles{end}.proposed = chains{i}.cycles{end}.accepted;
  end
  z=mcmcForward(chains);
  for i = 1:length(chains);
    swr = chains{i}.cycles{end}.accepted.params{2};
    plot(linspace(swr,1,1000),z{i},'linewidth',1);
  end
  sw = [0.99 0.97 0.86 0.65 0.42 0.30 0.23 0.21];
  hc = [20 30 35 40 50 60 77 98];
  plot(sw,hc,'ro','MarkerFaceColor','r',s=50);
  xlabel('Sw');
  ylabel('Hc');
  xlim([0.1,1.1]);
  ylim([0,135]);

  print( '-dpng','-r100', filename );
  close all

  mean(xhist), var(xhist)
  mean(yhist), var(yhist)
  mean(zhist), var(zhist)
