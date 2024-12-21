# Objective-C KVO Crash with Weak References

This repository demonstrates a common yet subtle bug in Objective-C related to Key-Value Observing (KVO) and weak references.  When an observer uses a weak reference to the observed object and the observed object is deallocated before the observer removes itself, a crash can occur.  The `WeakKVOBug.m` file illustrates this problem, while `WeakKVOFix.m` shows how to resolve it.

## Problem

The primary issue is a race condition: the observed object can be deallocated before the observer has a chance to remove its observation. Attempting to access the now-deallocated object through the weak reference results in a crash.

## Solution

The solution involves ensuring that the observer always removes itself before the observed object is deallocated.  This often entails using the `-observeValueForKeyPath:ofObject:change:context:` method and its `context` parameter to track the observation and deallocation.