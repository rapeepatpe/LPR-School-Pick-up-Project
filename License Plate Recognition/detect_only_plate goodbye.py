import os
import time
start_time = time.time()
end_time = time.time()

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
import tensorflow as tf

physical_devices = tf.config.experimental.list_physical_devices('GPU')
if len(physical_devices) > 0:
    tf.config.experimental.set_memory_growth(physical_devices[0], True)
from absl import app, flags, logging
from absl.flags import FLAGS
import core.utils_director_cut_parallel as utils
from core.yolov4 import filter_boxes
from core.functions import *
from tensorflow.python.saved_model import tag_constants
from PIL import Image
import cv2
import numpy as np
from tensorflow.compat.v1 import ConfigProto
from tensorflow.compat.v1 import InteractiveSession

flags.DEFINE_string('framework', 'tf', '(tf, tflite, trt')
flags.DEFINE_string('weights', './checkpoints/yolov4-416',
                    'path to weights file')
flags.DEFINE_integer('size', 416, 'resize images to')
flags.DEFINE_boolean('tiny', False, 'yolo or yolo-tiny')
flags.DEFINE_string('model', 'yolov4', 'yolov3 or yolov4')
flags.DEFINE_list('images', './data/images/kite.jpg', 'path to input image')
flags.DEFINE_string('output', './detections/', 'path to output folder')
flags.DEFINE_float('iou', 0.45, 'iou threshold')
flags.DEFINE_float('score', 0.50, 'score threshold')
flags.DEFINE_boolean('count', False, 'count objects within images')
flags.DEFINE_boolean('dont_show', False, 'dont show image output')
flags.DEFINE_boolean('info', False, 'print info on detections')
flags.DEFINE_boolean('crop', False, 'crop detections from images')
flags.DEFINE_boolean('ocr', False, 'perform generic OCR on detection regions')
flags.DEFINE_boolean('plate', False, 'perform license plate recognition')

def main(_argv):
    config = ConfigProto()
    config.gpu_options.allow_growth = True
    session = InteractiveSession(config=config)
    STRIDES, ANCHORS, NUM_CLASS, XYSCALE = utils.load_config(FLAGS)
    input_size = FLAGS.size
    images = FLAGS.images

    
    if FLAGS.framework == 'tflite':
            start_time = time.time()
            interpreter = tf.lite.Interpreter(model_path=FLAGS.weights)
            end_time = time.time()
            print("Flag Framework",end_time - start_time)
    else:
            start_time2 = time.time()
            saved_model_loaded = tf.saved_model.load(FLAGS.weights, tags=[tag_constants.SERVING])
            end_time = time.time()
            print("No Flag Framework",end_time - start_time2)

    
    for count, image_path in enumerate(images, 1):
        end_time = time.time()
        print(end_time - start_time)
        start_time = end_time
        original_image = cv2.imread(image_path)
        original_image = cv2.cvtColor(original_image, cv2.COLOR_BGR2RGB)

        image_data = cv2.resize(original_image, (input_size, input_size))
        image_data = image_data / 255.
        
        
        image_name = image_path.split('/')[-1]
        image_name = image_name.split('.')[0]

        images_data = []
        for i in range(1):
            images_data.append(image_data)
        images_data = np.asarray(images_data).astype(np.float32) 

        if FLAGS.framework == 'tflite':
            interpreter.allocate_tensors()
            input_details = interpreter.get_input_details()
            output_details = interpreter.get_output_details()
            interpreter.set_tensor(input_details[0]['index'], images_data)
            interpreter.invoke()
            pred = [interpreter.get_tensor(output_details[i]['index']) for i in range(len(output_details))]
            if FLAGS.model == 'yolov3' and FLAGS.tiny == True:
                boxes, pred_conf = filter_boxes(pred[1], pred[0], score_threshold=0.25, input_shape=tf.constant([input_size, input_size]))
            else:
                boxes, pred_conf = filter_boxes(pred[0], pred[1], score_threshold=0.25, input_shape=tf.constant([input_size, input_size]))
        else:
            infer = saved_model_loaded.signatures['serving_default']
            batch_data = tf.constant(images_data)
            pred_bbox = infer(batch_data)
            for key, value in pred_bbox.items():
                boxes = value[:, :, 0:4]
                pred_conf = value[:, :, 4:]

        
        boxes, scores, classes, valid_detections = tf.image.combined_non_max_suppression(
            boxes=tf.reshape(boxes, (tf.shape(boxes)[0], -1, 1, 4)),
            scores=tf.reshape(
                pred_conf, (tf.shape(pred_conf)[0], -1, tf.shape(pred_conf)[-1])),
            max_output_size_per_class=50,
            max_total_size=50,
            iou_threshold=FLAGS.iou,
            score_threshold=FLAGS.score
        )

        
        original_h, original_w, _ = original_image.shape
        bboxes = utils.format_boxes(boxes.numpy()[0], original_h, original_w)
        
        
        pred_bbox = [bboxes, scores.numpy()[0], classes.numpy()[0], valid_detections.numpy()[0]]

        
        

        
        
        
        
        

        
        
        
        
        
        
        
        

        
        
        

        
        
        
        
        
        
        
        
        
        
        
        
        end_time = time.time()
        print(end_time - start_time)
        out_boxes, out_scores, out_classes, num_boxes = pred_bbox
        coor = out_boxes[i]
        dataout = utils.recognize_plate(original_image, coor)
        print(dataout)
        
        end_time = time.time()
        print(end_time - start_time)
        
        
        
        
        
        

if __name__ == '__main__':
    try:
        app.run(main)
    except SystemExit:
        pass


end_time = time.time()

print(end_time - start_time)