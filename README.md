# Asynchronous task in APL

This simple implementation of Asynchronous in APL. The implementation  is based on Dyalog APL thread functions as:
```apl
  & ⎕TPUT ⎕TGET
```

That means that task are running in same process in several APL thread. 

# Usage
To load library run in the session:

```apl
  ⎕CY './Distribution/aplasync.dws'
```

# Functions
## asyncTask function
**asyncTask** function creates task. It will return the task namespace with unique token and namespace where task is run. 

Input is name and arguments of function which should be urn in the task (APL thread).

**asyncTask** will initiate execution of function in new APL thread. 

The result should be awaited with **awaitTask** function.

## awaitTask function
**awaitTask** awaits execution of the task created by **asyncTask**. It will wait that function is completed with execution. 

Input is  task defined in **asyncTask**.

Output is result of function used in  **asyncTask**.

A task can be only once awaited.

# Example

Step 1. Let have a APL function which should be executed as asynchronous task:

```apl
  ∇ res←fooFn arg;val1;val2
  ⍝ Do something:
  ⎕DL arg
  ⍝ Return something: 
  val1←arg
  val2←⎕NS''
  val2.val1←arg
  res←val1 val2
  ∇
```

Step 2. Lets make 3 tasks:
```apl
  task1←asyncTask 'fooFn' 2
  task2←asyncTask 'fooFn' 5
  task3←asyncTask 'fooFn' 1
```

Step 3. Clean result if exist:
```apl
   ⎕EX 'res1' 'res2' 'res3'
```

Step 4.a. And await them:
```apl
  res1←awaitTask task1
  res2←awaitTask task2
  res3←awaitTask task3
```

Step 5. Test result:

```apl
  val1 val2←res1
  2≡val1
  2≡val2.val1

  val1 val2←res2
  5≡val1
  5≡val2.val1

  val1 val2←res3
  1≡val1
  1≡val2.val1
```

Step 4.b. or to await with measure time (remember to make make tasks from  Step 2.):
```apl
  ai←⎕AI[2 3] ⋄ res1←awaitTask task1 ⋄ ⎕←ai-⎕AI[2 3] ⋄ ⎕←'res1' res1 ((2⊃res1).val1)
  ai←⎕AI[2 3] ⋄ res2←awaitTask task2 ⋄ ⎕←ai-⎕AI[2 3] ⋄ ⎕←'res2' res2 ((2⊃res2).val1)
  ai←⎕AI[2 3] ⋄ res3←awaitTask task3 ⋄ ⎕←ai-⎕AI[2 3] ⋄ ⎕←'res3' res3 ((2⊃res3).val1)
```

Note: Interesting is that task2 task take on c.a. 3 seconds, it was running in same time task1 task. In order to see such result the step 2. 3. 4.a (or 4.b) should be executed together, in sequence. 

Example of results of 4.b.
```apl
  ai←⎕AI[2 3] ⋄ res1←awaitTask task1 ⋄ ⎕←ai-⎕AI[2 3] ⋄ ⎕←'res1' res1 ((2⊃res1).val1)
0 ¯1977
 res1  2  #.[Namespace]   2
  ai←⎕AI[2 3] ⋄ res2←awaitTask task2 ⋄ ⎕←ai-⎕AI[2 3] ⋄ ⎕←'res2' res2 ((2⊃res2).val1)
0 ¯2995
 res2  5  #.[Namespace]   5
  ai←⎕AI[2 3] ⋄ res3←awaitTask task3 ⋄ ⎕←ai-⎕AI[2 3] ⋄ ⎕←'res3' res3 ((2⊃res3).val1)
0 0
 res3  1  #.[Namespace]   1
```


## Scalar example

```apl
  ∇ res←fooFn1 arg
  ⍝ Do something:
  ⎕DL arg
  res←7
  ∇
```

```apl
  task4←asyncTask 'fooFn1' 2
```

And await them:

```apl
  res4←awaitTask task4
```
and test

```apl
  7≡res4
```
