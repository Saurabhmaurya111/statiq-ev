import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  final Icon icon;
  final String text;
  final String subtext;
  final Icon? optionalicon ;
  const TextBox({
    super.key,
    required this.icon,
    required this.text,
    required this.subtext,  this.optionalicon,
  });

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // flex: 2,
      child: Container(
        width: double.infinity / 2,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
           boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 6, // Blur radius
              offset: Offset(0, 3), // Changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.only(left: 5, bottom: 10, top: 15),
        margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          widget.icon,
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.blue[900],),
                  ),
                  Text(widget.subtext , style: TextStyle( color: Colors.blue[900],),),
                ],
              ),
            ),
            if(widget.optionalicon != null)
            IconButton(
              onPressed: () {},
              icon: widget.optionalicon!,
              iconSize: 12,

            ),
            
          ],
        ),
      ),
    );
  }
}
