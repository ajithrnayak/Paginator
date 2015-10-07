//
//  AJPaginator.m
//
//  Created by Ajith R Nayak on 21/08/15.
//

#import "AJPaginator.h"

@interface AJPaginator ()

///-----------
/// Protected
///-----------
@property(assign, readwrite) NSInteger pageSize;
@property(assign, readwrite) NSInteger page;
@property(assign, readwrite) NSInteger showing;
@property(assign, readwrite) NSInteger total;
@property(assign, readwrite, getter=isLastPage) BOOL lastPage;
@property(assign, readwrite) AJRequestStatusType requestStatus;

@property(nonatomic, readwrite) NSMutableArray *results;

@end

@implementation AJPaginator

#pragma mark - initializations

- (instancetype)initWithPageSize:(NSInteger)pageSize {
  if (self = [super init]) {
    _pageSize = pageSize;

    [self restoreDefaults];
  }

  return self;
}

+ (instancetype)paginatorWithPageSize:(NSInteger)pageSize {
  return [[[self class] alloc] initWithPageSize:pageSize];
}

- (void)restoreDefaults {
  // defaults
  _page = 0;
  _showing = 0;
  _total = 0;
  _requestStatus = AJRequestStatusTypeNone;
  _lastPage = NO;
  _results = nil;
}

#pragma mark - Public
- (void)fetchFirstPage {
  [self restoreDefaults];

  [self fetchNextPage];
}

- (void)fetchNextPage {
  // don't do anything if there's already a request in progress, off course
  // if its last page, Do not make the request
  if (self.requestStatus == AJRequestStatusTypeCrunching || self.isLastPage) {
    return;
  }

  self.requestStatus = AJRequestStatusTypeCrunching;
  // ask for results
  [self fetchResultsWithPageSize:self.pageSize
                            page:self.page + 1
                      completion:^(NSArray *results, NSError *error) {

                        self.requestStatus = AJRequestStatusTypeNone;

                        if (!error) {

                          if (results.count < self.pageSize) {
                            self.lastPage = YES;
                          }

                          if (results.count) {
                            [self.results addObjectsFromArray:results];
                            self.page += 1;
                          }
                        }

                        if (self.completionBlock != NULL) {
                          self.completionBlock(results, error);
                        }

                      }];
}

#pragma mark - Sublclass

- (void)fetchResultsWithPageSize:(NSInteger)pageSize
                            page:(NSInteger)page
                      completion:(void (^)(NSArray *results,
                                           NSError *error))completion {
  // override this in subclass
  assert(0);
}

@end
