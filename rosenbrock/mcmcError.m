function error = mcmcError(dataPredicted,dataMeasured)

  % the mcmcError function should output a single number that represents the
  % mismatch between the predicted and measured data

  error = dataPredicted - dataMeasured;
