Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pBGDE9jC023828
	for <selinux@tycho.nsa.gov>; Fri, 16 Dec 2011 08:14:10 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pBGDE8dY002030
	for <selinux@tycho.nsa.gov>; Fri, 16 Dec 2011 13:14:08 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.LRH.2.00.1112141011380.20373@tundra.namei.org>
References: <alpine.LRH.2.00.1112141011380.20373@tundra.namei.org> <20111213144904.14176.96568.stgit@warthog.procyon.org.uk>
To: James Morris <jmorris@namei.org>
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] SELinux: Fix RCU deref check warning in sel_netport_insert()
Date: Fri, 16 Dec 2011 13:13:58 +0000
Message-ID: <11853.1324041238@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris <jmorris@namei.org> wrote:

> On Tue, 13 Dec 2011, David Howells wrote:
> 
> > Fix the following bug in sel_netport_insert() where rcu_dereference() should
> > be rcu_dereference_protected() as sel_netport_lock is held.
> > 
> 
> Which kernel should this go to?

I'm applying it to Linus's git head.  It probably needs to go to some stable
trees too, I suppose.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
