Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m858qF7X020268
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 04:52:16 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m858pZDN000843
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 08:51:37 GMT
Date: Fri, 5 Sep 2008 18:51:46 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v4 02/14] selinux: Better local/forward check in
 selinux_ip_postroute()
In-Reply-To: <20080903004854.15669.95990.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0809051851230.2526@tundra.namei.org>
References: <20080903003647.15669.45349.stgit@flek.lan> <20080903004854.15669.95990.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Sep 2008, Paul Moore wrote:

> It turns out that checking to see if skb->sk is NULL is not a very good
> indicator of a forwarded packet as some locally generated packets also have
> skb->sk set to NULL.  Fix this by not only checking the skb->sk field but also
> the IP[6]CB(skb)->flags field for the IP[6]SKB_FORWARDED flag.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
> 
>  security/selinux/hooks.c |   36 +++++++++++++++++++++++++++---------
>  1 files changed, 27 insertions(+), 9 deletions(-)

Acked-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
