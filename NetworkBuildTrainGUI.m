function NetworkBuildTrainGUI
% SIMPLE_GUI2 Select a data set from the pop-up menu, then
% click one of the plot-type push buttons. Clicking the button
% plots the selected data in the axes.

%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[0,0,1000,740]);

% Construct the components.
% Network Building and Training Componenets
BuildPanel= uipanel('Title','Build and Train','FontSize',12,'Position',[.025 .5 .95 .5]);
uicontrol(BuildPanel,'Style', 'checkbox','String','Use Data','Position',[5,345,100,20],'Callback', @DataCheckBoxCallback);

SpeechDirField= uicontrol(BuildPanel,'Style','edit','enable','off','String','', 'Position', [50,320,600,20],'Callback',@SpeechDirFieldCallback);
SelectDirBtn= uicontrol(BuildPanel,'Style','pushbutton','enable','off','String','Select','Position',[660,320,75,20],'Callback', @SelectDirBtnCallback);

uicontrol(BuildPanel, 'Style','text','String', 'Folder Name', 'HorizontalAlignmen','left','Position', [5, 300, 90, 12]);
uicontrol(BuildPanel, 'Style','edit','String', '', 'Position', [100, 295, 100, 20],'Callback', @SpeakerNameFieldCallback);
uicontrol(BuildPanel, 'Style','text','String', 'File Name', 'HorizontalAlignmen','left','Position', [205, 300, 90, 12]);
uicontrol(BuildPanel, 'Style','edit','String', '', 'Position', [300, 295, 100, 20],'Callback', @TrackNameFieldCallback);
uicontrol(BuildPanel, 'Style','text','String', 'Frame Width (ms)', 'HorizontalAlignmen','left','Position', [405, 300, 90, 12]);
uicontrol(BuildPanel, 'Style','edit','String', '', 'Position', [500, 295, 100, 20],'Callback', @FrameWidthFieldCallback);
uicontrol(BuildPanel, 'Style','text','String', 'Frame Inc (ms)', 'HorizontalAlignmen','left','Position', [605, 300, 90, 12]);
uicontrol(BuildPanel, 'Style','edit','String', '', 'Position', [700, 295, 100, 20],'Callback', @FrameIncFieldCallback);

uicontrol(BuildPanel, 'Style','text','String', 'Selected Speakers', 'HorizontalAlignmen','left','Position', [5, 275, 90, 12]);
uicontrol(BuildPanel, 'Style','edit','String', '', 'Position', [100, 270, 100, 20],'Callback', @SpeakersFieldCallback);
uicontrol(BuildPanel,'Style','text','String', 'Selected Tracks', 'HorizontalAlignmen','left','Position', [205, 275, 90, 12]);
uicontrol(BuildPanel,'Style','edit','String', '', 'Position', [300, 270, 100, 20],'Callback', @TracksFieldCallback);
uicontrol(BuildPanel,'Style','text','String', 'Number Of Layers', 'HorizontalAlignmen','left','Position', [405, 275, 90, 12]);
uicontrol(BuildPanel,'Style','edit','String', '', 'Position', [500, 270, 100, 20],'Callback', @LayersFieldCallback);

uicontrol(BuildPanel,'Style', 'checkbox','String', 'MFCC', 'Position', [5,245,100,20],'Callback', @MfccCheckBoxCallback);
MfccDeltaCheckBox= uicontrol(BuildPanel,'Style', 'checkbox','enable','off','String', 'delta', 'Position', [110, 245, 100,20],'Callback', @MfccDeltaCheckBoxCallback);
MfccDeltaDeltaCheckBox= uicontrol(BuildPanel,'Style', 'checkbox','enable','off','String', 'delta delta', 'Position', [220, 245, 100,20],'Callback', @MfccDeltaDeltaCheckBoxCallback);

