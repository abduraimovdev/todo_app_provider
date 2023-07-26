enum Sync {
  create,
  update,
  delete,
  right,
}

extension ExtSync on Sync {
  String ts() {
    return name;
  }
}

