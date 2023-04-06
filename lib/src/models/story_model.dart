class StoryModel {
  const StoryModel({required this.cateorgy});

  final String cateorgy;

  static const List<StoryModel> storyList = [
    StoryModel(cateorgy: "手机"),
    StoryModel(cateorgy: "男装"),
    StoryModel(cateorgy: "女装"),
    StoryModel(cateorgy: "鞋包"),
    StoryModel(cateorgy: "电器"),
    StoryModel(cateorgy: "百货"),
    StoryModel(cateorgy: "洗护"),
  ];
}
