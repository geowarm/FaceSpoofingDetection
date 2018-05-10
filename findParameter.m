function [ resultAuto ] = findParameter( TrainLabel, TrainData, TestLabel, TestData, numFrames, Range )
% TrainLabel = MSU_TrainLabel;
% TrainData = MSU_TrainData;
% TestLabel = MSU_TestLabel;
% TestData = MSU_TestData;

% Range = 'U'
% accuracy 가 가장 높은 parameter을 찾아주는 함수
% A: 전체 범위, U: 상위 반, D: 하위 반
if Range == 'A',
    [C,G] = meshgrid(-12:2:12, -14:2:6);
elseif Range == 'U',
    [C,G] = meshgrid(-12:2:12, -14:2:-4);
elseif Range == 'D',
    [C,G] = meshgrid(-12:2:12, -4:2:6);
end

resultAuto = zeros(numel(C), 7);
curMaxAcc = 0;
curMaxCnt = 0;
for i=1:numel(C)
    
    Model_Auto = svmtrain(TrainLabel, TrainData, sprintf('-c %f -g %f -t 2', 2^C(i), 2^G(i)) );
    [Predict_label_Auto, Accuracy_Auto, Dec_Values_Auto] = svmpredict(TestLabel, TestData, Model_Auto);
    
  %  if Accuracy_Auto(1,1) >= curMaxAcc,
        curMaxCnt = curMaxCnt +1;
        curMaxAcc = Accuracy_Auto(1,1);
        resultAuto(curMaxCnt, 1) = Accuracy_Auto(1,1);
        resultAuto(curMaxCnt, 2) = C(i);
        resultAuto(curMaxCnt, 3) = G(i);
        resultAuto(curMaxCnt, 4) = 2^C(i);
        resultAuto(curMaxCnt, 5) = 2^G(i);
        [acc, HTER] = getHTER( Predict_label_Auto,  TestLabel, numFrames);
        resultAuto(curMaxCnt, 6) = acc;
        resultAuto(curMaxCnt, 7) = HTER;
        
    if Accuracy_Auto(1,1) >= curMaxAcc,
        fprintf('i: %d, Accuracy: %d, C(i): %d, G(i): %d, 2^C(i): %d, 2^G(i): %d ,acc: %d, HTER: %d \n',i, Accuracy_Auto(1,1), C(i), G(i), 2^C(i), 2^G(i), acc, HTER );
    end
    fprintf('i: %d \n', i);
end


end

