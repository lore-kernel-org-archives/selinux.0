Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p95DWxpu024962
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2011 09:32:59 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p95DWwIS029390
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2011 13:32:59 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2230709.7n5noARWFd@sifl>
References: <2230709.7n5noARWFd@sifl> <20111003135824.15303.10147.stgit@warthog.procyon.org.uk>
To: Paul Moore <paul@paul-moore.com>
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, netdev@vger.kernel.org
Subject: Re: [PATCH] SELinux: Fix RCU deref check warning in sel_netport_insert()
Date: Wed, 05 Oct 2011 14:32:03 +0100
Message-ID: <1624.1317821523@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore <paul@paul-moore.com> wrote:

> We should probably do the same for the security/selinux/netif.c as it uses
> the same logic; David is this something you want to tackle?

netif.c doesn't use any rcu_dereference*() function directly, though it does
use list_for_each_entry_rcu().  However, I'm not sure that's a problem.  What
is it you're referring to?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
