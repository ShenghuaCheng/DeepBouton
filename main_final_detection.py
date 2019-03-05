# -*- coding: utf-8 -*-
"""
Created on Mon Dec 24 10:32:09 2018

@author: chengshenghua
"""

from __future__ import print_function

import os
os.environ['CUDA_VISIBLE_DEVICES'] = '0'

import numpy as np
import SimpleNet as SN
from keras.optimizers import SGD
import scipy.io as sio
import cv2
import h5py

pathBoutonPatch = 'D:\\MyMatlabFiles\\DeepBoutonForPaper\\Bouton\\bouton_patches.mat'
pathSvBoutonProb = 'D:\\MyMatlabFiles\\DeepBoutonForPaper\\Bouton\\bouton_prob.mat' 
pathWeight = 'D:\\MyMatlabFiles\\DeepBoutonForPaper\\Data\\xx.h5'
batch_size = 128


sgd = SGD(lr=0.01, decay=1e-6, momentum=0.9, nesterov=True)
model = SN.SimpleResNet(input_shape = (245,245,1), classes=2)
model.load_weights(pathWeight)
model.compile(optimizer= sgd, loss=["categorical_crossentropy"], metrics=["categorical_accuracy"])

img = h5py.File(pathBoutonPatch)
img = img['sampleTotal'][:]
img = np.transpose(img, [0, 2, 1])
imgNew = np.zeros((img.shape[0], 245, 245), dtype=np.float32)
for j in range(img.shape[0]):
    imgNew[j] = cv2.resize(img[j], (245,245))
img = imgNew[:,:,:,np.newaxis]
img = img / 2000.
prob = model.predict(img, batch_size=batch_size)
sio.savemat(pathSvBoutonProb, {'prob': prob})
    
