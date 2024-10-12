import 'package:flutter/material.dart';
import 'package:mansi_beauty_store/HomeScreen/Admin_Dashboard.dart';
import 'package:mansi_beauty_store/Others/BottonNavigation.dart';
import 'package:mansi_beauty_store/auth/User_Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  List _filteredProducts = [];
  bool _isLoggedIn = false;

  List<String> _images = [
    'assets/slider_image1.jpg',
    'assets/slider_image2.jpg',
    'assets/slider_image3.jpg',
  ];

  List<Map<String, dynamic>> _Products = [
    {
      'id': 1,
      'image': 'assets/Face_Wash.jpg',
      'title': 'Face Wash',
      'category': 'Skin Care',
      'price': 49.99,
    },
    {
      'id': 2,
      'image': 'assets/suncream.jpg',
      'title': 'Sunscreen',
      'category': 'Skin Care',
      'price': 69.99,
    },
    {
      'id': 3,
      'image': 'assets/Face_cream.jpg',
      'title': 'Face Cream',
      'category': 'Skin Care',
      'price': 79.99,
    },
    {
      'id': 4,
      'image': 'assets/Lotions.jpg',
      'title': 'Lotions',
      'category': 'Skin Care',
      'price': 39.99,
    },
    {
      'id': 5,
      'image': 'assets/shampoo.jpg',
      'title': 'Shampoo',
      'category': 'Hair Care',
      'price': 119.99,
    },
    {
      'id': 6,
      'image': 'assets/Hair_oil.jpg',
      'title': 'Hair Oil',
      'category': 'Hair Care',
      'price': 229.99,
    },
    {
      'id': 7,
      'image': 'assets/Hair_Serum.jpg',
      'title': 'Hair Serum',
      'category': 'Hair Care',
      'price': 99.99,
    },
    {
      'id': 8,
      'image': 'assets/Conditioner.jpg',
      'title': 'Conditioner',
      'category': 'Hair Care',
      'price': 69.99,
    },
    {
      'id': 9,
      'image': 'assets/Foundation.jpg',
      'title': 'Foundation',
      'category': 'Beauty',
      'price': 149.99,
    },
    {
      'id': 10,
      'image': 'assets/Liptick.jpg',
      'title': 'Liptick',
      'category': 'Beauty',
      'price': 89.99,
    },
    {
      'id': 11,
      'image': 'assets/kajal.jpg',
      'title': 'Kajal',
      'category': 'Beauty',
      'price': 39.99,
    },
    {
      'id': 12,
      'image': 'assets/Lakme.jpg',
      'title': 'Lakeme',
      'category': 'Beauty',
      'price': 169.99,
    },
    // Add other products here...
  ];

  @override
  void initState() {
    super.initState();
    _filteredProducts = _Products;
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
        break;
      case 2:
      // You can add navigation logic for other pages here.
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
    }
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Please login to view product details"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserLoginPage()),
              );
            },
            child: Text("Login"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF1694),
        title: Text(
          "Mansi Beauty Store",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: () {
                  if (_isLoggedIn) {
                    _logout();
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserLoginPage()),
                    );
                  }
                },
                icon: Icon(
                  _isLoggedIn ? Icons.logout : Icons.person,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFdcb7b4),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Mansi Beauty Store',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage(products: _Products,
                              onProductAdded: (products){
                            setState(() {
                              _Products = products;
                              _filteredProducts = products;
                            });
                          },)),
                );
              },
              child: Text('Add Product'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateProductPage(products: _Products,
                    onProductUpdated: (products){
                      setState(() {
                        _Products = products;
                        _filteredProducts = products;
                      });
                    },)),
                );
              },
              child: Text('Update Product'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeleteProductPage(products: _Products,
                    onProductDeleted: (products){
                      setState(() {
                        _Products = products;
                        _filteredProducts = products;
                      });
                    },)),
                );
              },
              child: Text('Delete Product'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search Products',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(border: Border.all()),
                    child: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('All Category'),
                          onTap: () {
                            setState(() {
                              _filteredProducts = _Products;
                            });
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Skin Care'),
                          onTap: () {
                            _filteredProducts = _Products
                                .where(
                                    (product) => product['category'] == 'Skin Care')
                                .toList();
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Hair Care'),
                          onTap: () {
                            _filteredProducts = _Products
                                .where(
                                    (product) => product['category'] == 'Hair Care')
                                .toList();
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Beauty'),
                          onTap: () {
                            setState(() {
                              _filteredProducts = _Products
                                  .where(
                                      (product) => product['category'] == 'Beauty')
                                  .toList();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(border: Border.all()),
                  child: PopupMenuButton(
                    icon: Icon(Icons.sort),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('Sort by ID (Desc)'),
                        onTap: () {
                          setState(() {
                            _Products.sort((a, b) => b['id'].compareTo(a['id']));
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Sort by ID (Asc)'),
                        onTap: () {
                          setState(() {
                            _Products.sort((a, b) => a['id'].compareTo(b['id']));
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Sort by Price (Low to High)'),
                        onTap: () {
                          setState(() {
                            _Products.sort(
                                    (a, b) => a['price'].compareTo(b['price']));
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Sort by Price (High to Low)'),
                        onTap: () {
                          setState(() {
                            _Products.sort(
                                    (a, b) => b['price'].compareTo(a['price']));
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: _images.map((image) => Image.asset(image)).toList(),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Product Options'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateProductPage(
                                    products: _Products,
                                    onProductUpdated: (products) {
                                      setState(() {
                                        _Products = products;
                                        _filteredProducts = products;
                                      });
                                    },
                                    productId: _filteredProducts[index]['id'],
                                  ),
                                ),
                              );
                            },
                            child: Text('Update'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _Products.removeWhere(
                                      (product) => product['id'] == _filteredProducts[index]['id'],
                                );
                                _filteredProducts.removeWhere(
                                      (product) => product['id'] == _filteredProducts[index]['id'],
                                );
                              });
                              Navigator.pop(context);
                            },
                            child: Text('Delete'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey, width: 2.0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              _filteredProducts[index]['image'],
                              height: 100,
                              width: 120,
                            ),
                          ),
                          Text(
                            _filteredProducts[index]['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '₹${_filteredProducts[index]['price'].toString()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    setState(() {
      _isLoggedIn = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserLoginPage()),
    );
  }
}

class AddProductPage extends StatefulWidget {
  List<Map<String, dynamic>> products;
  final Function onProductAdded;

  AddProductPage({required this.products, required this.onProductAdded});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dimensionsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String description = _descriptionController.text;
      String category = _categoryController.text;
      double price = double.parse(_priceController.text);

      setState(() {
        widget.products.add({
          'id': widget.products.length + 1,
          'image': 'assets/Face_Wash.jpg', // Default image
          'title': title,
          'description': description,
          'category': category,
          'quantity': int.parse(_quantityController.text),
          'weight': double.parse(_weightController.text),
          'dimensions': _dimensionsController.text,
          'price': price,
        });
      });
      widget.onProductAdded(widget.products);
      Navigator.pop(context);
      // Here, you would send the data to your backend or database.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Product Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration:
                  InputDecoration(labelText: 'Product Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a quantity';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the weight';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dimensionsController,
                  decoration: InputDecoration(labelText: 'Dimensions (cm)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the dimensions';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price (₹)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _addProduct,
                    child: Text('Add Product'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateProductPage extends StatefulWidget {
  List<Map<String, dynamic>> products;
  final Function onProductUpdated;
  final int? productId;

  UpdateProductPage({
    required this.products,
    required this.onProductUpdated,
    this.productId,
  });

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dimensionsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _image;

  int? _productId;

  @override
  @override
  void initState() {
    super.initState();
    _productId = widget.productId;
    if (_productId != null) {
      final product = widget.products.firstWhere(
            (product) => product['id'] == _productId,
      );
      _titleController.text = product['title'] ?? '';
      _descriptionController.text = product['description'] ?? '';
      _categoryController.text = product['category'] ?? '';
      _quantityController.text = product['quantity'].toString() ?? '';
      _weightController.text = product['weight'].toString() ?? '';
      _dimensionsController.text = product['dimensions'].toString() ?? '';
      _priceController.text = product['price'].toString() ?? '';
    }
  }

  Future<void> _openImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _updateProduct() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String description = _descriptionController.text;
      String category = _categoryController.text;
      double price = double.parse(_priceController.text);

      setState(() {
        widget.products[_productId!] = {
          'id': _productId,
          'image': _image != null ? _image!.path : widget.products[_productId!]['image'],
          'title': title,
          'description': description,
          'category': category,
          'quantity': int.parse(_quantityController.text),
          'weight': double.parse(_weightController.text),
          'dimensions': _dimensionsController.text,
          'price': price,
        };
      });
      widget.onProductUpdated(widget.products);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Product Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration:
                  InputDecoration(labelText: 'Product Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a quantity';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the weight';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dimensionsController,
                  decoration: InputDecoration(labelText: 'Dimensions (cm)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the dimensions';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price (₹)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(_image!, height: 200),
                ),
                ElevatedButton(
                  onPressed: _openImagePicker,
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 20),
                Center(
                  child : ElevatedButton(
                    onPressed: _updateProduct,
                    child: Text('Update Product'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteProductPage extends StatefulWidget {
  List<Map<String, dynamic>> products;
  final Function onProductDeleted;

  DeleteProductPage({required this.products, required this.onProductDeleted});

  @override
  _DeleteProductPageState createState() => _DeleteProductPageState();
}

class _DeleteProductPageState extends State<DeleteProductPage> {
  int? _productId;

  @override
  void initState() {
    super.initState();
    _productId = widget.products.length + 1;
  }

  void _deleteProduct() {
    setState(() {
      widget.products.removeAt(_productId! - 1);
    });
    widget.onProductDeleted(widget.products);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Are you sure you want to delete this product?'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _deleteProduct,
                child: Text('Delete Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:mansi_beauty_store/HomeScreen/Admin_Dashboard.dart';
import 'package:mansi_beauty_store/MaterialScreens/ProductDetails.dart';
import 'package:mansi_beauty_store/Modules/Products_Model.dart';
import 'package:mansi_beauty_store/Others/BottonNavigation.dart';
import 'package:mansi_beauty_store/auth/User_Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  List _filteredProducts = [];
  bool _isLoggedIn = false;

  List<String> _images = [
    'assets/slider_image1.jpg',
    'assets/slider_image2.jpg',
    'assets/slider_image3.jpg',
  ];

  List<Product> _Products = []; // Change this to List<Product>

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filteredProducts = _Products;
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  void _onTap(int index){
    setState(() {
      _currentIndex=index;
    });
    switch(index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()),);
      case 1:
        Navigator.push(context,
          MaterialPageRoute(builder: (context)=>AdminDashboard()),);
      case 2:
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductPage(products: _Products)),);
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()),);
    }
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Please login to view product details"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserLoginPage()),
              );
            },
            child: Text("Login"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF1694),
        title: Text("Mansi Beauty Store",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white),),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(onPressed: () {
                if (_isLoggedIn) {
                  _logout();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserLoginPage()),
                  );
                }
              },  icon: Icon(
                _isLoggedIn ? Icons.logout : Icons.person,
                color: Colors.black87,
              ),),
            ),
          ),

        ],

      ),
      drawer: Drawer(
        child: ListView (
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                //image: DecorationImage(image: AssetImage('assets/drawer.jpg'), fit: BoxFit.cover),
                color: Color(0xFFdcb7b4),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text('Mansi Beauty Store',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage(products: _Products)),
                );
                setState(() {});*/
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Search Products',
                        hintStyle: TextStyle(color: Colors.grey)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        border: Border.all()
                    ),
                    child: PopupMenuButton(itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('All Category'),
                        onTap: () {
                          setState(() {
                            _filteredProducts=_Products;
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Skin Care'),
                        onTap: () {
                          _filteredProducts = _Products.where((product) => product.category == 'Skin Care').toList();
                        },
                      ),
                      PopupMenuItem(
                        child: Text(' Hair Care'),
                        onTap: () {
                          _filteredProducts = _Products.where((product) => product.category == 'Hair Care').toList();
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Beauty'),
                        onTap: () {
                          setState(() {
                            _filteredProducts = _Products.where((product) => product.category == 'Beauty').toList();
                          });
                        },
                      ),
                    ],),
                  ),
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: PopupMenuButton(
                    icon: Icon(Icons.sort),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('Sort by ID (Desc)'),
                        onTap: () {
                          setState(() {
                            _Products.sort((a, b) => b.id.compareTo(a.id));
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Sort by ID (Asc)'),
                        onTap: () {
                          setState(() {
                            _Products.sort((a, b) => a.id.compareTo(b.id));
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Sort by ID (Low Price)'),
                        onTap: () {
                          setState(() {
                            _Products.sort((a, b) => a.price.compareTo(b.price));
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text('Sort by ID (High Price)'),
                        onTap: () {
                          setState(() {
                            _Products.sort((a, b) => b.price.compareTo(a.price));
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: _images.map((image) => Image.asset(image)).toList(),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
            ),
          ),
          SizedBox(height: 12,),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    if (_isLoggedIn) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Productdetail(_filteredProducts[index].id)),
                      );
                    } else {
                      _showLoginDialog();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey, width: 2.0),
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                child: Image.asset(_filteredProducts[index].image, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              _filteredProducts[index].title,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis ,
                            ),
                          ),
                          Text(
                            _filteredProducts[index].category,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${_filteredProducts[index].price}/-',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                            ),
                          ),
                          //Text(_filteredProducts[index].description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12)),
                          Opacity(
                            opacity: 0.0, // Make the ID text invisible
                            child: Text('ID: ${_filteredProducts[index].id}', style: TextStyle(fontSize: 12)),
                          ),
                          //Text('ID: ${_filteredProducts[index].id}', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: _currentIndex, onTap: _onTap),
    );
  }
  _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    setState(() {
      _isLoggedIn = false;
    });
  }
}*/


