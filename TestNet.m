function [accuracy,result]= TestNet(net,directory,fw,fi,trainPersons,testPersons,testTracks,selectedFeatures,count)
[~,mTrainPersons]= size(trainPersons);
[~, mTestPersons]= size(testPersons);
[~, mTracks]= size(testTracks);
result= zeros(mTrainPersons,mTestPersons*mTracks);
accuracy=0;
for i=1:mTestPersons
    for j=1:mTracks
        [speaker,~,scores]= RecognizeSpeaker(net,[directory,'\',num2str(testPersons(1,i)),'\Track (',num2str(testTracks(1,j)),').wav'],fw,fi,trainPersons,selectedFeatures,count);
        result(:,(i-1)*mTracks+j)= scores;
        if(speaker==testPersons(1,i))
            accuracy= accuracy+1;
        end;
    end;
end;
accuracy= accuracy/mTestPersons/mTracks;
accuracy= accuracy*100;