from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    phone = models.CharField(max_length=50)
    organism = models.CharField(max_length=255)
    image = models.BinaryField(null=True)

    class Meta:
        db_table = 'User'