uicontrol(BuildPanel,'Style', 'checkbox','String', 'PLP', 'Position', [5,220,100,20],'Callback', @PlpCheckBoxCallback);
PlpDeltaCheckBox= uicontrol(BuildPanel,'Style', 'checkbox','enable','off','String', 'delta', 'Position', [110,220,100,20],'Callback', @PlpDeltaCheckBoxCallback);
PlpDeltaDeltaCheckBox= uicontrol(BuildPanel,'Style', 'checkbox','enable','off','String', 'delta delta', 'Position', [220, 220, 100,20],'Callback', @PlpDeltaDeltaCheckBoxCallback);

uicontrol(BuildPanel,'Style', 'checkbox','String', 'MFCC old', 'Position', [5,195,100,20],'Callback', @Mfcc2CheckBoxCallback);
Mfcc2DeltaCheckBox= uicontrol(BuildPanel,'Style', 'checkbox','enable','off','String', 'delta', 'Position', [110,195,100,20],'Callback', @Mfcc2DeltaCheckBoxCallback);
Mfcc2DeltaDeltaCheckBox= uicontrol(BuildPanel,'Style', 'checkbox','enable','off','String', 'delta delta', 'Position', [220, 195, 100,20],'Callback', @Mfcc2DeltaDeltaCheckBoxCallback);

uicontrol(BuildPanel,'Style', 'checkbox','String', 'LPC', 'Position', [5,170,100,20],'Callback', @LpcCheckBoxCallback);

uicontrol(BuildPanel,'Style','text','String', 'Layer Size', 'HorizontalAlignmen','left','Position', [5, 150, 90, 12]);

uicontrol(BuildPanel,'Style','text','String', 'Layer Connections', 'HorizontalAlignmen','left','Position', [5, 125, 90, 12]);

uicontrol(BuildPanel,'Style','text','String', 'Layer Function', 'HorizontalAlignmen','left','Position', [5, 100, 90, 12]);

uicontrol(BuildPanel,'Style','text','String','Network Function','HorizontalAlignmen','left','Position',[200,10,85,12]);
uicontrol(BuildPanel,'Style', 'edit','String','','Position',[290,5,80,20],'Callback', @FunctionFieldCallback);
uicontrol(BuildPanel,'Style','text','String','Gradient','HorizontalAlignmen','left','Position',[375,10,45,12]);
uicontrol(BuildPanel,'Style', 'edit','String','','Position',[420,5,80,20],'Callback', @GradientFieldCallback);
uicontrol(BuildPanel,'Style','checkbox','String','Use Gpu','Position',[505,5,80,20],'Callback',@GpuCheckBoxCallback);
uicontrol(BuildPanel,'Style','text','String','Network Name','HorizontalAlignmen','left','Position',[570,10,70,12]);
uicontrol(BuildPanel,'Style', 'edit','String','','Position',[645,5,80,20],'Callback', @NameFieldCallback);
uicontrol(BuildPanel,'Style','pushbutton','String','Train','Position',[730,5, 60, 20],'Callback',@TrainButtonCallback);

%Network Single Test Components
SingleTestPanel= uipanel('Title','Recognize Speaker','FontSize',12,'Position',[.025 .35 .95 .15]);
TestCheckBox= uicontrol(SingleTestPanel,'Style', 'checkbox','String','Use Data','enable','off','Position',[5,70,100,20],'Callback', @TestCheckBoxCallback);
TestFileField= uicontrol(SingleTestPanel,'Style','edit','enable','off','String','', 'Position', [50,45,600,20],'Callback',@TestFileFieldCallback);
SelectTestFileBtn= uicontrol(SingleTestPanel,'Style','pushbutton','enable','off','String','Select','Position',[660,45,75,20],'Callback', @SelectTestFileBtnCallback);
RecognizeBtn= uicontrol(SingleTestPanel,'Style','pushbutton','String','Recognize','enable','off','Position',[740,45,75,20],'Callback', @RecognizeBtnCallback);

