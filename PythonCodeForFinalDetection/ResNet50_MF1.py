# -*- coding: utf-8 -*-
"""
Created on Sat Jul 08 15:53:01 2017

@author: chengshenghua
"""

from __future__ import print_function
from keras.models import Model
from keras.layers import Dense, Dropout, Activation, Lambda, add, Input, Flatten
from keras.regularizers import l2
from keras.layers import Conv2D, AveragePooling2D, MaxPooling2D
from keras.layers.normalization import BatchNormalization
from keras import backend as K
from ResNet50GXB import ResNet50GXB


def ResNet50_MF1(input_shape = (245, 245, 3), classes=2): 
    model_base = ResNet50GXB(include_top=False, input_shape = input_shape, weights='imagenet', pooling='max')
    for layer in model_base.layers[:39]:#78 140
        layer.trainable = False
 
    x = model_base.output
    x = Dense(64, activation='relu')(x)
    x = Dropout(0.5)(x)
    x = Dense(classes, activation='softmax')(x)
    model = Model(model_base.input, x)
    
    return model


   


     

