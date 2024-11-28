class CustomLoader{
  final bool dismissible;
  final BuildContext context;
  bool isShowing = false;

  CustomLoader({required this.context, required this.dismissible});

  void show(){
    if(!isShowing){
      showGeneralDialog(
        context: context,
        barrierDismissible: dismissible,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder: (context, animation, secondaryAnimation) {
          return  CustomLoaderUI(dismissible: dismissible,);
        },
      );
      isShowing = true;
    }
  }

  void dismiss(){
    if(isShowing){
      Navigator.of(context, rootNavigator: true).pop();
      isShowing = false;
    }
  }
}


class CustomLoaderUI extends StatelessWidget {
  final bool dismissible;
  const CustomLoaderUI({super.key,required this.dismissible});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => dismissible ? true : false,
      canPop: dismissible ? true : false,
      child: Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: Colors.grey,
          secondRingColor: Colors.grey.withOpacity(0.6),
          thirdRingColor: Colors.grey.withOpacity(0.4),
          size: 25.h
        ),
      ),
    );
  }
}

