//
//  MyViewController.m
//  ui_tableview
//
//  Created by B02681 on 2014/01/24.
//  Copyright (c) 2014年 海野 秀祐. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()
{
	IBOutlet UILabel *textLabel;
	NSArray *itemArray;
}
@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
#if 1
	itemArray = [[NSArray alloc]initWithObjects:@"aaa", @"bbb", @"ccc", nil];
	
	_tableView.delegate = self;
	_tableView.dataSource = self;
	//_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// dataSource例１
#if 1
-(void)tableView:(UITableView*)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath*)indexPath{
	
	if(editingStyle == UITableViewCellEditingStyleDelete){
		// Delete時の処理をここに書く
	}else if(editingStyle == UITableViewCellEditingStyleInsert){
		// Insert時の処理をここに書く
	}
}
#endif

#pragma mark - delegate
#if 1
//	ロード時に呼び出される。セクションに含まれるセル数を返すように実装する
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
	return [itemArray count];
}

//各セルの表示内容を設定する
-(UITableViewCell *)tableView:
(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [itemArray objectAtIndex: indexPath.row];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//セルがタップされたときにコールされる
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //itemArray の指定番目の文字列をステータスバーのラベルにセット
    //[indexPath row]で、何行目のセルがタップされたかを取得
	for (NSInteger index=0; index<[self.tableView numberOfRowsInSection:0]; index++) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        // ①選択したセルだけチェックする
        if (indexPath.row == index) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
			[cell setTintColor:[UIColor redColor]];
//			UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//			view.backgroundColor = [UIColor blueColor];
//			[cell addSubview:view];
        }
    }
	
    textLabel.text = [itemArray objectAtIndex:[indexPath row]];
	
	// テーブルを更新
    //[self.tableView reloadData];

}

#endif

@end
