Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA28101
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 15:28:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA01559
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 20:26:11 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id UAA01551
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 20:26:11 GMT
Message-Id: <200211072031.PAA07358@moss-shockers.ncsc.mil>
Date: Thu, 7 Nov 2002 15:31:41 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: type transition
To: selinux@tycho.nsa.gov, giorgio.zanin@inwind.it
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> From: Giorgio Zanin <giorgio.zanin@inwind.it>
> 
> what's the difference between the following statements:
> 
> type_transition TYPE_A TYPE_B:process TYPE_C
> 
> and
> 
> allow TYPE_A TYPE_C:process transition
> ?
> 
> If I am  not wrong the first statement forces a new process, created by
> TYPE_A, to belong to TYPE_C, i.e. everytime TYPE_A creates a process
> (with respect to TYPE_B) this process is made member of TYPE_C.
> The second statement allows TYPE_A to change to TYPE_C.
> Does both occur upon an execve()? If so, what's the difference between
> them? It seems the first requires a call to fork(), while the second
> does not; probably I am wrong but it's the only difference I can argue.
> Can anyone explain how these type transitions occur (possibly everything
> about type transitions in SELinux....)?

This is explained in the technical reports available from the NSA site.
To summarize, a type_transition rule specifies a default labeling behavior to 
provide transparency to unmodified applications, but is not mandatory; it can be 
overridden via the extended system calls if authorized by the policy.  The allow 
rules define what is permitted.  A single type_transition may require a number 
of allow rules to authorize it, e.g. look at what allow rules are contained by  
a single domain_trans() macro.  Automatically generating the set of allow rules 
from a type_transition rule isn't really feasible in general without being more 
permissive than you want in every case.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
