class Purchase < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader
end
