Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m63EX6G8010532
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2008 10:33:06 -0400
Received: from g5t0008.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m63EX5p8002193
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2008 14:33:05 GMT
From: Paul Moore <paul.moore@hp.com>
To: Christian Kuester <c.kuester@tarent.de>
Subject: Re: Adding local nodecon's through semanage
Date: Thu, 3 Jul 2008 10:32:57 -0400
Cc: selinux@tycho.nsa.gov
References: <486CD88E.2000406@tarent.de>
In-Reply-To: <486CD88E.2000406@tarent.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807031032.57875.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 03 July 2008 9:47:58 am Christian Kuester wrote:
> Hi List,
>
> I had a small conversation with Stephen Smalley on the
> fedora-selinux-list about an easy way to add
> (local) nodecon's on a SELinux enabled system. As this is not
> implemented in semanage yet
> he gave me the advice to revive a discussion[1] on this list from
> 2006. It began because a patch against
> semanage was posted which enabled nodecon support. It seems that the
> patch never got commited
> because it didn't work as expected.

Hello,

I think the idea of adding network node support to semanage is a good 
one.  Unfortunately I have no experience with python or semanage so I'm 
probably not the best person to provide coding advice or help.

Who does look after semanage these days?

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