%Network Batch Test Components
BatchTestPanel= uipanel('Title','Batch Test','FontSize',12,'Position',[.025 .025 .95 .325]);
TestDirField= uicontrol(BatchTestPanel,'Style','edit','String','', 'Position', [50,200,600,20],'Callback',@TestDirFieldCallback);
SelectTestDirBtn= uicontrol(BatchTestPanel,'Style','pushbutton','String','Select','enable','off','Position',[660,200,75,20],'Callback', @SelectTestDirBtnCallback);
uicontrol(BatchTestPanel,'Style','text','String', 'Test Speakers', 'HorizontalAlignmen','left','Position', [5, 180, 90, 12]);
TestSpeakersField= uicontrol(BatchTestPanel,'Style','edit','String', '','enable','off', 'Position', [100, 175, 100, 20],'Callback', @TestSpeakersFieldCallback);
uicontrol(BatchTestPanel,'Style','text','String', 'Test Tracks', 'HorizontalAlignmen','left','Position', [205, 180, 90, 12]);
TestTracksField= uicontrol(BatchTestPanel,'Style','edit','String', '', 'enable','off','Position', [300, 175, 100, 20],'Callback', @TestTracksFieldCallback);
TestBtn= uicontrol(BatchTestPanel,'Style','pushbutton','String','Test','enable','off','Position',[410,175,75,20],'Callback', @TestBtnCallback);

%Shared Data
%Build Data
UseData=false;
SpeechDirectory= '';
SpeakerName='';
TrackName='';
FrameWidth=30;
FrameInc=15;
Persons=0;
Tracks=0;
SelectedFeatures= [false,false,false;false,false,false;false,false,false;false,false,false];
NetworkDesign = 0;
LayersFunction = {'tansig';'logsig'};
NetworkFunction='trainscg';
Gradient=1e-6;
UseGpu='no';
NetworkName='net';
Net= network;

%Single Test Data
TestFile='';
TestWithData=false;

%Batch Test Data
TestDirectory='';
TestPersons=0;
TestTracks=0;

% Assign the a name to appear in the window title.
f.Name = 'Speaker Recognition Tool';

