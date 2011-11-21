//
//  ViewController.m
//  Lezione_13_Parser
//
//  Created by Alberto Pasca on 18/11/11.
//  Copyright (c) 2011 Cutaway SRL. All rights reserved.
//

#import "ViewController.h"

#import "TBXML.h"
#import "XPathQuery.h"

@implementation ViewController

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
     
  //
  // APPLE DEFAULT PARSER
  //
  NSURL *xmlURL = [NSURL URLWithString:@"http://myurl.xml"];
  myParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];  
  [myParser setDelegate:self];  
  [myParser parse];  

  //
  // TBXML
  //
  [self ParseWithTBXML];
  
  //
  // XPATH
  //
  NSData *doc = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://myurl.xml"]];
  NSMutableArray *xp = [NSMutableArray array];
  
  [xp addObject:PerformXMLXPathQuery(doc, @"//com")];
  [xp addObject:PerformXMLXPathQuery(doc, @"//topo")];

  NSLog(@"DATA: %@", xp);

}

- (void) dealloc {
  [myParser release];
  
  [super dealloc];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark PARSER_DELEGATE

- (void) parserDidStartDocument: (NSXMLParser *) parser {
  
}

- (void) parser: (NSXMLParser *) parser parseErrorOccurred: (NSError *) parseError {
  NSLog(@"Errore nel parser!");
}

- (void) parser: (NSXMLParser *) parser didStartElement: (NSString *) elementName 
   namespaceURI: (NSString *) namespaceURI 
  qualifiedName: (NSString *) qName 
     attributes: (NSDictionary *) attributeDict {
  
  NSLog(@"ELEMENT   : %@", elementName);
  NSLog(@"ATTRIBUTES: %@", attributeDict);
  
}

- (void) parser: (NSXMLParser *) parser didEndElement: (NSString *) elementName 
   namespaceURI: (NSString *) namespaceURI 
  qualifiedName: (NSString *) qName {
  
  NSLog(@"ELEMENT   : %@", elementName);

}

- (void) parser: (NSXMLParser *) parser foundCharacters: (NSString *) string {

  NSLog(@"STRING : %@", string);

}

- (void) parserDidEndDocument: (NSXMLParser *)parser { 
  
}

#pragma mark TBXML

- (void) ParseWithTBXML {
  
  NSString *xml = [NSString stringWithContentsOfURL:
                   [NSURL URLWithString:@"http://myurl.xml"] 
                                           encoding:NSUTF8StringEncoding error:nil];
  
  TBXML *doc = [TBXML tbxmlWithXMLString:xml];
  
  TBXMLElement *node = [TBXML childElementNamed:@"nodes" parentElement:doc.rootXMLElement];
  while ( node ) {

    TBXMLElement *com  = [TBXML childElementNamed:@"com"  parentElement:node];
    TBXMLElement *topo = [TBXML childElementNamed:@"topo" parentElement:node];

    NSLog(@"----------");
    NSLog(@"com  : %@", [TBXML textForElement:com]);
    NSLog(@"topo : %@", [TBXML textForElement:topo]);
    NSLog(@"----------");

    node = [TBXML nextSiblingNamed:@"nodes" searchFromElement:node];
  }
  
}

@end
