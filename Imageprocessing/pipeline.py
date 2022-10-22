# -*- coding: utf-8 -*-
"""Untitled1.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1JKSpt98qMPcmrkPrOjsuPcKzHCCKolPT
"""

!git lfs install
!git clone https://huggingface.co/MLZoo/license-plate-model

!pip install transformers[torch]

from transformers import pipeline
from transformers import AutoTokenizer,  AutoModelForSequenceClassification


# model_name = "license-plate-model"
model_name = "MLZoo/license-plate-model"
model =  AutoModelForSequenceClassification.from_pretrained(model_name)
tokenizer = AutoTokenizer.from_pretrained(model_name)

classifier = pipeline("sentiment-analysis", model = model, tokenizer = tokenizer)

res = classifier("hello world")

print(res)