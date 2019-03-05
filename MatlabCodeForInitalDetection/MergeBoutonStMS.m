function boutonStW = MergeBoutonStMS(boutonStTotal, minDistMS)
boutonStW = cell2mat(boutonStTotal);
boutonStW = DeleteNearPoint(boutonStW, minDistMS);

end

