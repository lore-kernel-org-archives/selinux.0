Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8Q0DfrT025433
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 20:13:43 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8Q0Cesn006249
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 00:12:40 GMT
Message-ID: <415609AD.5000808@tresys.com>
Date: Sat, 25 Sep 2004 20:13:33 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Dale Amon <amon@vnl.com>
CC: Russell Coker <russell@coker.com.au>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Remove unrestricted_admin
References: <200409211526.37810.russell@coker.com.au> <200409252039.01196.russell@coker.com.au> <1096119005.11665.21.camel@gorn.pebenito.net> <200409260121.10665.russell@coker.com.au> <20040925220708.GB15912@vnl.com>
In-Reply-To: <20040925220708.GB15912@vnl.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dale Amon wrote:

>On Sun, Sep 26, 2004 at 01:21:10AM +1000, Russell Coker wrote:
>  
>
>>Corner cases that happen to be a regular part of any sys-admin's job.
>>    
>>
>
>I massively agree. Lots of people do 'ghosting'; lots
>of people back up entire disk images before doing
>something dangerous. Now I've got ways around a lot
>of the problems anyway because I've a root boot floppy
>I use. Boot a machine off an nfs root; mount a Real Big
>Disk over nfs, and then dd the whole frigging host
>system disk to the destination system where it
>can be worked on. 
>
>Although it is not my primary use for this (mostly I
>do R&D), think forensics too. Think of all the various
>tools in use for setting up a master image and dupping
>it to N other machines.
>
>Also, dd with a decent block speed is an awesomely 
>fast way to back up a disk.
>
>  
>
I _really_ hope you aren't suggesting that you do a dd from a host disk 
to something else while a machine is in production. This _will_ lead to 
an inconsistant image and I don't think I need to explain why.

This corner case shouldn't determine what is in the default policy, but 
I'm not even sure that is what we are talking about here, Russell never 
said how he wants this implemented (keep the unrestricted_admin macro or 
put that unrestricted fixed disk access in the standard policy. At any 
rate, I hope very much that noone expects or desires that this be put in 
unconditionally. Raw disk access is a very obvious attack vector and 
must be treated as such, period.

Again, these backup kinds of activities are always privileged and thus 
need to be in a domain where they can do only backup procedures, whether 
that be reading the on-disk files (preferable and correct if you use 
real backup software) or raw disk access.


Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
