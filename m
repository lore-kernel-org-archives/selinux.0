Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96KEcrT008517
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 16:14:38 -0400 (EDT)
Date: Wed, 6 Oct 2004 16:14:30 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
In-Reply-To: <Xine.LNX.4.44.0410061602000.1417-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0410061613440.1490-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Oct 2004, James Morris wrote:

> > Perhaps we need to move the rcu_read_lock/unlock to the hook functions
> > that call sel_netif_lookup?
> 
> We shouldn't push locking to the caller, there must be another way.

Actually, that's what some of the core network code is doing.  I guess it 
works.



- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
