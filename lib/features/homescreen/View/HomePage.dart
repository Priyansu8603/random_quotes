import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_quotes/Utils/AppColors.dart';
import 'package:random_quotes/Utils/utils.dart';

import '../ViewModel/HomePageViewModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Connectivity _connectivity = Connectivity();
  bool _isDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _handleConnectivityChange(result);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomePageViewModel>(context, listen: false).getRandomQuote();
    });
  }

  // connection status
  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _handleConnectivityChange(result,isInitialCheck: true);
  }

  // Handle changes
  void _handleConnectivityChange(ConnectivityResult result, {bool isInitialCheck = false}) {
    if (result == ConnectivityResult.none) {
      _showNoInternetDialog();
    } else {
      if (_isDialogOpen) {
        _closeDialog();
        _showInternetConnectedSnackbar();
      }
    }
  }


  void _showNoInternetDialog() {
    if (!_isDialogOpen) {
      _isDialogOpen = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: ()async=>false,
          child: AlertDialog(
            icon: Icon(Icons.signal_cellular_connected_no_internet_4_bar),
            title:Text('Oops!',style: TextStyle(fontFamily: "Poppins",color: AppColors.red,fontSize: 20),),
            content:Text('The internet is not connected.',style: TextStyle(fontFamily: "Poppins",color: AppColors.black54,fontSize: 15)),
            actions: [
              TextButton(
                onPressed: () {},
                child:Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _closeDialog() {
    if (_isDialogOpen) {
      Navigator.of(context).pop();
      _isDialogOpen = false;
    }
  }
  void _showInternetConnectedSnackbar() {
    Utils.showSnackBar(context, "Internet is Connected !!", AppColors.green);
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomePageViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'RANDOM QUOTES',
            style: TextStyle(
              color: AppColors.white,
              fontFamily: "Poppins",
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0XFFFFAFBD), Color(0XFFffc3a0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children:  [
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset('Core/Assets/images/right.png'),
                        ),
                        SizedBox(height: 20),
                        viewModel.isLoading
                            ? Center(
                          child: CircularProgressIndicator(
                            color: Color(0XFFFFAFBD),
                          ),
                        )
                            : Column(
                          children: [
                            Text(
                              viewModel.quote,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              '- ${viewModel.author}',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Poppins",
                                color: AppColors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset('Core/Assets/images/left.png'),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:75),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                        onPressed: () => viewModel.getRandomQuote(),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0XFFEF9A9A),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.white,width: 1.5),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Get Quotes',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
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
