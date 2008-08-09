Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m79EeNaB015822
	for <selinux@tycho.nsa.gov>; Sat, 9 Aug 2008 10:40:23 -0400
Received: from g5t0006.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m79EeN7T024286
	for <selinux@tycho.nsa.gov>; Sat, 9 Aug 2008 14:40:23 GMT
From: Paul Moore <paul.moore@hp.com>
To: paulmck@linux.vnet.ibm.com
Subject: Re: [RFC PATCH v1 2/6] netlabel: Replace protocol/NetLabel linking with refrerence counts
Date: Sat, 9 Aug 2008 10:40:18 -0400
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
References: <20080808203542.21077.37084.stgit@flek> <200808082211.32951.paul.moore@hp.com> <20080809132346.GC8125@linux.vnet.ibm.com>
In-Reply-To: <20080809132346.GC8125@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808091040.18961.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 09 August 2008 9:23:46 am Paul E. McKenney wrote:
> On Fri, Aug 08, 2008 at 10:11:32PM -0400, Paul Moore wrote:
> > On Friday 08 August 2008 6:37:16 pm Paul E. McKenney wrote:
> > > On Fri, Aug 08, 2008 at 04:53:01PM -0400, Paul Moore wrote:
> > > >  struct cipso_v4_doi *cipso_v4_doi_getdef(u32 doi)
> > > >  {
> > > > -	return cipso_v4_doi_search(doi);
> > > > +	struct cipso_v4_doi *doi_def;
> > > > +
> > > > +	rcu_read_lock();
> > > > +	doi_def = cipso_v4_doi_search(doi);
> > > > +	if (doi_def)
> > >
> > > Suppose that the doi_def element is removed by some other CPU at
> > > this point.  The reference-count check would pass (so that the
> > > deletion function would decline to error out with -EBUSY), and
> > > the removal would proceed normally.  (Right?)
> > >
> > > So we then acquire the reference count on an element that will be
> > > freed after an RCU grace period, despite the fact that the
> > > reference count might still be held at that point.
> > >
> > > Or am I missing something?  (Wouldn't be a surprise, as it is not
> > > like I am familiar with this code.)
> >
> > Hi Paul,
> >
> > Thanks for taking a look, your point sounds reasonable to me.
> >
> > > If I am correct, the usual resolution is to combine the reference
> > > count and the "valid" flag, so that a zero reference counter
> > > implies "not valid", allowing the atomic_inc() below to become
> > > atomic_inc_not_zero(), allowing you to simply return NULL should
> > > the race with removal be detected.  There are other approaches as
> > > well...
> >
> > Combining the valid and refcount fields seems reasonable to me.  I
> > took your advice and made the following changes (as well as they
> > other changes to replace the valid check with atomic_read(refcount)
> > > 0) ...
> >
> > struct cipso_v4_doi *cipso_v4_doi_getdef(u32 doi)
> > {
> > 	struct cipso_v4_doi *doi_def;
> >
> > 	rcu_read_lock();
> > 	doi_def = cipso_v4_doi_search(doi);
> > 	if (doi_def == NULL)
> > 		goto doi_getdef_return;
> > 	if (!atomic_inc_not_zero(&doi_def->refcount))
> > 		doi_def = NULL;
> >
> > doi_getdef_return:
> > 	rcu_read_unlock();
> > 	return doi_def;
> > }
> >
> > int cipso_v4_doi_remove(u32 doi,
> > 			struct netlbl_audit *audit_info,
> > 			void (*callback) (struct rcu_head * head))
> > {
> > 	struct cipso_v4_doi *doi_def;
> >
> > 	spin_lock(&cipso_v4_doi_list_lock);
> > 	doi_def = cipso_v4_doi_search(doi);
> > 	if (doi_def == NULL) {
> > 		spin_unlock(&cipso_v4_doi_list_lock);
> > 		return -ENOENT;
> > 	}
> > 	if (!atomic_dec_and_test(&doi_def->refcount)) {
> > 		spin_unlock(&cipso_v4_doi_list_lock);
> > 		return -EBUSY;
> > 	}
> > 	list_del_rcu(&doi_def->list);
> > 	spin_unlock(&cipso_v4_doi_list_lock);
> >
> > 	cipso_v4_cache_invalidate();
> > 	call_rcu(&doi_def->rcu, callback);
> >
> > 	return 0;
> > }
> >
> > Does that look better?
>
> Much better!!!
>
> Of course, any other places where you decrement ->refcount will also
> need to deal with the possibility of a zero result, right?  Or is
> the cipso_v4_doi_remove() case the only such decrement?

Yep cipso_v4_doi_putdef() needs to be fixed up too.  It looks like 
stacked-git can send mail with a specific refid so let me see if I can 
reply to this thread with an updated patch ...

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
