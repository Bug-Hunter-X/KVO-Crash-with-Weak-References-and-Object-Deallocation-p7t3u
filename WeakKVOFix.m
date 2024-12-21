The solution is to ensure the observer removes itself in its own `dealloc` method, or, even better, to use a pattern where the observed object is responsible for removing the observer in its own `dealloc` method.

```objectivec
// WeakKVOFix.m
@implementation ObservedObject
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"observedProperty"];
    [super dealloc];
}

- (void)addObserver:(NSObject *)observer {
    [self addObserver:observer forKeyPath:@"observedProperty" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)removeObserver:(NSObject *)observer {
    [self removeObserver:observer forKeyPath:@"observedProperty"];
}

@end

// Observer Class in WeakKVOFix.m
@implementation Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
   //Handle value changes safely.
}

- (void)dealloc {
    [observedObject removeObserver:self forKeyPath:@