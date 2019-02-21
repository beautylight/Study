#Let's Flutter


Alert Dialog
~~~dart
    return AlertDialog(
      title: new Text("Alert Dialog title"),
      content: new Text("Alert Dialog body"),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
~~~