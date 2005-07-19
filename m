Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JIWSgA009048
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 14:32:28 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JIOmZb005181
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 18:24:49 GMT
Message-ID: <42DD4518.9080704@redhat.com>
Date: Tue, 19 Jul 2005 14:23:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Hanson <chanson@TrustedCS.com>
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: Re: init running at s9 by default on a MLS system?
References: <36282A1733C57546BE392885C0618592AF2836@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592AF2836@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Hanson wrote:

>Hi Paul,
>
>I would agree the disk partitions should be at s9. The init process should
>probably be at s0. We need to work on providing more updates for this
>policy.
>
>-Chad
>
>  
>
>>-----Original Message-----
>>From: Paul Moore [mailto:paul.moore@hp.com]
>>Sent: Friday, July 15, 2005 12:03 PM
>>To: selinux@tycho.nsa.gov
>>Subject: init running at s9 by default on a MLS system?
>>
>>
>>Hello,
>>
>>I have been playing with Dan Walsh's MLS policy RPM on Fedora Rawhide 
>>and I noticed on the later versions that init is running at level s9 
>>which appears to be causing some problems.  The particular issue I am 
>>dealing with right now is when fsck (as run from 
>>/etc/rc.d/rc.sysinit) 
>>tries to check all of the filesystems in /etc/fstab.  The 
>>problem lies 
>>in the fact that the disk partitions in /dev are all labeled 
>>at s0 and 
>>fsck is trying to open them with write access.  Needless to say the 
>>policy is correct for the strict policy but as soon as you 
>>introduce the 
>>different levels you run into problems.
>>
>>My question is this: should init be running at s9 and if so should we 
>>relabel the partitions to be at s9 as well?
>>
>>-- 
>>. paul moore . . . . . . . . . . . . . . . . . . . . . . . . 
>>. . . . . .
>>. paul.moore@hp.com                                      
>>hewlett packard
>>. (603) 884-5056                                          
>>linux security
>>
>>--
>>This message was distributed to subscribers of the selinux 
>>mailing list.
>>If you no longer wish to subscribe, send mail to 
>>majordomo@tycho.nsa.gov with
>>the words "unsubscribe selinux" without quotes as the message.
>>
>>    
>>
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>
How do you specify in policy that kernel_t transitions to init_t but at 
level s0?

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
