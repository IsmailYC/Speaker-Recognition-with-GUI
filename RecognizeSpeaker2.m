function [speaker,best_score]=RecognizeSpeaker2(net,directory,persons,features)

[audio,fs]= audioread(directory);

audio= TreatAudio(audio);
data= cell(2,1);
feature= cell(3,1);
if(features(1,1))
    feature{1,1}= melfcc(audio,fs);
    if(features(1,2))
        feature{2,1}= deltas(feature{1,1});
        if(features(1,3))
            feature{3,1}= deltas(deltas(feature{1,1},5),5);
        end;
    end;
end;
featurematrix= cell2mat(feature);
data{1,1}= featurematrix;
if(features(2,1))
    feature{1,1}= rastaplp(audio,fs,0,12);
    if(features(2,2))
        feature{2,1}= deltas(feature{1,1});
        if(features(2,3))
            feature{3,1}= deltas(deltas(feature{1,1},5),5);
        end;
    end;
end;
featurematrix= cell2mat(feature);
data{2,1}=featurematrix;
scores= net(data);
scores= scores{1,1};
[~,m]= size(scores);
scores= sum(scores,2);
scores= scores/m;
best_score= max(scores);
speaker= persons(1,find(scores==best_score));
disp([num2str(best_score),' for ',num2str(speaker)]);