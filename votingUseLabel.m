function [resultPredictLabel, result, accuracy ] = votingUseLabel( oriLabel, rstLabel )

%% voting
% oriLabel = MC_TestGRLabel;
% rstLabel = MC_predict_label_GR;
numFrames = 30;
numObj = size(oriLabel, 1) / numFrames;

result = zeros(numObj, 1);
resultPredictLabel = zeros(numObj, 1);



% 50개씩 original label과 predicted label을 비교해서 제대로 검사 했는지 확인
for i = 1 : numObj,
    numCorrect = 0;
    numFalse = 0;
    sumLabel = 0;
    for j = 1 : numFrames,
        if oriLabel((i-1)*numFrames+j) == rstLabel((i-1)*numFrames+j),
            numCorrect = numCorrect + 1;            
        else
            numFalse = numFalse + 1;
        end
        
        % 50개 중 많이 decesion 된 label을 구하자
        sumLabel = sumLabel + rstLabel((i-1)*numFrames+j);
        
    end
    % ground truth와 맞으면 1, 아니면 0
    if numCorrect >= numFalse,
        result(i) = 1;
    else
        result(i) = 0;
    end
    % 현재 predict 된 label을 적자
    if sumLabel > 0
        resultPredictLabel(i) = 1;
    else
        resultPredictLabel(i) = -1;
    end
    
end

accuracy = double(sum(result) * 100) / numObj;

end

