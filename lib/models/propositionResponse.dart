class PropositionResponse {
  final int id;
  final bool isResponse;
  final String content;

  PropositionResponse._(this.id, this.content, this.isResponse);

  factory PropositionResponse.fromJson(Map<String, dynamic> data) => PropositionResponse._(data['id'], data['content'], data['is_response']);

  @override
  bool operator == (Object other) {
    if (other is PropositionResponse)
      return other.id == id;
    return false;
  }

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return 'PropositionResponse{id: $id, content: $content}';
  }
}