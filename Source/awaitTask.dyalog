 res←awaitTask task;nsname;token
 ⍝ Await for given task.
 ⍝ Left argument: task as namespace : Namespace with task definition.
 ⍝ Result: A result of task i.e. execution of handler.
 token←task.Token
 :With asyncTask_NsName
    :Hold 'taskTokens'
        :If token∊⎕TPOOL
            taskTokens~←token
         :Else
             ('Token ',(⍕token),' is not in thread pool.') ⎕SIGNAL 6 
         :EndIf
    :EndHold
 :EndWith
 res←⎕TGET token
 