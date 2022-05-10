
///This function can be used to provide relevant error responses based on 
///the type of HTTP/API error codes. 
String customErrorResponses(Exception _error) {
  late String _response;
  _response = "An error occurred whiled decoding: $_error";
  return _response;
}
