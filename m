Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i974NirT011526
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 00:23:44 -0400 (EDT)
Date: Thu, 7 Oct 2004 00:23:36 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
In-Reply-To: <01d801c4ac15$5c4d0a60$f97d220a@linux.bs1.fc.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0410070022530.3021-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Oct 2004, Kaigai Kohei wrote:

> Indeed, I agree it doesn't need to return the reference of 'netif' object.
> For example, should the function prototype be replaced as follows?
> 
> - struct *sel_netif *sel_netif_lookup(struct net_device *dev)
>   -> int sel_netif_lookup(struct net_device *dev, u32 *if_sid, u32 *msg_sid)
> - sel_netif_put() is discontinued.
> 
> If it's so, we can hide rcu_read_lock()/unlock() in netif.c.

Yes, we can get rid of the refcounting completely, I'm currently testing a 
new patch.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
