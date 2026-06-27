import { Request } from 'express';
import multer, { FileFilterCallback } from 'multer';

export const uploader = (
  fileType: 'resume' | 'profile_picture' | 'logo' | 'banner' | 'payment'
) => {
  const storage = multer.memoryStorage();

  const fileFilter = (
    req: Request,
    file: Express.Multer.File,
    cb: FileFilterCallback,
  ) => {
    const allowedImageTypes = ['image/jpeg', 'image/png', 'image/jpg'];
    const allowedDocumentTypes = ['application/pdf'];

    if (
      (fileType === 'profile_picture' || fileType === 'logo' || fileType === 'banner') &&
      allowedImageTypes.includes(file.mimetype)
    ) {
      cb(null, true);
    } else if (fileType === 'resume' && allowedDocumentTypes.includes(file.mimetype)) {
      cb(null, true);
    } else if (fileType === 'payment' && allowedImageTypes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('Invalid file type'));
    }
  };

  // Define max file size
  const maxSize = fileType === 'profile_picture' ? 1 * 1024 * 1024 : 5 * 1024 * 1024; // 1MB for profile pictures, 5MB for others

  return multer({
    storage,
    fileFilter,
    limits: { fileSize: maxSize },
  });
};
