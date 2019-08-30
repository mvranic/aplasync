# Asynchronius task in APL

This simple implementation of Asynchronius in APL. The implementation  is based on Dyalog APL thread functions as:
```apl
  & ⎕TPUT ⎕TGET
```

That means that task are running in same process in several APL thread. 



# Usage
To load library run in the session:

```apl
  ⎕CY './Distribution/aplasync.dws'
```

# Example

Let have a APL function which should be executed as asynchronius task:

```apl
  ∇ res←fooFn arg
  ⍝ Do something:
  ⎕DL arg
  ⍝ Return something: 
  res← ?arg 
  ∇
```

Lets make 3 tasks:

```apl
  task1←asyncTask 'fooFn' 2
  task2←asyncTask 'fooFn' 5
  task3←asyncTask 'fooFn' 1
```

And await them:

```apl
  res1←awaitTask task1
  res2←awaitTask task2
  res3←awaitTask task3
```

