Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkatesh Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>
Cc: <selinux@tycho.nsa.gov>, <jmorris@namei.org>, <sds@tycho.nsa.gov>
Subject: RE: Networking Patch (outline)
Date: Tue, 11 Sep 2007 11:37:10 -0500
Message-ID: <001301c7f492$00f83ea0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200709061334.28033.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > If we want to flow-control just once, another option to 
> consider would be
> > using rcv_skb for locally destined traffic and a new hook 
> into ip_forward()
> > for flow-control of forwarded traffic coming-in.
> 
> Yeah, that's an option, I'm just a little adverse to having 
> to add hooks in 
> the different *_rcv_skb() functions; I'd much prefer them to 
> be at a lower 
> level where we would need less hooks.  Although, we could 
> just piggyback on 
> the existing sk_filter/security_sock_recv_skb() hook since it 
> appears in most 
> of the *_rcv_skb() functions I've looked at (I suspect it's 
> in all, but 
> haven't bothered to check yet).

Piggybacking is what I meant ("using" rcv_skb and a "new" hook
into ip_forward() :).

> 
> Time to go for a walk and think about this some more ...
> 

Actually, postroute_last would be hit for each xfrm as well.
So, perhaps a separate LSM hook into say ip_output() ...

> > > > +	/* See if skb can flow in thru the interface */
> > > > +	err = sel_netif_sids(skb->dev, &if_sid, NULL);
> > > > +	if (err)
> > > > +		goto out;
> > > > +
> > > > +	err = avc_has_perm(skb->secid, if_sid,
> > > > +					SECCLASS_NETIF,
> > > > +					NETIF__FLOW_IN, &ad);
> > >
> > > I assume this is where the host/node check would go?  Would
> > > it make sense to
> > > create a combined interface/network label and check so that
> > > we could do one
> > > lookup and one access check instead of two?
> >
> > I believe it does make sense. I will ask around here to see
> > if anyone can figure out a case where it wouldn't work.
> 
> Great, thanks.  The fewer the permission checks the better I think.
> 
> -- 
> paul moore
> linux security @ hp
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
