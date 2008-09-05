Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m85Lwcuw022179
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 17:58:38 -0400
Received: from g1t0029.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m85Lvxn6008880
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 21:58:00 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v4 02/14] selinux: Better local/forward check in selinux_ip_postroute()
Date: Fri, 5 Sep 2008 17:58:35 -0400
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20080903003647.15669.45349.stgit@flek.lan> <20080903004854.15669.95990.stgit@flek.lan> <alpine.LRH.1.10.0809051851230.2526@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0809051851230.2526@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809051758.35242.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 05 September 2008 4:51:46 am James Morris wrote:
> On Tue, 2 Sep 2008, Paul Moore wrote:
> > It turns out that checking to see if skb->sk is NULL is not a very
> > good indicator of a forwarded packet as some locally generated
> > packets also have skb->sk set to NULL.  Fix this by not only
> > checking the skb->sk field but also the IP[6]CB(skb)->flags field
> > for the IP[6]SKB_FORWARDED flag.
> >
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
> > ---
> >
> >  security/selinux/hooks.c |   36
> > +++++++++++++++++++++++++++--------- 1 files changed, 27
> > insertions(+), 9 deletions(-)
>
> Acked-by: James Morris <jmorris@namei.org>

Thanks for taking the time to review the patches and send feedback, I 
know they weren't small.  I've made all the corrections you've 
suggested as well as the ones that Andrew and Randy pointed out.  I'm 
building a new kernel to test right now, if all goes well I'll push the 
new bits tonight or tomorrow.

I've also added all your ACKs to their respective patches except for 
this one because I made some non-trivial changes and didn't think it 
was fair to use your ACK.  While I was looking at the code I realized 
that we are calling selinux_parse_skb() in the per-packet processing 
functions a bit too early (my fault) resulting in potentially wasted 
cycles.  I've fixed it in this patch and you'll see the change 
shortly ...

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
