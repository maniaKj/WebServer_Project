package user;

public class UserPhoto {
	private String userPhotoName;
	private String userPhotoRealName;
	
	public String getUserPhotoName() {
		return userPhotoName;
	}
	public void setUserPhotoName(String userPhotoName) {
		this.userPhotoName = userPhotoName;
	}
	public String getUserPhotoRealName() {
		return userPhotoRealName;
	}
	public void setUserPhotoRealName(String userPhotoRealName) {
		this.userPhotoRealName = userPhotoRealName;
	}
	public UserPhoto(String userPhotoName, String userPhotoRealName) {
		super();
		this.userPhotoName = userPhotoName;
		this.userPhotoRealName = userPhotoRealName;
	}
	
	
}
