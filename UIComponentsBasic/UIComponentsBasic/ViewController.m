//
//  ViewController.m
//  UIComponentsBasic
//
//  Created by komal lunkad on 15/09/16.
//  Copyright © 2016 komal lunkad. All rights reserved.
//

#import "ViewController.h"
#import "Products.h"
NSMutableArray *products;
@interface ViewController ()
{
    
    IBOutlet UITextField *textFieldProductName;
    
    IBOutlet UITextField *textFieldProductPrice;
    
    IBOutlet UITextField *textFieldProductCategory;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    products=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isWhitespace:(NSString*)name{
    NSString *trimmedName=[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(trimmedName.length==0){
        return NO;
    }
    return YES;
}
-(BOOL)isAlphaOnly:(NSString *)input
{
    NSString *regExp = @"[a-zA-Z]+";
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [regexTest evaluateWithObject:input];
}
-(BOOL)isNumericOnly:(NSString *)input
{
    NSString *regExp = @"[0-9]{2,5}[.]{0,1}[0-9]{0,2}";
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [regexTest evaluateWithObject:input];
}
- (IBAction)buttonAddTapped:(id)sender {
    NSString *productName=textFieldProductName.text;
    float productPrice=[textFieldProductPrice.text floatValue];
    NSString *productCategory=textFieldProductCategory.text;
    
    Products *product=[[Products alloc]init];
    product.productName=productName;
    product.productPrice=productPrice;
    product.productCategory=productCategory;
    
    [products addObject:product];
    
    for( product in products){
         NSLog(@"Product Name is %@ ,product price is %.02f and product category is %@",product.productName,product.productPrice,product.productCategory);
    }
    
    if([self isAlphaOnly:productName]==NO || [self isAlphaOnly:productCategory]== NO){
        NSLog(@"Only character set allowed.");
    }
    if([self isNumericOnly:textFieldProductPrice.text]==NO ){
        NSLog(@"Number ranging from 10 to 99999 and after decimal point only two numbers.");
    }
    if([self isWhitespace:productName]== NO){
        [textFieldProductName becomeFirstResponder];
    }
    else if([self isWhitespace:textFieldProductPrice.text]== NO){
        [textFieldProductPrice becomeFirstResponder];
    }
    else if([self isWhitespace:productCategory]== NO){
        [textFieldProductCategory becomeFirstResponder];
    }
    else{
        UIAlertView *alertViewSucessfulMessage=[[UIAlertView alloc] initWithTitle:@"Added Successfully" message:@"Product object has been added" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertViewSucessfulMessage show];
        textFieldProductName.text=@"";
        textFieldProductPrice.text=@"";
        textFieldProductCategory.text=@"";
    }
    
}

@end
