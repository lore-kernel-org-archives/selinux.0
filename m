Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5L4nprT028806
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 00:49:51 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5L4nni3020397
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 04:49:49 GMT
Date: Mon, 21 Jun 2004 00:49:42 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: sched_setscheduler()
In-Reply-To: <200406200049.25402.russell@coker.com.au>
Message-ID: <Xine.LNX.4.44.0406210043150.22018-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 20 Jun 2004, Russell Coker wrote:

> I am having some problems with asterisk (the VOIP server).
> 
> According to strace it does the following:
> sched_setscheduler(0, SCHED_OTHER, { 0 }) = -1 EACCES (Permission denied)
> 
> This failure happens in enforcing mode but not in permissive mode, however 
> nothing is audited!

setschedluler denials are not audited by the kernel, as doing so causes a 
deadlock with printk (the kernel logging function).  I believe this can be 
fixed with an asynchronous feature of the new audit framework, but am not 
sure if it's been looked into.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
