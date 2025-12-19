% ILIAS KOROMPILIS

%% Split - Data Preprocessing
function [trainD,checkD,testD]=split_scale(data,pre)

    idx=randperm(length(data));
    trainIdx=idx(1:round(length(idx)*0.6));
    checkIdx=idx(round(length(idx)*0.6)+1:round(length(idx)*0.8));
    testIdx=idx(round(length(idx)*0.8)+1:end);
    trainX=data(trainIdx,1:end-1);
    checkX=data(checkIdx,1:end-1);
    testX=data(testIdx,1:end-1);
    switch pre
        case 1                      % Normalization to unit hypercube
            xmin=min(trainX,[],1);
            xmax=max(trainX,[],1);
            trainX=(trainX-repmat(xmin,[length(trainX) 1]))./(repmat(xmax,[length(trainX) 1])-repmat(xmin,[length(trainX) 1]));
            checkX=(checkX-repmat(xmin,[length(checkX) 1]))./(repmat(xmax,[length(checkX) 1])-repmat(xmin,[length(checkX) 1]));
            testX=(testX-repmat(xmin,[length(testX) 1]))./(repmat(xmax,[length(testX) 1])-repmat(xmin,[length(testX) 1]));
        case 2                     % Standardization to zero mean - unit variance
            mu=mean(data,1);
            sig=std(data,1);
            trainX=(trainX-repmat(mu,[length(trainX) 1]))./repmat(sig,[length(trainX) 1]);
            checkX=(trainX-repmat(mu,[length(checkX) 1]))./repmat(sig,[length(checkX) 1]);
            testX=(trainX-repmat(mu,[length(testX) 1]))./repmat(sig,[length(testX) 1]);
        otherwise
            disp('Not appropriate choice!')
    end
    trainD=[trainX data(trainIdx,end)];
    checkD=[checkX data(checkIdx,end)];
    testD=[testX data(testIdx,end)];
end
