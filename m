Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6FNRChv024572
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 19:27:12 -0400
Received: from ccerelrim01.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6FNRBX0010568
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 23:27:12 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
Date: Sat, 15 Jul 2006 19:26:43 -0400
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
References: <20060714185739.780700000@flek.zko.hp.com> <20060714185915.270209000@flek.zko.hp.com> <Pine.LNX.4.64.0607151837530.28012@d.namei>
In-Reply-To: <Pine.LNX.4.64.0607151837530.28012@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607151926.44387.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 15 July 2006 6:39 pm, James Morris wrote:
> On Fri, 14 Jul 2006, paul.moore@hp.com wrote:
> > +int cipso_v4_cache_add(const struct sk_buff *skb,
> > +		       const struct netlbl_lsm_secattr *secattr)
> > +{
>
> It seems that this cache grows without bounds, correct?

Unless I messed something up the cache is limited to  CIPSO_V4_CACHE_BUCKETS *  
cipso_v4_cache_bucketsize; see the bottom half of cipso_v4_cache_add() for 
details.

> Also, how do you handle the case of a change to a cached mapping?

Through the use of  cipso_v4_cache_invalidate() which gets called on CIPSO DOI 
deletes and SELinux policy [re]loads.  It's a bit heavy handed in that it 
clears the entire cache, but both events should be pretty rare in practice 
and the extra work to clear specific cache entries probably isn't worth it.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
