function accuracy= TestNet1(net,directory,trainPersons,testPersons,testTracks,selectedFeatures)
[~, mTestPersons]= size(testPersons);
[~, mTracks]= size(testTracks);
accuracy=0;
for i=1:mTestPersons
    for j=1:mTracks
        [speaker,~]= RecognizeSpeaker1(net,[directory,'\',num2str(testPersons(1,i)),'\Track (',num2str(testTracks(1,j)),').wav'],trainPersons,selectedFeatures);
        if(speaker==testPersons(1,i))
            accuracy= accuracy+1;
        end;
    end;
end;
accuracy= accuracy/mTestPersons/mTracks;
accuracy= accuracy*100;
disp(accuracy);