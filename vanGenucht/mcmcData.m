function data = mcmcData()

  % the mcmcData function outputs the measured data
  % this could be a simple assignment, a call to a text file or excel file, 
  % or a call to an outside function that generates synthetic data and noise

  data = load('vanGenuchten1.csv');
