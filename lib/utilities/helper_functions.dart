
String getResultTitle(String _result) {
  if (_result == 'introvert') {
    return 'You are an Introvert';
  } else {
    return 'You are an Extrovert';
  }
}

String getResultDescription(String _result) {
  if (_result == 'introvert') {
    return 'An introvert is a person with qualities of a personality type known as introversion, which means that they feel more comfortable focusing on their inner thoughts and ideas, rather than what\'s happening externally. They enjoy spending time with just one or two people, rather than large groups or crowds.';
  } else {
    return 'Extroverts are often described as the life of the party. Their outgoing, vibrant nature draws people to them, and they have a hard time turning away the attention. They thrive off the interaction. On the opposite side are introverts. These people are typically described as more reserved.';
  }
}
