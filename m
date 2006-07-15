Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6FF9dFr019413
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 11:09:39 -0400
Received: from mailhub.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6FF9dX0022246
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 15:09:39 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
Date: Sat, 15 Jul 2006 11:09:29 -0400
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
References: <20060714185739.780700000@flek.zko.hp.com> <20060714185915.270209000@flek.zko.hp.com> <Pine.LNX.4.64.0607150905550.24495@d.namei>
In-Reply-To: <Pine.LNX.4.64.0607150905550.24495@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607151109.30338.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 15 July 2006 9:08 am, James Morris wrote:
> On Fri, 14 Jul 2006, paul.moore@hp.com wrote:
> > +struct sk_buff *cipso_v4_doi_dump_all(const size_t headroom)
> > +{
> > +	struct sk_buff *skb;
> > +	unsigned char *buf;
> > +	struct cipso_v4_doi *iter;
> > +	u32 doi_cnt = 0;
> > +	ssize_t buf_len;
> > +
> > +	/* XXX - In both cases, this is kinda ugly as we have to go through
> > +	   the list once to determine how large of a buffer we need,
> > +	   drop the locks, allocate the buffer, grab the locks, and
> > +	   finally fill the buffer.  The problem is that there is that
> > +	   open window where the table could grow and we will end up
> > +	   short on space. */
>
> This needs to be fixed.

The reasoning behind this was because I wanted to try and avoid holding the 
rcu_read_lock() while allocating memory.  I'll just change the allocation to 
GFP_ATOMIC and keep the rcu lock.

> Currently, it seems that you just bail if this happens.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
