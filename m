Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i972lqrT011097
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 22:47:53 -0400 (EDT)
Message-ID: <01d801c4ac15$5c4d0a60$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>,
   "James Morris" <jmorris@redhat.com>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
References: <Xine.LNX.4.44.0410061602000.1417-100000@thoron.boston.redhat.com> <1097093531.11370.100.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
Date: Thu, 7 Oct 2004 11:28:41 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Good morning.

Thu, Oct 07, 2004 5:12 AM
Stephen Smalley wrote:
> > > Perhaps we need to move the rcu_read_lock/unlock to the hook functions
> > > that call sel_netif_lookup?
> > 
> > We shouldn't push locking to the caller, there must be another way.
> 
> Comparing with the AVC, we have avc_has_perm_noaudit() perform the
> rcu_read_lock/unlock, but it holds the lock until it has copied the
> result, and merely returns a copy of the decision to the caller, not a
> reference to a node itself.  You could do likewise for sel_netif_lookup
> and only have it return copies of the SIDs to the caller.  The netif AVC
> entry reference is obsolete anyway with the introduction of RCU for the
> AVC.  No need for any atomic operations on the read path, which is one
> of the stated purposes of RCU (Documentation/RCU/rcu.txt) - readers need
> not acquire any locks, perform any atomic instructions, ...

Indeed, I agree it doesn't need to return the reference of 'netif' object.
For example, should the function prototype be replaced as follows?

- struct *sel_netif *sel_netif_lookup(struct net_device *dev)
  -> int sel_netif_lookup(struct net_device *dev, u32 *if_sid, u32 *msg_sid)
- sel_netif_put() is discontinued.

If it's so, we can hide rcu_read_lock()/unlock() in netif.c.

In my previous patch, caller is under the rcu_read_lock() when sel_netif_lookup()
returns success. I don't think it's a significant issue, because it's like
XXXX_trylock(). But Stephen's suggestion is better.

Thanks.
--------
Kai Gai <kaigai@ak.jp.nec.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
