# -*- coding: utf-8 -*-
"""
Created on Thu Dec 20 12:59:33 2018

@author: chengshenghua
"""

import os
from keras.models import Model
from keras.layers import Dense, Dropout, Activation, Lambda, add, Input, Flatten
from keras.regularizers import l2
from keras.layers import Conv2D, AveragePooling2D, MaxPooling2D, GlobalMaxPooling2D
from keras.layers.normalization import BatchNormalization
from keras import backend as K

def conv(input_tensor, kernel_size, filters):
    x = Conv2D(filters, kernel_size, padding='valid')(input_tensor)
    x = BatchNormalization(axis=-1)(x)
    x = Activation('relu')(x)
    return x

def SimpleNet(input_shape=(245, 245, 1), classes=2, filters=16):
    img_input = Input(input_shape)
    x = conv(img_input, (7, 7), filters)
    x = conv(x, (7, 7), filters)
    x = MaxPooling2D((2, 2))(x)
    
    x = conv(x, (3, 3), 2*filters)
    x = conv(x, (3, 3), 2*filters)
    x = MaxPooling2D((2, 2))(x)
    
    x = conv(x, (3, 3), 4*filters)
    x = conv(x, (3, 3), 4*filters)
    x = conv(x, (3, 3), 4*filters)
    x = MaxPooling2D((2, 2))(x)
    
    x = conv(x, (3, 3), 8*filters)
    x = conv(x, (3, 3), 8*filters)
    x = conv(x, (3, 3), 8*filters)
    x = MaxPooling2D((2, 2))(x)
    
    x = conv(x, (3, 3), 8*filters)
    x = conv(x, (3, 3), 8*filters)
    x = MaxPooling2D((2, 2))(x)
    
    x = Flatten()(x)
    x = Dense(64, activation = 'relu')(x)
    x = Dropout(0.5)(x)
    x = Dense(2)(x)
    x = Activation('softmax')(x)

    model = Model(img_input, x)
    
    return model
    
def identity_block(input_tensor, kernel_size, filters):
    bn_axis = -1

    x = Conv2D(filters, kernel_size, padding='same')(input_tensor)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)

    x = add([x, input_tensor])
    x = Activation('relu')(x)
    return x


def conv_block(input_tensor, kernel_size, filters):
    bn_axis = -1
    
    x = Conv2D(filters, kernel_size, padding='same')(input_tensor)
    x = BatchNormalization(axis=bn_axis)(x)
    x = Activation('relu')(x)

    shortcut = Conv2D(filters, (1, 1))(input_tensor)
    shortcut = BatchNormalization(axis=bn_axis)(shortcut)

    x = add([x, shortcut])
    x = Activation('relu')(x)
    return x

def SimpleResNet(input_shape=(245, 245, 1), classes=2, filters=16):
    img_input = Input(input_shape)
    x = conv(img_input, (7, 7), filters)
    x = conv(x, (7, 7), filters)
    x = MaxPooling2D((2, 2))(x)
    
    x = conv_block(x, (3, 3), 2*filters)
    x = identity_block(x, (3, 3), 2*filters)
    x = MaxPooling2D((2, 2))(x)
    
    x = conv_block(x, (3, 3), 4*filters)
    x = identity_block(x, (3, 3), 4*filters)
    x = identity_block(x, (3, 3), 4*filters)
    x = MaxPooling2D((2, 2))(x)
    
    x = conv_block(x, (3, 3), 8*filters)
    x = identity_block(x, (3, 3), 8*filters)
    x = identity_block(x, (3, 3), 8*filters)
    x = MaxPooling2D((2, 2))(x)
    
    x = conv_block(x, (3, 3), 8*filters)
    x = identity_block(x, (3, 3), 8*filters)
    x = MaxPooling2D((2, 2))(x)
    
    x = Flatten()(x)
    x = Dense(64, activation = 'relu')(x)
    x = Dropout(0.5)(x)
    x = Dense(2)(x)
    x = Activation('softmax')(x)

    model = Model(img_input, x)
    
    return model