class Filter {
  final String description;
  bool state;

  bool equals(Filter other) {
    if (other == this) {
      return true;
    }
    return other.description == description;
  }

  Filter(this.description, this.state);

  Filter.fromExisting(Filter existing)
      : description = existing.description,
        state = existing.state != null ? existing.state : false;
}
