String customErrorResponses(Exception _error) {
  late String _response;
  _response = "An error occurred whiled decoding: $_error";
  return _response;
}
