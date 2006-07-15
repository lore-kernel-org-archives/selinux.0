Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6FDFl0u017924
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 09:15:47 -0400
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6FDFjX0011106
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 13:15:45 GMT
Date: Sat, 15 Jul 2006 09:15:40 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
In-Reply-To: <20060714185915.270209000@flek.zko.hp.com>
Message-ID: <Pine.LNX.4.64.0607150913510.24495@d.namei>
References: <20060714185739.780700000@flek.zko.hp.com>
 <20060714185915.270209000@flek.zko.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Jul 2006, paul.moore@hp.com wrote:

> +int cipso_v4_doi_add(struct cipso_v4_doi *doi_def)
> +{
> +	if (doi_def == NULL || doi_def->doi == CIPSO_V4_DOI_UNKNOWN)
> +		return -EINVAL;
> +
> +	doi_def->valid = 1;
> +	INIT_RCU_HEAD(&doi_def->rcu);
> +	INIT_LIST_HEAD(&doi_def->dom_list);
> +
> +	rcu_read_lock();
> +	if (cipso_v4_doi_search(doi_def->doi) != NULL) {
> +		rcu_read_unlock();
> +		return -EEXIST;
> +	}
> +	spin_lock(&cipso_v4_doi_list_lock);
> +	list_add_tail_rcu(&doi_def->list, &cipso_v4_doi_list);
> +	spin_unlock(&cipso_v4_doi_list_lock);
> +	rcu_read_unlock();
> +
> +	return 0;
> +}

This is racy in that you can end up with duplicate entries in the list 
between rcu_read_lock() and spin_lock().

You need to perform the search a second time under the spin_lock() as a 
slow path to verify that an entry wasn't added, before adding a new one.


- James
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
