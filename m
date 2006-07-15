Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6FFEfNH019562
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 11:14:41 -0400
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6FFEfsi029966
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 15:14:41 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
Date: Sat, 15 Jul 2006 11:14:30 -0400
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
References: <20060714185739.780700000@flek.zko.hp.com> <20060714185915.270209000@flek.zko.hp.com> <Pine.LNX.4.64.0607150913510.24495@d.namei>
In-Reply-To: <Pine.LNX.4.64.0607150913510.24495@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607151114.30648.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 15 July 2006 9:15 am, James Morris wrote:
> On Fri, 14 Jul 2006, paul.moore@hp.com wrote:
> > +int cipso_v4_doi_add(struct cipso_v4_doi *doi_def)
> > +{
> > +	if (doi_def == NULL || doi_def->doi == CIPSO_V4_DOI_UNKNOWN)
> > +		return -EINVAL;
> > +
> > +	doi_def->valid = 1;
> > +	INIT_RCU_HEAD(&doi_def->rcu);
> > +	INIT_LIST_HEAD(&doi_def->dom_list);
> > +
> > +	rcu_read_lock();
> > +	if (cipso_v4_doi_search(doi_def->doi) != NULL) {
> > +		rcu_read_unlock();
> > +		return -EEXIST;
> > +	}
> > +	spin_lock(&cipso_v4_doi_list_lock);
> > +	list_add_tail_rcu(&doi_def->list, &cipso_v4_doi_list);
> > +	spin_unlock(&cipso_v4_doi_list_lock);
> > +	rcu_read_unlock();
> > +
> > +	return 0;
> > +}
>
> This is racy in that you can end up with duplicate entries in the list
> between rcu_read_lock() and spin_lock().
>
> You need to perform the search a second time under the spin_lock() as a
> slow path to verify that an entry wasn't added, before adding a new one.
>

Thanks, there are a few more place which might have similar problems - I'll 
check those as well.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
