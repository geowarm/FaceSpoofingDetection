function [acc,  HTER ] = getHTER( predict_label,  testLabel, numFrames)

% voting
[resultPredictLabel, result, acc] = votingUseLabel(testLabel, predict_label);
testLabelArrange = zeros( size(testLabel, 1) / numFrames , 1 );
testLabelArrangeIdx = 1;

for i = 1 : numFrames :size(testLabel, 1),
    testLabelArrange(testLabelArrangeIdx) = testLabel(i);
    testLabelArrangeIdx = testLabelArrangeIdx + 1;
end

TP = sum(resultPredictLabel == 1 & testLabelArrange == 1);
FP = sum(resultPredictLabel == 1 & testLabelArrange == -1);
TN = sum(resultPredictLabel == -1 & testLabelArrange == -1);
FN = sum(resultPredictLabel == -1 & testLabelArrange == 1);
TPR = TP/(TP+FN);
FPR = FP/(FP+TN); % FAR
FRR = FN/(TP+FN);
FAR = FP/(TN+FP);

HTER = (FRR + FAR) / 2 * 100;

end

