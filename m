Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96G1LrT005824
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 12:01:21 -0400 (EDT)
Date: Wed, 6 Oct 2004 12:01:00 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
In-Reply-To: <058301c4ab69$ea86b8f0$f97d220a@linux.bs1.fc.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0410061156200.32613-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Oct 2004, Kaigai Kohei wrote:

> - Updating the sel_netif_hash table is protected by spinlock_irqsave().
>   This method is same as my RCU-patch.

Why use irqsave?  This code is never contended from irq context.

> # And, I wondered if 'sel_netif_total' is really necessary.

This prevents the cache from growing without bounds.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
