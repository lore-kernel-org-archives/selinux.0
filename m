Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p95BKs6o017337
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2011 07:20:54 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p95BKrA7017216
	for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2011 11:20:54 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20111005110843.30324.19133.stgit@warthog.procyon.org.uk>
References: <20111005110843.30324.19133.stgit@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, netdev@vger.kernel.org
Subject: Re: [PATCH] SELinux: Fix RCU deref check warning in sel_netport_insert() [ver #2]
Date: Wed, 05 Oct 2011 12:19:39 +0100
Message-ID: <30594.1317813579@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells <dhowells@redhat.com> wrote:

> +				spin_is_locked(&sel_netport_lock)),

Oops...  I forgot to commit the change.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
