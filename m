Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m919EOqB012855
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 05:14:24 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m919DKHK020753
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 09:13:20 GMT
Date: Wed, 1 Oct 2008 19:14:23 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH v6 10/16] netlabel: Add network address selectors to
 the NetLabel/LSM domain mapping
In-Reply-To: <20080916125654.17132.86183.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0810011914070.6732@tundra.namei.org>
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125654.17132.86183.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 16 Sep 2008, Paul Moore wrote:

> This patch extends the NetLabel traffic labeling capabilities to individual
> packets based not only on the LSM domain but the by the destination address
> as well.  The changes here only affect the core NetLabel infrastructre,
> changes to the NetLabel KAPI and individial protocol engines are also
> required but are split out into a different patch to ease review.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Reviewed-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
