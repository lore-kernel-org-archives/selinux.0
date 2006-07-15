Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6FMe2w7024117
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 18:40:02 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6FMe0si017057
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 22:40:01 GMT
Date: Sat, 15 Jul 2006 18:39:57 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
In-Reply-To: <20060714185915.270209000@flek.zko.hp.com>
Message-ID: <Pine.LNX.4.64.0607151837530.28012@d.namei>
References: <20060714185739.780700000@flek.zko.hp.com>
 <20060714185915.270209000@flek.zko.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Jul 2006, paul.moore@hp.com wrote:

> +int cipso_v4_cache_add(const struct sk_buff *skb,
> +		       const struct netlbl_lsm_secattr *secattr)
> +{

It seems that this cache grows without bounds, correct?

Also, how do you handle the case of a change to a cached mapping?



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
