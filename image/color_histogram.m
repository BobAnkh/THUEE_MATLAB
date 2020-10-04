function face_template = color_histogram(L) 
%��ѵ�����и���L�õ�����ģ�壬�轫��������ͬĿ¼Faces�ļ�����
% L:ѡȡ�����Ƹ�Lλ
    face_template = zeros(2^(3 * L), 1);
    % ��ͼƬ��ȡ�������õ�������׼
    img_folder = 'Faces/';
    img_list = dir(img_folder);
    % img_listǰ������"."��"..", ���Լ�����3��ʼ
    for img_name=3:length(img_list)
        image = imread([img_folder, img_list(img_name).name]);
        face_template = face_template + img2color_vec(image, L);
    end
    face_template = face_template / (length(img_list) - 2);
end
