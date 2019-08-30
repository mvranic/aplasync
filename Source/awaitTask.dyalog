 res←awaitTask task;nsname;token
 ⍝ Await for given task.
 ⍝ Left argument: task as namespace : Namespace with task definition.
 ⍝ Result: A result of task i.e. execution of handler.
 token←task.Token
 res←⎕TGET token
 :With asyncTask_NsName
    :Hold 'taskTokens'
       taskTokens~←token
    :EndHold
 :EndWith
