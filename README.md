
PHImageManager add a dispatch source event DISPATCH_SOURCE_TYPE_MEMORYPRESSURE when init. When receive memory warning Photos framework will try to remove cached data in this event handler. At that time, if you have call but not get the authorization, it will cause crash
