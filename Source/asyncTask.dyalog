 task←asyncTask arg;hendlerargs;handler;nsname;ns;nsref;token;res;nsresref
⍝ Create task for handler and handler argumnet.
⍝ Left argument: handler as string : Name of handler function.
⍝              : hendlerargs as array of araguments : Name of handler function.
⍝ Result: A namespace with task token.
 handler hendlerargs←arg
 nsname←asyncTask_NsName
 :If 9=⎕NC nsname
    nsref←⍎nsname
 :Else
    nsref←nsname ⎕NS''
 :EndIf

 :With nsname
    :Hold 'taskTokens'
       :If 0=⎕NC'taskTokens'
          taskTokens←⍬
       :EndIf
       token←taskTokens~⍨⍳1+⍨⊃⌈/0,taskTokens
       taskTokens,←token
    :EndHold
 :EndWith
 task←⎕NS''
 task.Token←token
 task.Handler←handler

 token asyncTask_Do&handler hendlerargs
