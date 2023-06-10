extension MapExtensions on Map {
  //to avoid to call unidentified keys
  dynamic safe(String key) {
    // ignore: unnecessary_this
    if (this != null && this.containsKey(key) && this[key] != null && this[key] != '') {
      return this[key];
    }
    return null;
  }
}
