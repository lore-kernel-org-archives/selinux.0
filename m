Message-ID: <1512064629.19682.21.camel@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
To: David Ahern <dsahern@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>,
 James Morris <james.l.morris@oracle.com>
Cc: Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, Stephen
 Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov, LSM
 <linux-security-module@vger.kernel.org>
Date: Thu, 30 Nov 2017 09:57:09 -0800
In-Reply-To: <d29937fd-dd04-8568-f89c-505ff725761a@gmail.com>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
 <alpine.LFD.2.20.1711301130330.17322@localhost>
 <ae2e71e4-c366-5a1e-9fd6-4de944f4a158@schaufler-ca.com>
 <1512039044.19682.12.camel@gmail.com>
 <b92c6b3d-5c7e-9859-4bb2-b1a0aa64d86b@gmail.com>
 <d29937fd-dd04-8568-f89c-505ff725761a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-11-30 at 10:30 -0700, David Ahern wrote:
> On 11/30/17 8:44 AM, David Ahern wrote:
> > On 11/30/17 3:50 AM, Eric Dumazet wrote:
> > > @@ -1631,24 +1659,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >  
> > >  	th = (const struct tcphdr *)skb->data;
> > >  	iph = ip_hdr(skb);
> > > -	/* This is tricky : We move IPCB at its correct location
> > > into TCP_SKB_CB()
> > > -	 * barrier() makes sure compiler wont play
> > > fool^Waliasing games.
> > > -	 */
> > > -	memmove(&TCP_SKB_CB(skb)->header.h4, IPCB(skb),
> > > -		sizeof(struct inet_skb_parm));
> > > -	barrier();
> > > -
> > > -	TCP_SKB_CB(skb)->seq = ntohl(th->seq);
> > > -	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th-
> > > >syn + th->fin +
> > > -				    skb->len - th->doff * 4);
> > > -	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
> > > -	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
> > > -	TCP_SKB_CB(skb)->tcp_tw_isn = 0;
> > > -	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
> > > -	TCP_SKB_CB(skb)->sacked	 = 0;
> > > -	TCP_SKB_CB(skb)->has_rxtstamp =
> > > -			skb->tstamp || skb_hwtstamps(skb)-
> > > >hwtstamp;
> > > -
> > >  lookup:
> > >  	sk = __inet_lookup_skb(&tcp_hashinfo, skb,
> > > __tcp_hdrlen(th), th->source,
> > >  			       th->dest, sdif, &refcounted);
> > 
> > I believe moving the above is going to affect lookups with VRF. Let
> > me
> > take a look before this gets committed.
> > 
> 
> Eric:
> 
> Can you add this to the patch? Fixes socket lookups with VRF which
> stashes a flag in the cb.
> 
> Thanks,
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4e09398009c1..6c020015d556 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -849,7 +849,7 @@ static inline bool inet_exact_dif_match(struct
> net
> *net, struct sk_buff *skb)
>  {
>  #if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
>         if (!net->ipv4.sysctl_tcp_l3mdev_accept &&
> -           skb && ipv4_l3mdev_skb(TCP_SKB_CB(skb)->header.h4.flags))
> +           skb && ipv4_l3mdev_skb(IPCB(skb)->flags))
>                 return true;
>  #endif
>         return false;


I wonder if this should not be in a separate patch ?

Bug was added in 971f10eca186cab238c49daa91f703c5a001b0b1 ("tcp: better
TCP_SKB_CB layout to reduce cache line misses")  in linux 3.18

While VRF was added later.

If you agree, I will prepare a patch series, with different Fixes tag
so that David can decide which path needs to be backported into each
stable version.

Thanks.
