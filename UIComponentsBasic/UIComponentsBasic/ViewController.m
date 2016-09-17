//
//  ViewController.m
//  UIComponentsBasic
//
//  Created by komal lunkad on 15/09/16.
//  Copyright © 2016 komal lunkad. All rights reserved.
//

#import "ViewController.h"
#import "Products.h"

@interface ViewController ()
{
    NSMutableArray *arrayProducts;

    IBOutlet UITextField *textFieldProductName;
    
    IBOutlet UITextField *textFieldProductPrice;
    
    IBOutlet UITextField *textFieldProductCategory;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayProducts=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** Checks for extreme whitespaces and trims it
 * \param name The input whose extreme whitespaces are to be checked
 * \returns Returns yes if whitespaces are  present else it returns no
 */
-(BOOL)isWhitespace:(NSString*)name{
    NSString *trimmedName=[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(trimmedName.length==0){
        return NO;
    }
    return YES;
}

/** Checks for alphabets and other characters in the string
 * \param input The input whose content character set is to be checked
 * \returns Returns yes if alphabets are only present else it returns no
 */
-(BOOL)isAlphaOnly:(NSString *)input
{
    NSString *regExp = @"[a-zA-Z]+";
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [regexTest evaluateWithObject:input];
}

/** Checks for numbers, decimal point and number of digits
 * \param input The input whose content number set is to be checked
 * \returns Returns yes if numbers, decimal point and number of digits within limit are only present else it returns no
 */
-(BOOL)isNumericOnly:(NSString *)input
{
    NSString *regExp = @"[0-9]{2,5}[.]{0,1}[0-9]{0,2}";
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [regexTest evaluateWithObject:input];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex==0) {
        Products *product=[[Products alloc]init];
        product.productName=textFieldProductName.text;
        product.productPrice=[textFieldProductPrice.text floatValue];
        product.productCategory=textFieldProductCategory.text;
        [arrayProducts addObject:product];
        for( product in arrayProducts){
            NSLog(@"Product Name is %@ ,product price is %.02f and product category is %@",product.productName,product.productPrice,product.productCategory);
        }

    }
}

/** Clears all text fields
 * \returns Returns nothing
 */
-(void)clearTextField{
    textFieldProductName.text=@"";
    textFieldProductPrice.text=@"";
    textFieldProductCategory.text=@"";
}

/** Shows alertview, calls cleartextfield method and points to product name textfield
 * \returns Returns nothing
 */
-(void)showAlertView{
    UIAlertView *alertViewSucessfulMessage=[[UIAlertView alloc] initWithTitle:@"Added Successfully" message:@"Product object has been added" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertViewSucessfulMessage show];
    [self clearTextField];
    [textFieldProductName becomeFirstResponder];
}

/** Performs action on click of button add
 * \param sender The id of add button
 * \returns Returns action on click of button
 */
- (IBAction)buttonAddTapped:(id)sender {
    NSString *productName=textFieldProductName.text;
    NSString *productCategory=textFieldProductCategory.text;
    
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
        [self showAlertView];
    }
    
}

@end
