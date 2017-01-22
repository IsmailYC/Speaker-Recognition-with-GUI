function [speaker,best_score,scores]=RecognizeSpeaker(net,directory,fw,fi,persons,features,count)

[audio,fs]= audioread(directory);

audio= TreatAudio(audio);
data= cell(count,1);
featureCount=1;

if(features(1,1))
    feature= cell(3,1);
    feature{1,1}= melfcc(audio,fs,'wintime', fw/1000, 'hoptime', fi/1000);
    if(features(1,2))
        feature{2,1}= deltas(feature{1,1});
        if(features(1,3))
            feature{3,1}= deltas(deltas(feature{1,1},5),5);
        end;
    end;
    featurematrix= cell2mat(feature);
    data{featureCount,1}= featurematrix;
    featureCount= featureCount+1;
end;

if(features(2,1))
    feature= cell(3,1);
    feature{1,1}= rastaplp(audio,fs,0,12);
    if(features(2,2))
        feature{2,1}= deltas(feature{1,1});
        if(features(2,3))
            feature{3,1}= deltas(deltas(feature{1,1},5),5);
        end;
    end;
    featurematrix= cell2mat(feature);
    data{featureCount,1}=featurematrix;
    featureCount= featureCount+1;
end;

if(features(3,1))
    if(features(3,2))
        if(features(3,3))
            feature= melcepst(audio, fs, 'dD', 12, floor(3*log(fs)), fw*fs/1000, fi*fs/1000)';
        else
            feature= melcepst(audio, fs, 'd', 12, floor(3*log(fs)), fw*fs/1000, fi*fs/1000)';
        end;
    else
        feature= melcepst(audio, fs, 12, floor(3*log(fs)), fw*fs/1000, fi*fs/1000)';
    end;
    data{featureCount,1}= feature;
    featureCount= featureCount+1;
end;

if(features(4,1))
    feature= proclpc(audio, fs, 13, fi, fw);
    data{featureCount,1}= feature;
end;
if(count==1)
    data= cell2mat(data);
end;
scores= net(data);
if(count>1)
    scores= scores{1,1};
end;
[~,m]= size(scores);
scores= sum(scores,2);
scores= scores/m;
best_score= max(scores);
speaker= persons(1,find(scores==best_score));