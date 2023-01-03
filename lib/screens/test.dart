 


/*
     FutureBuilder<List<Data>>(
        future: DataProvider().getDatas(),
          builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            return Expanded(
              child: SizedBox(
              height: 200,
              child: Row(
              children: [
                ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  final alldata = data[index];
                  return Text(alldata.name);
                })
                
                ],
              ),
            ));

              //return  Text("data!.length.toString()");
          }
          return const Text("Ther is no data");
        },
      ),
                                



         Card(
         shape: RoundedRectangleBorder(
             borderRadius:
                 BorderRadius.circular(8)),
         child: RoundedExpansionTile(
           leading: Image.asset(
               'assets/images/blå.png'),
           shape: RoundedRectangleBorder(
               borderRadius:
                   BorderRadius.circular(10)),
           title: Text('Data 1'),
           subtitle: isExpanded
               ? Text("Alarm")
               : null,
           children: [
             Row(children: const [
               SizedBox(width: 200),
               Text("Alarm"),
               SizedBox(
                 width: 20,
               ),
               Text("Favorite"),
             ]),
             Row(
               mainAxisAlignment:
                   MainAxisAlignment
    .spaceBetween,
               children: [
                 Expanded(
                 child: SizedBox(
                 height: 200,
                   child: FutureBuilder(
    future: DefaultAssetBundle
      .of(context)
  .loadString(
      'assets/loadjson/item_data.json'),
    builder: (context,
  snapshot) {
      // var new_data = json.decode(
      //     snapshot.data.toString());

      // bool isSaved =
      //  savedWords
      //     .contains(new_data);

      return ListView
    .builder(
  itemBuilder:(BuildContext context, int index) {
    String word = words[index];
    bool isSaved =savedWords.contains( word);

    return Card(child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
    const SizedBox(width:20,),
    const Icon(Icons.dashboard),
    SizedBox(width:20,),
    Text( word),
    SizedBox(width:110,),
    Text("23"),
    SizedBox(width:30,),
    IconButton(
      onPressed:
          () {
        setState(() {if (isSaved) {
            savedWords.remove(word);
          } else {
            savedWords.add(word);}
        });
      },
      icon:Icon(
        isSaved ? Icons.star : Icons.star_border,
        color: isSaved ? Color.fromARGB(255, 238, 234, 14) : null,
      ),
    ),

    //       SizedBox(
    //         width: 200,

    //      child: ListTile(
    //         title: Text(new_data[index]['item_name']),

    //         trailing:

    // onTap: () {

    //       ),
    //       )
  ],
          )
        ],
      ),
    );
  },
  itemCount: words == null? 0: words.length,);
    }),
                 ))
               ],
             ),
           ],
         ),
       );



FutureBuilder<List<Data>>(
                              future: DataProvider().getDatas(),
                              
                              builder: (context, snapshot) {
                                
                                final data = snapshot.data;
                                if (snapshot.hasData) {
                                  return Row(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: RoundedExpansionTile(
                                          leading: Image.asset(
                                              'assets/images/blå.png'),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          title: Text('Data 1'),
                                          subtitle:
                                              isExpanded ? Text("Alarm") : null,
                                          children: [
                                            Row(children: const [
                                              SizedBox(width: 200),
                                              Text("Alarm"),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text("Favorite"),
                                            ]),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    child: SizedBox(
                                                  height: 200,
                                                  child: FutureBuilder(
                                                      future: DefaultAssetBundle
                                                              .of(context)
                                                          .loadString(
                                                              'assets/loadjson/item_data.json'),
                                                      builder:
                                                          (context, snapshot) {
                                                        // var new_data = json.decode(
                                                        //     snapshot.data.toString());

                                                        // bool isSaved =
                                                        //  savedWords
                                                        //     .contains(new_data);

                                                        return ListView.builder(
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            String word =
                                                                words[index];
                                                            physics:
                                                            NeverScrollableScrollPhysics();
                                                            shrinkWrap:
                                                            true;
                                                            bool isSaved =
                                                                savedWords
                                                                    .contains(
                                                                        word);

                                                            return Card(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .stretch,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      const SizedBox(
                                                                        width:
                                                                            20,
                                                                      ),
                                                                      const Icon(
                                                                          Icons
                                                                              .dashboard),
                                                                      SizedBox(
                                                                        width:
                                                                            20,
                                                                      ),
                                                                      Text(
                                                                          word),
                                                                      SizedBox(
                                                                        width:
                                                                            110,
                                                                      ),
                                                                      Text(
                                                                          "23"),
                                                                      SizedBox(
                                                                        width:
                                                                            30,
                                                                      ),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            if (isSaved) {
                                                                              savedWords.remove(word);
                                                                            } else {
                                                                              savedWords.add(word);
                                                                            }
                                                                          });
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          isSaved
                                                                              ? Icons.star
                                                                              : Icons.star_border,
                                                                          color: isSaved
                                                                              ? Color.fromARGB(255, 238, 234, 14)
                                                                              : null,
                                                                        ),
                                                                      ),

                                                                      //       SizedBox(
                                                                      //         width: 200,

                                                                      //      child: ListTile(
                                                                      //         title: Text(new_data[index]['item_name']),

                                                                      //         trailing:

                                                                      // onTap: () {

                                                                      //       ),
                                                                      //       )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          itemCount: words ==
                                                                  null
                                                              ? 0
                                                              : words.length,
                                                        );
                                                      }),
                                                ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      )

                                      // ListView.builder(
                                      // itemCount: data!.length,
                                      // itemBuilder: (context, index) {
                                      //   final alldata = data[index];
                                      //   return Text(alldata.name);
                                      // })
                                    ],
                                  );

                                  //return  Text("data!.length.toString()");
                                }
                                return const Text("Ther is no data");
                              },
                            ),
                         
*/