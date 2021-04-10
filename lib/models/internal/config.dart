class Config {
  String appName = "";
  String packageName = "";
  int expiresIn = 0;
  String accessToken = "";
  String refreshToken = "";
  String baseUrl = "";
  List<ScreenItem> screens = [];
  List<FeatureItem> features = [];
  List<PermissionItem> permissions = [];
  int totalScreen = 0;

  Config({
    this.appName,
    this.packageName,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
    this.baseUrl,
    this.screens,
    this.features,
    this.permissions,
    this.totalScreen,
  });

  Config.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    packageName = json['package_name'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    baseUrl = json['base_url'];
    if (json['screens'] != null) {
      screens = new List<ScreenItem>();
      json['screens'].forEach((v) {
        screens.add(new ScreenItem.fromJson(v));
      });
    }
    if (json['features'] != null) {
      features = new List<FeatureItem>();
      json['features'].forEach((v) {
        features.add(new FeatureItem.fromJson(v));
      });
    }
    if (json['permissions'] != null) {
      permissions = new List<PermissionItem>();
      json['permissions'].forEach((v) {
        permissions.add(new PermissionItem.fromJson(v));
      });
    }
    totalScreen = json['total_screen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = this.appName;
    data['package_name'] = this.packageName;
    data['expires_in'] = this.expiresIn;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['base_url'] = this.baseUrl;
    if (this.screens != null)
      data['screens'] = this.screens.map((v) => v.toJson()).toList();
    if (this.features != null)
      data['features'] = this.features.map((v) => v.toJson()).toList();
    if (this.permissions != null)
      data['permissions'] = this.permissions.map((v) => v.toJson()).toList();
    data['total_screen'] = this.totalScreen;
    return data;
  }
}

class ConfigItem {
  String key;
  dynamic value;

  ConfigItem({this.key, this.value});

  ConfigItem.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class ScreenItem {
  String name;
  bool enableScreen;
  List<ConfigItem> configs;

  ScreenItem({this.name, this.enableScreen, this.configs});

  ScreenItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    enableScreen = json['enable_screen'];
    if (json['configs'] != null) {
      configs = new List<ConfigItem>();
      json['configs'].forEach((v) {
        configs.add(new ConfigItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['enable_screen'] = this.enableScreen;
    if (this.configs != null) {
      data['configs'] = this.configs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeatureItem {
  String name;
  bool enableFeature = false;
  List<ConfigItem> configs;

  FeatureItem({this.name, this.enableFeature, this.configs});

  FeatureItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    enableFeature = json['enable_feature'];
    if (json['configs'] != null) {
      configs = new List<ConfigItem>();
      json['configs'].forEach((v) {
        configs.add(new ConfigItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['enable_feature'] = this.enableFeature;
    if (this.configs != null) {
      data['configs'] = this.configs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PermissionItem {
  String id;
  String name;
  String description;
  String displayName;

  PermissionItem({this.id, this.name, this.description, this.displayName});

  PermissionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['display_name'] = this.displayName;
    return data;
  }
}
