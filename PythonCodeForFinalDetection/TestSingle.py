# -*- coding: utf-8 -*-
"""
Created on Mon Dec 24 10:32:09 2018

@author: Administrator
"""

from __future__ import print_function

import os
os.environ['CUDA_VISIBLE_DEVICES'] = '0, 1'

import numpy as np
import matplotlib.pyplot as plt
import SimpleNet as SN
from keras.optimizers import SGD, Adam
from keras.utils import multi_gpu_model, plot_model, to_categorical
import keras.backend as K
import tensorflow as tf
import skimage.external.tifffile as tiff
import scipy.io as sio
import cv2

gpu_num = 2
adm = Adam(lr=0.01)
sgd = SGD(lr=0.01, decay=1e-6, momentum=0.9, nesterov=True)
sgdFT = SGD(lr=0.001, decay=1e-6, momentum=0.9, nesterov=True)

with tf.device('/cpu:0'):
    model = SN.SimpleResNet(input_shape = (245,245,1), classes=2)
    model.load_weights('D:\\DeepBouton\\WeightsSimpleResNet\\w_R3_4.h5')
    model.compile(optimizer= adm, loss=["categorical_crossentropy"], metrics=["categorical_accuracy"])
parallel_model = multi_gpu_model(model, gpus=gpu_num)
parallel_model.compile(optimizer= adm, loss=["categorical_crossentropy"], metrics=["categorical_accuracy"])

fold = "W:\\Finished neuron tracing"
fileList = os.listdir(fold)
fileList = [x for x in fileList if ".swc" in x]

for i in fileList:
    #path = fold + "\\" + 'NO.10_axon\\' + 'sampleData_uint16.tif'
    #pathSv = fold + "\\" + 'NO.10_axon\\' + 'predict_prob_SimpNet.mat'
    path = fold + "\\" + i[:-4] + '\\' + 'sampleData_uint16.tif'
    pathSv = fold + "\\" + i[:-4] + '\\' + 'predict_prob_ResNet.mat' 
    img = tiff.imread(path)
    img = np.float32(img)
    imgNew = np.zeros((img.shape[0], 245, 245), dtype=np.float32)
    for j in range(img.shape[0]):
        imgNew[j] = cv2.resize(img[j], (245,245))
    img = imgNew[:,:,:,np.newaxis]
    img = img / 2000.
    prob = parallel_model.predict(img, batch_size=128*gpu_num)
    sio.savemat(pathSv, {'prob': prob})
    
