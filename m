Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96K3vrT008381
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 16:03:57 -0400 (EDT)
Date: Wed, 6 Oct 2004 16:03:45 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
In-Reply-To: <1097091790.11370.72.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0410061602000.1417-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Oct 2004, Stephen Smalley wrote:

> Doesn't this still allow the netif to be destroyed (e.g. upon
> preemption) while it is still in use by a hook function? 

Yes, if the hook function gets preempted.

> Perhaps we need to move the rcu_read_lock/unlock to the hook functions
> that call sel_netif_lookup?

We shouldn't push locking to the caller, there must be another way.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
