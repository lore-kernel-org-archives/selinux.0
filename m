Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i09LkMRb002915
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 16:46:22 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i09LkLiV023582
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 21:46:21 GMT
Received: from thoron.boston.redhat.com (nat-pool-bos.redhat.com [66.187.230.200])
        by jazzband.ncsc.mil  with ESMTP id i09LkI08023574 for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 21:46:21 GMT
Date: Fri, 9 Jan 2004 16:46:18 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <sds@epoch.ncsc.mil>,
   <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][SELINUX] 2/7 Add netif controls
In-Reply-To: <20040109130613.711b34a6.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0401091638160.22937-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 9 Jan 2004, Andrew Morton wrote:

> James Morris <jmorris@redhat.com> wrote:
> >
> > +static void sel_netif_destroy(struct sel_netif *netif)
> > +{
> > +	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
> > +	
> > +	spin_lock_bh(&sel_netif_lock);
> > +	list_del_rcu(&netif->list);
> > +	sel_netif_total--;
> > +	spin_unlock_bh(&sel_netif_lock);
> > +
> > +	call_rcu(&netif->rcu_head, sel_netif_free, netif);
> > +}
> > +
> > +void sel_netif_put(struct sel_netif *netif)
> > +{
> > +	if (atomic_dec_and_test(&netif->users))
> > +		sel_netif_destroy(netif);
> > +}
> 
> This seems racy.  If the netif is still eligible for lookup on entry to
> sel_netif_put(), another CPU can come in and find the netif while it is
> hashed but while it has a zero refcount.  Only to have the netif destroyed
> under its feet?

The netif won't actually be freed until all of the CPUs have gone through
a quiescent state, and the calling code running on the other CPU will have
called sel_netif_put() before then.  These objects are extremely short
lived and should not be held over context switches.


- James
-- 
James Morris
<jmorris@redhat.com>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
