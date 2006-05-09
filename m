Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49Efw3E017375
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 10:41:58 -0400
Received: from e4.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49EfvEk025300
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 14:41:57 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k49Efuk6014480
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 10:41:56 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k49EfuvF221324
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 10:41:56 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k49Eftmf009476
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 10:41:55 -0400
Message-ID: <4460AA31.6030805@us.ibm.com>
Date: Tue, 09 May 2006 10:41:53 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Valdis.Kletnieks@vt.edu, SE-Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: pam_namespace
References: <200605051623.25533.russell@coker.com.au> <445F4B38.9080808@us.ibm.com> <200605092257.59047.russell@coker.com.au> <200605100002.28660.russell@coker.com.au>
In-Reply-To: <200605100002.28660.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Tuesday 09 May 2006 22:57, Russell Coker <russell@coker.com.au> wrote:
>  
>
>>>>Having "both" and "both_no_mcs" is confusing.  Maybe it would be best to
>>>>have "user" and "context" as separate items to replace "both" and then
>>>>support a fourth option as "range", "high" or "low".
>>>>        
>>>>
>>>I am not sure I understand. We have "user", "context" and "both", where
>>>type in the context can be controlled through type-member policy rules
>>>and the mls range is inherited from the process. Can you give an example
>>>of what context the instance would have with "range" or "high" or "low"?
>>>      
>>>
>>My idea is that the range, high, and low values would be candidates for the
>>file name.
>>    
>>
>[...]
>  
>
>>Probably the easiest thing to do is to default to including the entire
>>security context of the process in the directory name.
>>    
>>
>
>One thing that I consider to be necessary is to allow the administrator to 
>determine in which situations the PI directories should be shared.  Using a 
>default that has the full context including range will work, but many admins 
>will want finer grained control.
>
>For example if the aim is to separate MLS ranges such that file names can not 
>be used to accidentally reveal secret data then there may not be a need for 
>separate Unix UIDs to have different directories, and directory names could 
>be based on range alone.
>
>Another possibility is when running the strict policy a user might have 
>multiple roles but not want to have a different copy of /tmp for each one.  
>For example if I scp a file to the /tmp directory used for role A then after 
>running newrole to change to role B I will still want to see the file in 
>question (assuming of course that the policy allows access to it).
>
>Then for MCS the issue of whether it's most desirable to base instance 
>directory names on the high or the low level is something that we probably 
>won't ever get an agreement on.
>
>  
>
Just to clarify, it is the instance security context that is important 
from the
perspective of access to it. The inclusion of context in the directory 
name is
just so that the admin can correctly identify them. The earlier incarnation
of the pam namespace module put an md5 hash instead of the more useful
uid+context names.

As far as the ability to control which instances to share, I assume you
can do that with the policy. The namespace module just calls
security_compute_member() to get the context of the instance.
security_compute_member() looks at process context and the
target directory context to arrive at the context for the member(instance).
So you could setup the policy such that different process contexts
return different (or the same, if so desired) contexts for the instance.

-Janak



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
