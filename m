Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i972RIrT011034
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 22:27:18 -0400 (EDT)
Message-ID: <01d201c4ac15$381334d0$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "James Morris" <jmorris@redhat.com>
Cc: "Stephen Smalley" <sds@epoch.ncsc.mil>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
References: <Xine.LNX.4.44.0410061156200.32613-100000@thoron.boston.redhat.com>
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
Date: Thu, 7 Oct 2004 11:27:40 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Good morning.

James Morris wrote:
> > - Updating the sel_netif_hash table is protected by spinlock_irqsave().
> >   This method is same as my RCU-patch.
> 
> Why use irqsave?  This code is never contended from irq context.

Hmm, I worried about using spinlock() without _irqsave(), since I faced to
the another problem as you know. Your notice is right.


> > # And, I wondered if 'sel_netif_total' is really necessary.
> 
> This prevents the cache from growing without bounds.

But a result of sel_netif_insert() was not checked in the original code.
It's assumed the number of 'netif' is less than SEL_NETIF_HASH_MAX.
And, Its upper limitation is the number of the real network interfaces.
Why do you think the cache may grow without bounds?

Thanks.
--------
Kai Gai <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
