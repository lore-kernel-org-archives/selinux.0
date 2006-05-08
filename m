Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k48DiXWI019143
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 09:44:33 -0400
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k48DiVEL003284
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 13:44:32 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k48DiU7i006063
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 09:44:30 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k48DiUih240830
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 09:44:30 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k48DiThW023027
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 09:44:29 -0400
Message-ID: <445F4B38.9080808@us.ibm.com>
Date: Mon, 08 May 2006 09:44:24 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Valdis.Kletnieks@vt.edu, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: pam_namespace
References: <200605051623.25533.russell@coker.com.au> <200605071928.22799.russell@coker.com.au> <200605080107.k4817awO007711@turing-police.cc.vt.edu> <200605081328.02493.russell@coker.com.au>
In-Reply-To: <200605081328.02493.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Monday 08 May 2006 11:07, Valdis.Kletnieks@vt.edu wrote:
>  
>
>>>>b) A check that we fail in a sane manner if the SELinux policy and the
>>>>pam_namespace config aren't compatible.  This may be tricky - for a
>>>>system that's in strict/MLS mode, failing to config may be grounds for
>>>>failing totally in a noisy manner (refusing the logon, for instance) -
>>>>while for targeted we may want to just ignore an attempt to specify MLS
>>>>features..
>>>>        
>>>>
>>>In what way do the require_selinux and the ignore_config_error
>>>command-line options to the pam_namespace.so module not do what you
>>>desire in this regard?
>>>      
>>>
>>ignore_config_error is only sufficient if there is no possibility of
>>any option misbehaving - in particular, we can't have an option 'both'
>>that works in MCS/MLS environments as well - we'll need to have a both_mcs
>>if the mcs label is to be included, and a both_no_mcs if it should behave
>>in the same way as the non-mcs 'both'.
>>    
>>
>
>Having "both" and "both_no_mcs" is confusing.  Maybe it would be best to 
>have "user" and "context" as separate items to replace "both" and then 
>support a fourth option as "range", "high" or "low".
>
>  
>
I am not sure I understand. We have "user", "context" and "both", where type
in the context can be controlled through type-member policy rules and 
the mls
range is inherited from the process. Can you give an example of what context
the instance would have with "range" or "high" or "low"?

In general I am not sure about the intermidiate directory itself. To me, 
it complicates
the mechanism and mixes it with policy. When using polyinstantiation 
with SELinux,
you can tighten up access to instances by type-member rules and by 
inheriting mls
label of the process. In non-SELinux use, an admin can seperate users 
from each
other by configuring the instance to be a subdirectory of the 
polyinstantiated directory.
We can get additional protection from non-root daemons by creating an 
intermdiate
directory. However, is it really worth the trouble to protect a user's 
instance of
/tmp or /var/tmp beyond what will be protected by sticky bits? Since 
instances
inherit the polyinstantiated directory's mode, $HOME etc are already 
protected
from non-root daemons.

>>>>See the above - I think we're in agreement here.  But I admit I don't
>>>>know what "proper" behavior is if the threat model is "a non-SE system,
>>>>and a 0wned uid=0 daemon getting into /tmp/$USER" - how do we stop that
>>>>(ugly hacks like cd'ing into the directory, and then mount --bind an
>>>>empty dir over it?)
>>>>        
>>>>
>>>On a non-SE system "0wned uid=0 daemon" is considered to be game-over.
>>>      
>>>
>>So you're saying that on a non-SE system, namespaces are *not* in the
>>least expected to slow down a rogue daemon.  OK, as long as we make a
>>note of that..
>>    
>>
>
>Not at all!  I'm saying that on a non-SE system a uid=0 process can do 
>anything it wants so there's no point even attempting to constrain such a 
>process.  However nowadays most daemons never run as root, and the ones that 
>do run as root drop their privs for as much code as possible.
>
>Attack by a non-root daemon on a non-SE system is something we want to 
>prevent.
>  
>
Again, this attack, valid only on non-SELinux mode, would only 
consititute the
daemon creating files in user's instance of /tmp or /var/tmp. Because of 
the sticky bit,
the daemon will not be able delete any files there, right?

>  
>
>>>>>Why can't we have a script run in system context?
>>>>>          
>>>>>
>>>>That's the goal of the setexeccon() that Janak was going to look into. 
>>>>The problem is that we're already in a user context - what happens if
>>>>that context isn't *allowed* to setexeccon() to a system context?
>>>>        
>>>>
>>>How are we already in a user context?  sys_unshare() can only be called
>>>from a system context...
>>>      
>>>
>>OK, you tell me what's going on here:
>>
>># head /etc/security/namespace.init
>>#!/bin/bash
>>logger -i -p authpriv.info "called with args $1 $2" `id`
>>    
>>
>
>Firstly, what is this /etc/security/namespace.init?  Pam version 
>pam-0.99.3.0-4 doesn't have this, are you running some different version?
>
>One thing that concerns me about the pam-0.99.3.0-4 code base is that it 
>appears to want to run a script from the polydir.  As I can't seem to 
>exercise that code I can't be sure that it's doing the wrong thing, but the 
>concept seems bad.
>
>  
>
Yes, this was pointed out Valdis and Stephen. Valdis created a bugzilla 
for it and
the patch posted there moves the instance initialization from polydir to 
/etc/security/namespace.init

>>The problem is that the pam_namespace is still running in a system context,
>>but since an earlier pam_selinux called setexeccon(), when namespace
>>does an exec, it gets parked in the user context that pam_selinux intended
>>to inflict on the actual user login....
>>    
>>
>
>That's easy to solve, just call setexeccon(NULL) before doing the exec.  As a 
>child process is used for this (if exec fails it calls exit(1)) there is not 
>even any need to save the old value of the execcon.
>  
>

Yes, that's exactly what I was going to do. Late last week, I was 
distracted by non pam_namespace
related tasks, but hopefully I can test and post an updated patch today.

-Janak


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
