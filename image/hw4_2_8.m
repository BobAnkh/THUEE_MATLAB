clear all;
close all;

load hall.mat;
load JpegCoeff.mat;
hall_process = preprocess(hall_gray);
hall_quantified = quantify(hall_process, QTAB);
