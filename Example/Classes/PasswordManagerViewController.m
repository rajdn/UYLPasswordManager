//
//  PasswordManagerViewController.m
//  Created by Keith Harrison on 23-May-2011 http://useyourloaf.com
//  Copyright (c) 2011 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  Neither the name of Keith Harrison nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 

#import "PasswordManagerViewController.h"
#import "UYLPasswordManager.h"

@implementation PasswordManagerViewController

@synthesize pmLabel=_pmLabel;
@synthesize username=_username;

#pragma mark -
#pragma mark === Initialization and shutdown ===
#pragma mark -

- (void)viewDidLoad {

    UYLPasswordManager *manager = [UYLPasswordManager sharedInstance];
    // manager.accessMode = UYLPMAccessibleAlways;
    [manager registerKey:@"secret" forIdentifier:@"manager"];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.pmLabel = nil;
    self.username = nil;
}

- (void)dealloc {
    [_username release];
    [_pmLabel release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark === Text field delegate methods ===
#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	self.pmLabel.hidden = NO;
	[textField resignFirstResponder];
	
    NSString *identifier = self.username.text;
    NSString *key = textField.text;
    
    if (identifier) {
        UYLPasswordManager *manager = [UYLPasswordManager sharedInstance];
        if ([manager validKey:key forIdentifier:identifier]) {
        	self.pmLabel.text = @"Success";
        } else {
            self.pmLabel.text = @"Failed!";
        }
    }
    
	return YES;
}

@end
