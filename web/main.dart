// Copyright (c) 2017, Alex. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

TableSectionElement tbody;
List<bool> ascending = [true, true, true, true, true];

void main() {
  Element inputRow=querySelector('#inputFields');
  TableElement table=querySelector('#MovieTable');
  tbody=table.createTBody();
  inputRow.onKeyPress.listen(handleKeyEvent);
  querySelector('#sortTitle').onClick.listen((e)=>sortStringColumn(0));
  querySelector('#sortDirector').onClick.listen((e)=>sortStringColumn(1));
  querySelector('#sortYear').onClick.listen((e)=>sortNumColumn(2));
  querySelector('#sortRuntime').onClick.listen((e)=>sortNumColumn(3));
  querySelector('#sortfsk').onClick.listen((e)=>sortNumColumn(4));
  addMovieToTable(new Movie("Pulp Fiction","Quentin Tarantino","1994","148","16"));
  addMovieToTable(new Movie("Inglorious","Quentin Tarantino","2009","148","16"));
  addMovieToTable(new Movie("Reservoir Dogs","Quentin Tarantino","1992","100","18"));
  sortNumColumn(2);
}

void sortStringColumn(int index) {
  List<TableRowElement> sortedRows = new List<TableRowElement>();
  sortedRows.addAll(tbody.rows);
  sortedRows.sort((TableRowElement a, TableRowElement b) {
    if (ascending[index]) {
      return a.cells[index].text.compareTo(b.cells[index].text);
    }
    else {
      return a.cells[index].text.compareTo(b.cells[index].text) * -1;
    }
  });
  tbody.children=sortedRows;
  ascending[index]=!ascending[index];
}

void sortNumColumn(int index) {
  List<TableRowElement> sortedRows = new List<TableRowElement>();
  sortedRows.addAll(tbody.rows);
  sortedRows.sort((TableRowElement a, TableRowElement b) {
    if (ascending[index]) {
      return num.parse(a.cells[index].text).compareTo(
          num.parse(b.cells[index].text));
    }
    else {
      return num.parse(a.cells[index].text).compareTo(
          num.parse(b.cells[index].text)) * -1;
    }
  });
  tbody.children=sortedRows;
  ascending[index]=!ascending[index];
}


void addMovieToTable(Movie movie){
  TableRowElement row=tbody.addRow();
  row.insertCell(0).text=movie.title;
  row.insertCell(1).text=movie.director;
  row.insertCell(2).text=movie.year;
  row.insertCell(3).text=movie.runtime;
  row.insertCell(4).text=movie.fsk;
  AnchorElement link=new AnchorElement();
  link.text='X';
  link.setAttribute("style","width:15px; text-align:center; cursor: pointer;");
  link.onClick.listen((e){
    row.remove();
  });
  row.insertCell(5).children.add(link);
}

class Movie{
  String title;
  String director;
  String year;
  String runtime;
  String fsk;

  Movie(String title, String director, String year, String runtime, String fsk){
     this.title=title;
     this.director=director;
     this.year=year;
     this.runtime=runtime;
     this.fsk=fsk;
  }
}

void handleKeyEvent(KeyboardEvent event) {
  KeyEvent keyEvent = new KeyEvent.wrap(event);
  if (keyEvent.keyCode == KeyCode.ENTER) {
    String title=(querySelector('#title')as InputElement).value;
    String director=(querySelector('#director')as InputElement).value;
    String year=(querySelector('#year')as InputElement).value;
    String runtime=(querySelector('#runtime')as InputElement).value;
    String fsk=(querySelector('#fsk')as InputElement).value;
    addMovieToTable(new Movie(title,director,year,runtime,fsk));
  }
}
