Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA18485
	for <selinux@tycho.nsa.gov>; Sat, 10 Nov 2001 23:20:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id EAA05936
	for <selinux@tycho.nsa.gov>; Sun, 11 Nov 2001 04:20:26 GMT
Received: from khaipur.xiat.org ([66.125.68.98])
	by jazzswing.ncsc.mil  with ESMTP id EAA05932
	for <selinux@tycho.nsa.gov>; Sun, 11 Nov 2001 04:20:25 GMT
Date: Sat, 10 Nov 2001 20:19:22 -0800
From: Paul Krumviede <pwk@acm.org>
To: Femitha Majeed <m_femitha@hotmail.com>, selinux@tycho.nsa.gov
Subject: Re: Kernel Module
Message-ID: <13021734.1005423562@localhost>
In-Reply-To: <F95EhUztNbKhFvz6udw00023f34@hotmail.com>
References: <F95EhUztNbKhFvz6udw00023f34@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Saturday, 10 November, 2001 17:22 +0000 Femitha Majeed 
<m_femitha@hotmail.com> wrote:

>
> Hi,
>
>
> I am trying to write a kernel module, but I get the follwing error when I
> do "insmod filename.o"
>
> Unable to handle kernel NULL pointer dereference at virtual address ...

you don't mention anything about a particular version of selinux, so this
may not be relevant, but stephen smalley posted a patch to the selinux
security module which was noticed when people noticed this particular
problem when attempting to install or run mozilla. the message was
dated 22 oct. 2001 and would apply to the 2.4.12-lsm based distribution.

if you don't have the message in question, i (or others) could forward it,
or it is presumably available in an archive.

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
