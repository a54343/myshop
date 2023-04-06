class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.label,
    required this.images,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
    required this.totalReview,
    required this.description,
    required this.price,
  });

  final int id;
  final String name;
  final String label;
  final List<String> images;
  final String rating;
  final int? totalReview;
  final String description;
  final double price;
  final String? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> images = (json['image'] as String).split(',');
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      images: images,
      price: json['price'].toDouble(),
      category: json['category'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      label: json['label'],
      totalReview:
          json['total_review'] != null ? int.parse(json['total_review']) : null,
      rating: json['avgrating'].toString(),
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'label': label,
        'images': images,
        'category': category,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'rating': rating,
        'totalReview': totalReview,
        'description': description,
        'price': price,
      };

  // static const List<ProductModel> productList = [
  //   ProductModel(
  //     id: 1,
  //     name: "Arcu facilisis tortor",
  //     label: "#best-seller",
  //     images: [
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //     ],
  //     rating: "4.8",
  //     totalReview: 250,
  //     description:
  //         "Varius ut mi hendrerit lorem etiam posuere vitae ut. Egestas amet proin a tristique suspendisse nibh. Commodo nec bibendum rhoncus justo. Aliquet sem adipiscing orci duis aliquet dolor massa. Cras est arcu vulputate enim ante. Lorem eros enim dolor id scelerisque pretium suspendisse duis. Quis purus sed donec pellentesque egestas in viverra. Pharetra nisl id nec tincidunt et turpis augue nunc. Nisl consequat diam enim lorem.",
  //     price: 499.99,
  //   ),
  //   ProductModel(
  //     id: 2,
  //     name: "Vivamus nec vel",
  //     label: "#populer",
  //     images: [
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //     ],
  //     rating: "4.8",
  //     totalReview: 250,
  //     description:
  //         "Varius ut mi hendrerit lorem etiam posuere vitae ut. Egestas amet proin a tristique suspendisse nibh. Commodo nec bibendum rhoncus justo. Aliquet sem adipiscing orci duis aliquet dolor massa. Cras est arcu vulputate enim ante. Lorem eros enim dolor id scelerisque pretium suspendisse duis. Quis purus sed donec pellentesque egestas in viverra. Pharetra nisl id nec tincidunt et turpis augue nunc. Nisl consequat diam enim lorem.",
  //     price: 499.99,
  //   ),
  //   ProductModel(
  //     id: 3,
  //     name: "Quis purus sed",
  //     label: "#best-rating",
  //     images: [
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //     ],
  //     rating: "5.0",
  //     totalReview: 250,
  //     description:
  //         "Varius ut mi hendrerit lorem etiam posuere vitae ut. Egestas amet proin a tristique suspendisse nibh. Commodo nec bibendum rhoncus justo. ",
  //     price: 499.99,
  //   ),
  //   ProductModel(
  //     id: 4,
  //     name: "Arcu facilisis tortor",
  //     label: "#best-seller",
  //     images: [
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //     ],
  //     rating: "4.8",
  //     totalReview: 250,
  //     description:
  //         "Varius ut mi hendrerit lorem etiam posuere vitae ut. Egestas amet proin a tristique suspendisse nibh. Commodo nec bibendum rhoncus justo. Aliquet sem adipiscing orci duis aliquet dolor massa. Cras est arcu vulputate enim ante. Lorem eros enim dolor id scelerisque pretium suspendisse duis. Quis purus sed donec pellentesque egestas in viverra. Pharetra nisl id nec tincidunt et turpis augue nunc. Nisl consequat diam enim lorem.",
  //     price: 499.99,
  //   ),
  //   ProductModel(
  //     id: 5,
  //     name: "Vivamus nec vel",
  //     label: "#populer",
  //     images: [
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //     ],
  //     rating: "4.8",
  //     totalReview: 250,
  //     description:
  //         "Varius ut mi hendrerit lorem etiam posuere vitae ut. Egestas amet proin a tristique suspendisse nibh. Commodo nec bibendum rhoncus justo. Aliquet sem adipiscing orci duis aliquet dolor massa. Cras est arcu vulputate enim ante. Lorem eros enim dolor id scelerisque pretium suspendisse duis. Quis purus sed donec pellentesque egestas in viverra. Pharetra nisl id nec tincidunt et turpis augue nunc. Nisl consequat diam enim lorem.",
  //     price: 499.99,
  //   ),
  //   ProductModel(
  //     id: 6,
  //     name: "Quis purus sed",
  //     label: "#best-rating",
  //     images: [
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //       "https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/products/white-926838_1920.jpg",
  //     ],
  //     rating: "5.0",
  //     totalReview: 250,
  //     description:
  //         "Varius ut mi hendrerit lorem etiam posuere vitae ut. Egestas amet proin a tristique suspendisse nibh. Commodo nec bibendum rhoncus justo. Aliquet sem adipiscing orci duis aliquet dolor massa. Cras est arcu vulputate enim ante. Lorem eros enim dolor id scelerisque pretium suspendisse duis. Quis purus sed donec pellentesque egestas in viverra. Pharetra nisl id nec tincidunt et turpis augue nunc. Nisl consequat diam enim lorem.",
  //     price: 499.99,
  //   ),
  // ];
}
