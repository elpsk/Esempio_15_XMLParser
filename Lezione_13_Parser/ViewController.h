//
//  ViewController.h
//  Lezione_13_Parser
//
//  Created by Alberto Pasca on 18/11/11.
//  Copyright (c) 2011 Cutaway SRL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSXMLParserDelegate> {
  
  NSXMLParser *myParser;
  
}

- (void) ParseWithTBXML;

@end
