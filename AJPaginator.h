//
//  AJPaginator.h
//
//  Created by Ajith R Nayak on 21/08/15.


@import Foundation;

/** @discussion A completion block invoked when request is done! */
typedef void (^AJPaginatorCompletionBlock)(id response, NSError *error);

typedef NS_ENUM(NSInteger, AJRequestStatusType) {
  AJRequestStatusTypeNone,
  AJRequestStatusTypeCrunching
};

@interface AJPaginator : NSObject

///--------
/// Status
///--------

// number of results per page
@property(assign, readonly) NSInteger pageSize;

// Current Page (also defines number of pages already scrolled)
@property(assign, readonly) NSInteger page;

// total results that are currently shown (page * pagesize)
@property(assign, readonly) NSInteger showing;

// total number of results available
@property(assign, readonly) NSInteger total;

// Return YES if last page was hit.
@property(assign, readonly, getter=isLastPage) BOOL lastPage;

// Current status of request. Request is discarded if there's already one
// running.
@property(assign, readonly) AJRequestStatusType requestStatus;

//results retrieved for pages with given page size
@property(nonatomic, readonly) NSMutableArray *results;

///---------------
/// Initialization
///---------------

- (instancetype)initWithPageSize:(NSInteger)pageSize NS_DESIGNATED_INITIALIZER;
+ (instancetype)paginatorWithPageSize:(NSInteger)pageSize;

///-------------------
/// Completion Handler
///-------------------

/** completion block to be invoked on getting result */
@property(nonatomic, copy) AJPaginatorCompletionBlock completionBlock;

///--------
/// Request
///--------

/** Call this to get first page results */
- (void)fetchFirstPage;

/** Call this to fetch subsequent pages */
- (void)fetchNextPage;

/** To reset paginator to first page. */
- (void)restoreDefaults;

///--------
/// Unavailable
///--------

- (instancetype)init NS_UNAVAILABLE;

@end
