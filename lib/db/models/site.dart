const String siteTable = 'sites';

class SiteTypes {
  static const String id = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  // TODO: Add foreign key for profile id
  static const String site = 'VARCHAR(15)';
  static const String name = 'VARCHAR(30)';
}

class SiteFields {
  static final List<String> values = [
    id, site, name
  ];

  static const String id = '_id';
  // TODO: Foreign key
  static const String site = 'site';
  static const String name = 'name';
}

class Site {
  final int? id;
  // TODO: Foreign key
  final String site;
  final String name;

  const Site({
    this.id,
    // TODO: Foreign key
    required this.site,
    required this.name,
  });
}