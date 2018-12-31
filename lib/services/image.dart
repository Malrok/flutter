import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://cross-platform-test.appspot.com');
  StorageReference ref;

  ImageService() {
    ref = storage.ref().child('avatars');
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      StorageReference pictureRef = ref
          .child(
          'tmp_' + image.path.substring(image.path.lastIndexOf('/') + 1));

      StorageUploadTask uploadTask = pictureRef.putFile(image);
      await uploadTask.onComplete;

      return pictureRef.getDownloadURL();
    } else {
      return null;
    }
  }
}