% Move the window to the center of the screen.
movegui(f,'north');
set(f,'menubar','none');
% Make the window visible.
f.Visible = 'on';

    function DataCheckBoxCallback(source, eventdata)
        UseData= source.Value;
        SetSpeechDataComponents();
    end

    function SelectDirBtnCallback(source, eventdata)
        if(length(SpeechDirectory)>1)
            dir= uigetdir(SpeechDirectory);
        else
            dir= uigetdir;
        end;
        if(dir~=0)
            SpeechDirectory= dir;
            set(SpeechDirField,'String',SpeechDirectory);
        end;
    end

    function SpeechDirFieldCallback(source,eventdata)
        SpeechDirectory= get(source,'String');
    end

    function SetSpeechDataComponents()
        if(~UseData)
            set(SpeechDirField,'enable','off');
            set(SelectDirBtn, 'enable', 'off');
        else
            set(SpeechDirField, 'enable', 'on');
            set(SelectDirBtn, 'enable', 'on');
        end;
    end

    function SpeakerNameFieldCallback(source, eventdata)
        SpeakerName= get(source,'String');
    end

    function TrackNameFieldCallback(source,eventdata)
        TrackName= get(source, 'String');
    end

    function FrameWidthFieldCallback(source,eventdata)
        conversionResult= str2num(source.String);
        [m,n]= size(conversionResult);
        if(m==1 && n==1)
            FrameWidth=conversionResult;
        end;
    end

    function FrameIncFieldCallback(source,eventdata)
        conversionResult= str2num(source.String);
        [m,n]= size(conversionResult);
        if(m==1 && n==1)
            FrameInc=conversionResult;
        end;
    end

    function SpeakersFieldCallback(source,eventdata)
        conversionResult= str2num(source.String);
        [m,n]= size(conversionResult);
        if(m~=0 && n~=0)
            Persons=conversionResult;
        end;
    end

    function TracksFieldCallback(source,eventdata)
        conversionResult= str2num(source.String);
        [m,n]= size(conversionResult);
        if(m~=0 && n~=0)
            Tracks=conversionResult;
        end;
    end

    function MfccCheckBoxCallback(source,eventdata)
        SelectedFeatures(1,1)= source.Value;
        if(SelectedFeatures(1,1))
            set(MfccDeltaCheckBox,'enable','on');
        else
            set(MfccDeltaCheckBox,'enable','off');
        end;
        
    end

    function MfccDeltaCheckBoxCallback(source,eventdata)
        SelectedFeatures(1,2)= source.Value;
        if(SelectedFeatures(1,2))
            set(MfccDeltaDeltaCheckBox,'enable','on');
        else
            set(MfccDeltaDeltaCheckBox,'enable','off');
        end;
    end

    function MfccDeltaDeltaCheckBoxCallback(source,eventdata)
        SelectedFeatures(1,3)= source.Value;
    end

    function PlpCheckBoxCallback(source,eventdata)
        SelectedFeatures(2,1)= source.Value;
        if(SelectedFeatures(2,1))
            set(PlpDeltaCheckBox,'enable','on');
        else
            set(PlpDeltaCheckBox,'enable','off');
        end;
    end

    function PlpDeltaCheckBoxCallback(source,eventdata)
        SelectedFeatures(2,2)= source.Value;
        if(SelectedFeatures(2,2))
            set(PlpDeltaDeltaCheckBox,'enable','on');
        else
            set(PlpDeltaDeltaCheckBox,'enable','off');
        end;
    end

    function PlpDeltaDeltaCheckBoxCallback(source,eventdata)
        SelectedFeatures(2,3)= source.Value;
    end

    function Mfcc2CheckBoxCallback(source,eventdata)
        SelectedFeatures(3,1)= source.Value;
        if(SelectedFeatures(3,1))
            set(Mfcc2DeltaCheckBox,'enable','on');
        else
            set(Mfcc2DeltaCheckBox,'enable','off');
        end;
        
    end

    function Mfcc2DeltaCheckBoxCallback(source,eventdata)
        SelectedFeatures(3,2)= source.Value;
        if(SelectedFeatures(3,2))
            set(Mfcc2DeltaDeltaCheckBox,'enable','on');
        else
            set(Mfcc2DeltaDeltaCheckBox,'enable','off');
        end;
    end

    function Mfcc2DeltaDeltaCheckBoxCallback(source,eventdata)
        SelectedFeatures(3,3)= source.Value;
    end

    function LpcCheckBoxCallback(source,eventdata)
        SelectedFeatures(4,1)= source.Value;
    end

    function LayersFieldCallback(source,eventdata)
        conversionResult= str2num(source.String);
        [m,n]= size(conversionResult);
        if(m==1 && n==1 && conversionResult>0)
            NetworkDesign = zeros(conversionResult,2);
            LayersFunction = cell(conversionResult,1);
            for i=1:conversionResult
                uicontrol(BuildPanel,'Style','edit','String', '','Position', [100+55*(i-1), 145, 50, 20],'Callback', {@SizesFieldCallback,i});
                uicontrol(BuildPanel,'Style','edit','String','','Position', [100+55*(i-1), 120, 50, 20],'Callback', {@ConnectionsFieldCallback,i});
                uicontrol(BuildPanel,'Style','edit','String', '','Position', [100+55*(i-1), 95, 50, 20],'Callback', {@FunctionsFieldCallback,i});
            end;
        end;
    end

    function SizesFieldCallback(source,eventdata,i)
        conversionResult= str2num(source.String);
        [m,n]= size(conversionResult);
        if(m==1 && n==1)
            NetworkDesign(i,1)= conversionResult;
        end;
    end

    function ConnectionsFieldCallback(source,eventdata,i)
        conversionResult= str2num(source.String);
        [m,n]= size(conversionResult);
        if(m==1 && n==1)
            NetworkDesign(i,2)= conversionResult;
        end;
    end

    function FunctionsFieldCallback(source,eventdata,i)
        LayersFunction{i,1}= source.String;
    end

    function FunctionFieldCallback(source,eventdata)
        NetworkFunction= source.String;
    end

    function GradientFieldCallback(source, eventdata)
        conversionResult= str2num(source.String);
        [m,n]= size(conversionResult);
        if(m==1 && n==1)
            Gradient= conversionResult;
        end;
    end

    function GpuCheckBoxCallback(source,eventdata)
        if(source.Value)
            UseGpu= 'yes';
        else
            UseGpu= 'no';
        end;
    end
    function NameFieldCallback(source,eventdata)
        NetworkName= source.String;
    end

    function TrainButtonCallback(source,eventdata)
        disp(LayersFunction{1,1});
        if(UseData)
            FeaturesNbr= sum(SelectedFeatures(:,1));
            [data,target,fs]= PrepareData(SpeechDirectory,SpeakerName,TrackName,FrameWidth,FrameInc,Persons,Tracks,SelectedFeatures,FeaturesNbr);
            [Net,trainingTime]= BuildNetwork(NetworkDesign,data,target,NetworkFunction,LayersFunction,Gradient,UseGpu,0.9999);
            set(TestCheckBox,'enable','on');
            set(RecognizeBtn,'enable','on');
            set(TestDirField,'enable','on');
            set(SelectTestDirBtn,'enable','on');
            set(TestSpeakersField,'enable','on');
            set(TestTracksField,'enable','on');
            set(TestBtn,'enable','on');
            assignin('base',NetworkName,Net);
            assignin('base',[NetworkName,'TrainingTime'],trainingTime);
        end;
    end

