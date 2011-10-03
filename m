Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p93N8aQS022689
	for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2011 19:08:36 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p93N8Zun003470
	for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2011 23:08:35 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2230709.7n5noARWFd@sifl>
References: <2230709.7n5noARWFd@sifl> <20111003135824.15303.10147.stgit@warthog.procyon.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, netdev@vger.kernel.org
Subject: Re: [PATCH] SELinux: Fix RCU deref check warning in sel_netport_insert()
Date: Tue, 04 Oct 2011 00:07:42 +0100
Message-ID: <25906.1317683262@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore <paul@paul-moore.com> wrote:

> We should probably do the same for the security/selinux/netif.c as it uses
> the same logic; David is this something you want to tackle?

I can have a look, but it won't be before Wednesday.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
