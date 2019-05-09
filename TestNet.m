function [accuracy,result]= TestNet(net,directory,fw,fi,trainPersons,testPersons,testTracks,selectedFeatures,count)
[~,mTrainPersons]= size(trainPersons);
[~, mTestPersons]= size(testPersons);
[~, mTracks]= size(testTracks);
result= zeros(mTrainPersons,mTestPersons*mTracks);
accuracy=0;
listOfPersonFolders=ls(directory);
listOfPersonFolders=listOfPersonFolders(3:length(listOfPersonFolders),:);
for i=1:mTestPersons
    listOfAudioFiles=ls([directory,'\',listOfPersonFolders(testPersons(1,i),:)]);
    listOfAudioFiles=listOfAudioFiles(3:length(listOfAudioFiles),:);
    for j=1:mTracks
        [speaker,~,scores]= RecognizeSpeaker(net,[directory,'\',listOfPersonFolders(testPersons(1,i),:),'\',listOfAudioFiles(5*testTracks(1,j),:)],fw,fi,trainPersons,selectedFeatures,count);
        result(:,(i-1)*mTracks+j)= scores;
        if(speaker==testPersons(1,i))
            accuracy= accuracy+1;
        end;
    end;
end;
accuracy= accuracy/mTestPersons/mTracks;
accuracy= accuracy*100;