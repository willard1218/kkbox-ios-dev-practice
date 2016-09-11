#找出五個 singleton class
## UIApplication
此物件是管理整個 applcation，可以獲得 app 的視窗、目前整個 app 的狀態、狀態列等等。

## NSFileManager


## NSNotificationCenter
## 

#找出五個有 delegate 或 data source 的 class
## UITableView
這是最常用的元件，將一些內容以表格的方式呈現，  
透過 dataSource 裡的 cellForRow 能告訴系統應該呈現怎樣的 cell，  
透過 delegate 裡的 didSelectAtIndexPath 能夠告訴系統點擊 cell 需要執行怎樣的動作。  
## UIScrollView

## UIAlertView
## UITextField
## UIApplication



#找出五個會發送 notification 的 class
1. NSManagedObjectContext NSManagedObjectContextDidSaveNotification


#找出五個使用 block 的 class
1. NSURLSessionDataTask dataTaskWithRequest
2. NSArray enumerateObjectsUsingBlock
3. NSPredicate predicateWithBlock
4. 
