from loguru import logger
from numpy import ndarray
import httpx
from .Dynamic import logger
from numpy import ndarray
import numpy as np
import cv2 as cv


class PicGetter:
    def pic_getter(self, url) -> ndarray:
        """请求图片的函数

        :param url: _description_
        :type url: _type_
        :return: _description_
        :rtype: ndarray
        """
        try:
            response = httpx.get(url)
            img = cv.imdecode(np.asarray(
                bytearray(response.content), dtype='uint8'), -1)
            return self.convert_png(img)
        except Exception as e:
            logger.exception("What?!")
            return None

    def convert_png(self,img: ndarray) -> ndarray:
        """将图片转化为四通道PNG

        :param img: ndarry格式的图片
        :type img: ndarray
        :return: ndarry格式的图片
        :rtype: ndarray
        """
        chennal = img.shape[2]
        if chennal != 3:
            return img
        # 分离jpg图像通道
        b_channel, g_channel, r_channel = cv.split(img)  
         # 创建Alpha通道
        alpha_channel = np.ones(b_channel.shape, dtype=b_channel.dtype) * 255 
        # 融合通道
        return cv.merge((b_channel, g_channel, r_channel, alpha_channel))
