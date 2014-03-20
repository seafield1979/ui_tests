//
//  UNTableViewController2.m
//  ui_tableview
//
//  Created by B02681 on 2014/03/19.
//  Copyright (c) 2014年 海野 秀祐. All rights reserved.
//

#import "UNTableViewController2.h"
#import "SwitchCell.h"

@interface UNTableViewController2 ()
{
	NSMutableArray *_list1;
}

@end

@implementation UNTableViewController2

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
	
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// サイズ調整
	UIEdgeInsets insets = self.tableView.contentInset;
	insets.top = 20;
	self.tableView.contentInset = insets;
	
	// テーブルビューに表示するリストを作成する
	NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"listJson" ofType:@"txt"];
    NSString *json = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
	_list1 = [NSJSONSerialization JSONObjectWithData:jsonData
								options:NSJSONReadingAllowFragments error:&error];
	NSLog(@"%@ %d", _list1, [_list1 count]);
								
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/**
 * セクション数を返す
 * @param tableView   テーブルビュー
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

/**
 * セクションのセル数を返す
 * @param tableView   テーブルビュー
 * @param section     セクション番号
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_list1 count];
}

/**
 * 指定番号のセルを取得する
 * @param tableView     テーブルビュー
 * @param indexPath     セル番号
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 1 || indexPath.row == 2){
		static NSString *CellIdentifier = @"switchCell";
		SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			[tableView registerNib:[UINib nibWithNibName:@"switchCell" bundle:Nil] forCellReuseIdentifier:CellIdentifier];
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		}
		cell.label1.text = [_list1 objectAtIndex:indexPath.row];
		
		[cell.switch1 addTarget:self action:@selector(changedSwitchState:) forControlEvents:UIControlEventValueChanged];
		
		cell.switch1.tag = indexPath.row;
		return cell;
	}
	else {
		static NSString *CellIdentifier1 = @"Cell";
		SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		
		if (cell == nil) {
			cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
			cell.textLabel.text = [_list1 objectAtIndex:indexPath.row];
		}
		cell.textLabel.text = [_list1 objectAtIndex:indexPath.row];
		return cell;
	}
}

/**
 * セクションヘッダーのタイトルを返す
 * @param tableView    テーブルビュー
 * @param section      セクション番号
 */
-(NSString *)tableView:
(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
	if(section == 0){
		return @"てすとだよ";
	}
	return @"なしだよ";
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

/**
 * セルがタップされたときの処理
 */
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#if 0
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
#endif
	
	switch(indexPath.row){
		case 0:
			NSLog(@"111");
			break;
		case 1:
			NSLog(@"222");
			break;
		case 2:
			NSLog(@"333");
			break;
	}
}

#pragma mark - Private Method

-(void)changedSwitchState:(UISwitch*)switch1{
   // ここに何かの処理を記述する
   // （引数の switch には呼び出し元のUISwitchオブジェクトが引き渡されてきます）
	NSLog(@"switch %d", switch1.on);
	switch(switch1.tag){
		case 1:
			NSLog(@"111");
			break;
		case 2:
			NSLog(@"222");
			break;
	}
}
							   


@end
