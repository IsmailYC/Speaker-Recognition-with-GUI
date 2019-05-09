function [data, target, fs]= PrepareData1(directory,folder,file,fw,fi,persons, tracks, features)
[~,fs]=audioread([directory,'\1\Track (1).wav']);
[~, mPersons]= size(persons);
[~, mTracks]= size(tracks);
data= cell(1,mPersons);
target= cell(1,mPersons);
for i=1:mPersons
    audio= cell(mTracks,1);
    for j=1:mTracks
        audio{j,1}= audioread([directory,'\',num2str(persons(1,i)),'\Track (',num2str(tracks(1,j)),').wav']);
    end;
    audio= cell2mat(audio);
    
	audio= TreatAudio(audio);
    
	feature= cell(3,1);
	if(features(1,1))
		feature{1,1}= melfcc(audio,fs,'wintime', fw/1000, 'hoptime', fi/1000);
		if(features(1,2))
			feature{2,1}= deltas(feature{1,1});
			if(features(1,3))
				feature{3,1}= deltas(deltas(feature{1,1},5),5);
			end;
		end;
	elseif(features(2,1))
		feature{1,1}= rastaplp(audio,fs,0,12);
		if(features(2,2))
			feature{2,1}= deltas(feature{1,1});
			if(features(2,3))
				feature{3,1}= deltas(deltas(feature{1,1},5),5);
			end;
		end;
    elseif(features(3,1))
        if(features(3,2))
            if(features(3,3))
                feature{1,1}= melcepst(audio, fs, 'dD', 12, floor(3*log(fs)), fw*fs/1000, fi*fs/1000);
            else
                feature{1,1}= melcepst(audio, fs, 'd', 12, floor(3*log(fs)), fw*fs/1000, fi*fs/1000);
            end;
        else
            feature{1,1}= melcepst(audio, fs, 12, floor(3*log(fs)), fw*fs/1000, fi*fs/1000);
        end;
    elseif(features(4,1))
        feature{1,1}= proclpc(audio, fs, 13, fi, fw);
    end;
    
	featurematrix= cell2mat(feature);
    [~,n]= size(featurematrix);
    data{1,i}= featurematrix;
    class= zeros(mPersons,1);
    class(persons(1,i),1)=1;
    target{1,i}= repmat(class,1 , n);
end;
data= cell2mat(data);
target= cell2mat(target);