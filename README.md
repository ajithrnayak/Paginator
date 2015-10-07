# Paginator
Objective-C class that handles pagination. Inspired from https://github.com/nmondollot/NMPaginator

### To use:

1. Copy `AJPaginator` interface and implementation files.
2. Subclass `AJPaginator` and override `-fetchResultsWithPageSize:page:completion:`
3. Invoke completion handler after fetching results async.

example:   
```objective-c
- (void)fetchResultsWithPageSize:(NSInteger)pageSize
                            page:(NSInteger)page
                      completion:(void (^)(NSArray *, NSError *))completion {
  // 1. configure query for page and page size here..

  // 2. make async request for query results.
  [self.activeQuery runAsync:^(CBLQueryEnumerator *__nonnull results,
                               NSError *__nonnull error) {

    // 3. populate items here..

    // 4. Invoke completion block with items array.
    if (onComplete) {
      onComplete(items, error);
    }

  }];
}
```
