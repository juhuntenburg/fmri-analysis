clear all
close all

%%%%%%%%%%%%%%%%%%%%%% Input %%%%%%%%%%%%%%%%%%%%%

main_folder = '/Users/francisca/Documents/Data';
study_folder = '20180717_120447_CL_180718_visualstim_FFF_1_1';
search_name = 'Image';
% search_name = 'raiImage';
nrepetitions = 340;
nslices = 13;
scan_folders = [11];
show_video = 1;

%%
%%%%%%%%%%%%%%%%%% Computations %%%%%%%%%%%%%%%%%%

for j = 1:length(scan_folders)
    %%% Images %%%
    input_folder = [main_folder filesep study_folder filesep num2str(scan_folders(j)) filesep 'Processed'];

    %%% Read images %%%
    for i = 1:nrepetitions
        file = [input_folder filesep search_name '_' num2str(scan_folders(j)) '_' num2str(i,'%04d') '.nii'];
        V = spm_vol(file);
        vols(:,:,:,i) = flipdim(imrotate(spm_read_vols(V),-90),2);
    end

    %%% Show video %%%
    if show_video
        for i = 1:nrepetitions
            imagesc(squeeze(vols(:,:,5,i))); axis image; axis off; colormap(gray(256)); colorbar; shg;
            drawnow; shg
        end
    end

    %%% Save Gif %%%
    for i = 1:nslices
        saveMatAsAnimatedGif(squeeze(vols(:,:,i,:)),[main_folder filesep study_folder filesep num2str(scan_folders(j)) filesep 'Processed' filesep search_name num2str(i) '.gif'], colormap(gray(256)),[0 5500],5,0.01);
    end
end