%Network Single Test Callbacks
    function TestCheckBoxCallback(source, eventdata)
        if(source.Value)
            TestWithData= true;
            set(TestFileField,'enable','on');
            set(SelectTestFileBtn, 'enable', 'on');
        else
            TestWithData= false;
            set(TestFileField, 'enable', 'off');
            set(SelectTestFileBtn, 'enable', 'off');
        end;
    end
    function TestFileFieldCallback(source,eventdata)
        TestFile= get(source,'String');
    end
    function SelectTestFileBtnCallback(source,eventdata)
        [dir,path]= uigetfile('*.wav');
        if(dir~=0)
            TestFile= fullfile(path,dir);
            set(TestFileField,'String',TestFile);
        end;
    end
    function RecognizeBtnCallback(source,eventdata)
        FeaturesNbr= sum(SelectedFeatures(:,1));
        if(TestWithData)
            [id,score,scores]= RecognizeSpeaker(Net,TestFile,FrameWidth,FrameInc,Persons,SelectedFeatures,FeaturesNbr);
            disp(['Person ',num2str(id),' got ',num2str(score)]);
            disp(scores);
        end;
    end

%Network Batch Test Callbacks
    function TestDirFieldCallback(source,eventdata)
        TestDirectory= get(source,'String');
    end
    function SelectTestDirBtnCallback(source,eventdata)
        if(length(TestDirectory)>1)
            dir= uigetdir(TestDirectory);
        else
            dir= uigetdir;
        end;
        if(dir~=0)
            TestDirectory= dir;
            set(TestDirField,'String',TestDirectory);
        end;
    end
    function TestSpeakersFieldCallback(source,eventdata)
        conversionResult= str2num(source.String);
        [m,n]= size(conversionResult);
        if(m~=0 && n~=0)
            TestPersons=conversionResult;
        end;
    end
    function TestTracksFieldCallback(source,eventdata)
        conversionResult= str2num(source.String);
        [m,n]= size(conversionResult);
        if(m~=0 && n~=0)
            TestTracks=conversionResult;
        end;
    end
    function TestBtnCallback(source,eventdata)
        FeaturesNbr= sum(SelectedFeatures(:,1));
        [accuracy,results]=TestNet(Net,TestDirectory,FrameWidth,FrameInc,Persons,TestPersons,TestTracks,SelectedFeatures,FeaturesNbr);
        PlotResult(results);
        disp(['The Network accuracy is: ',num2str(accuracy)]);
        pString= num2str(length(TestPersons));
        tString= num2str(length(TestTracks));
        assignin('base',[NetworkName,'P',pString,'T',tString,'Accuracy'],accuracy);
        assignin('base',[NetworkName,'P',pString,'T',tString,'Results'],results);
    end
end