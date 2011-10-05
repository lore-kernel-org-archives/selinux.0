Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p95B8Jso016592
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2011 07:08:19 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p95B8IA7014539
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2011 11:08:18 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1317702176.2784.4.camel@edumazet-laptop>
References: <1317702176.2784.4.camel@edumazet-laptop> <20111003135824.15303.10147.stgit@warthog.procyon.org.uk> <2230709.7n5noARWFd@sifl>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: dhowells@redhat.com, Paul Moore <paul@paul-moore.com>,
        selinux@tycho.nsa.gov, netdev@vger.kernel.org
Subject: Re: [PATCH] SELinux: Fix RCU deref check warning in sel_netport_insert()
Date: Wed, 05 Oct 2011 12:07:19 +0100
Message-ID: <23105.1317812839@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Usual way is to use :
> 	rcu_dereference_protected(
> 		sel_netport_hash[idx].list.prev,
> 		lockdep_is_held(&sel_netport_lock)),

Good point.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
