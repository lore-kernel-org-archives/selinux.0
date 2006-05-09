Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49DCZHr014718
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 09:12:35 -0400
Received: from e33.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49DCYa2013064
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 13:12:34 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k49DCX92032099
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 09:12:33 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k49DCX7r182904
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 07:12:33 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k49DCWKN014254
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 07:12:33 -0600
Message-ID: <4460953B.5020609@us.ibm.com>
Date: Tue, 09 May 2006 09:12:27 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
CC: Russell Coker <russell@coker.com.au>, Valdis.Kletnieks@vt.edu,
        SE-Linux <selinux@tycho.nsa.gov>, viro@zeniv.linux.org.uk
Subject: Re: pam_namespace
References: <200605051623.25533.russell@coker.com.au> <200605051006.k45A6vNK024699@turing-police.cc.vt.edu> <200605071928.22799.russell@coker.com.au> <200605081137.42066.russell@coker.com.au> <20060508223859.GA7479@thorium.jmh.mhn.de>
In-Reply-To: <20060508223859.GA7479@thorium.jmh.mhn.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thomas Bleher wrote:

>[CC'ing Al Viro because he surely knows this...]
>
>* Russell Coker <russell@coker.com.au> [2006-05-08 05:23]:
>  
>
>>On Sunday 07 May 2006 19:28, Russell Coker <russell@coker.com.au> wrote:
>>    
>>
>>>Of course there's nothing stopping us from modifying a program such as
>>>runuser or run_init to set up a namespace for a daemon.  In fact we should
>>>probably make the default behavior of run_init and runuser be the creation
>>>of a namespace.  It would be easy to create a config file for runuser that
>>>allows excluding daemons on the basis of executable name, UID, or other
>>>factors.
>>>      
>>>
>>One problem we have with separate name spaces is that when the administrator 
>>mounts a file system the users won't see it.
>>    
>>
>
>I thought shared subtrees were invented to solve this problem?
>I've read the documentation but never actually played with it, so I'd be
>interested to hear if it doesn't work.
>
>Thomas
>  
>
Yes, shared tree will solve this problem. Ram Pai has been trying to 
upstream the
user level support for this feature (kernel portion is already upstream 
since 2.6.15)
but the maintainer hasn't been very responsive. I forwarded his patch to 
redhat-lspp
on the suggestion of Steve Grubb. We are planning on including it in our 
lspp
builds so folks can play with it. In the meantime, we will continue to 
push the
upstream maintainer of util-linux for including this patch to the mount 
command.

-Janak

>  
>
>>When the mount point has 
>>the "user" option in /etc/fstab that won't be such a problem, but for the 
>>more common cases of autofs and the automatic mounting we have in Fedora 
>>that's not going to work.
>>
>>As we want to provide as much protection as possible for as many users as 
>>possible it seems to me that for a typical targeted-policy system we would 
>>want to run daemons in their own name-space while leaving users in the system 
>>name-space.  It would not be difficult to modify runuser such that it could 
>>check for a domain_auto_trans() operation on launching a daemon (assuming 
>>that the runuser command in question runs the daemon directly instead of 
>>running a startup script) and then by default create a separate name space 
>>for every daemon that is confined in the targeted policy (which is probably a 
>>good list of daemons that may potentially become compromised and be used to 
>>attack users).
>>
>>Having such separate name-spaces for daemons that run as non-root allows 
>>protecting users from attack while avoiding the usability issues of 
>>namespaces for each user.  This is a good match the design philosophy of the 
>>targeted policy.
>>
>>For daemons such as xfs, we could have runuser set up a bind mount of the 
>>sub-directory of the /tmp directory that is used.  So /tmp/.font-unix could 
>>be bind mounted into the name-space of the xfs daemon.  Incidentally at the 
>>moment xfs is not started by runuser, so with my rough design outlined above 
>>it would not get a separate name-space
>>
>.
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
