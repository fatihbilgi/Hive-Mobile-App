import 'package:flutter/material.dart';
import './extensions.dart';


class GlobalErrorWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  final String errorMsg;

  const GlobalErrorWidget({required this.onRefresh,required this.errorMsg}) : super();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: InkWell(
          onTap: onRefresh,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.refresh, size: 36, color: Colors.black54),
                12.h,
                buildErrorTitle,
                8.h,
                buildErrorMsg(),
                8.h,
                if (errorMsg != null && errorMsg != '') buildDynamicErrorMsg(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text buildDynamicErrorMsg() {
    return Text(
      '${errorMsg.toUpperCase()}',
      style: TextStyle(fontSize: 10, color: Colors.black26),
      textScaleFactor: 1,
      maxLines: 5,
      textAlign: TextAlign.center,
    );
  }

  Text get buildErrorTitle => Text('Hata!', textScaleFactor: 1, textAlign: TextAlign.center, style: TextStyle(fontSize: 22, color: Colors.black54));

  Text buildErrorMsg() {
    return Text(
      'Bir hata oluştu, buraya dokunarak sayfayı tekrar yüklemeyi deneyin.',
      textScaleFactor: 1,
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black45),
    );
  }
}
