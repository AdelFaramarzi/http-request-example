import 'package:flutter/material.dart';
import 'package:products/api/api_service.dart';
import 'package:products/component/product_cart.dart';
import 'package:products/model/product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  List<Products> _products = [];
  int _currentPage = 1;
  bool _streamView = true;
  bool _isLoading = true;
  ScrollController _listScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _getProducts();

    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;

      if (maxScroll - currentScroll <= 300) {
        if (!_isLoading) {
          _getProducts(page: _currentPage + 1);
        }
      }
    });
  }

  _getProducts({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await ProductService.getProducts(page);

    setState(() {
      if (refresh) _products.clear();
      _products.addAll(response['products']);
      _currentPage = response['current_page'];
      _isLoading = false;
    });
  }

  Widget loadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget listIsEpity() {
    return Center(
      child: new Text("محصولی برای نمایش وجود ندارد"),
    );
  }

  Future<Null> _handlerRefresh() async {
    await _getProducts(refresh: true);
    return null;
  }

  Widget steamListView() {
    return _products.length == 0 && _isLoading
        ? loadingView()
        : _products.length == 0
            ? listIsEpity()
            : RefreshIndicator(
                child: ListView.builder(
                    // padding: const EdgeInsets.only(top: 0),
                    itemCount: _products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCart(
                        products: _products[index],
                      );
                    }),
                onRefresh: _handlerRefresh,
              );
  }

  Widget grideView() {
    return _products.length == 0 && _isLoading
        ? loadingView()
        : _products.length == 0
            ? listIsEpity()
            : RefreshIndicator(
                child: GridView.builder(
                  itemCount: _products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, index) {
                    return ProductCart(
                      products: _products[index],
                    );
                  },
                ),
                onRefresh: _handlerRefresh,
              );
  }

  Widget headList() {
    return SliverAppBar(
      pinned: false,
      primary: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _streamView = true;
              });
            },
            child: new Icon(
              Icons.view_stream,
              color: _streamView ? Colors.grey[900] : Colors.grey[500],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _streamView = false;
              });
            },
            child: new Icon(
              Icons.view_module,
              color: _streamView ? Colors.grey[500] : Colors.grey[900],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("محصولات"),
        ),
        body: NestedScrollView(
          controller: _listScrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return _products.length != 0 ? <Widget>[headList()] : [];
          },
          body: _streamView ? steamListView() : grideView(),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
