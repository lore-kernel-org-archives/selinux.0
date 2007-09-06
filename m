From: Paul Moore <paul.moore@hp.com>
To: vyekkirala@TrustedCS.com
Subject: Re: Networking Patch (outline)
Date: Thu, 6 Sep 2007 13:34:27 -0400
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
References: <001101c7f0a0$1a45bcc0$cc0a010a@tcssec.com>
In-Reply-To: <001101c7f0a0$1a45bcc0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709061334.28033.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, September 6 2007 12:08:02 pm Venkatesh Yekkirala wrote:
> > > 4. Currently this patch modifies xfrm_policy_check()
> > >    to also perform the flow_in checks. This is awkward and
> > >    a separate call into LSM right after the xfrm_policy_check
> > >    invocations would be cleaner.
> >
> > It would be great if we could do something with a netfilter
> > PRE_ROUTING hook
> > similar to how we handle outbound packets with a POST_ROUTING
> > hook.  I just
> > spent some time looking at the XFRM input code path and it
> > looks like AH/ESP
> > transport packets make two trips through the PRE_ROUTING
> > hook, once before
> > the transformation (skb->sp == NULL) and once afterwards
> > (skb->sp != NULL).
> > Tunnel mode transforms should be handled because they run
> > back through the
> > stack starting with the initial IP receive routine so they
> > will be caught the
> > second time around.  However, I haven't spent as much time
> > looking at either
> > the labeled IPsec or flow control bits as you so I might be
> > overlooking some
> > important things.  Does this sound like it might work from a
> > labeled IPsec
> > point of view?
>
> It may not work in all cases; say we have an AH xfrm on top of
> ESP. At the point AH has been resolved skb->sp would be non-NULL
> but we still wouldn't know the actual source and destination addresses
> until ESP has been resolved. At the policy_check time ALL the xfrms
> would have been resolved and the packet available in its true colors.

Bah!  Yep, you're right ... bummer, I was starting to like that idea.  Thanks 
for catching this.

> However this still doesn't handle UDP-encapsulated IPSec packets very well
> since policy_check happens BEFORE the packet is checked for encapsulation.
> See udp_queue_rcv_skb().

Good 'ole UDP encapsulated IPsec packets, what a mess those are ... I hate 
NAT.  From the labeled networking point of view I think the worst thing here 
is that at the IP layer these packets are always going to look "unlabeled" as 
it's not until the UDP layer that the packet becomes an IPsec packet and then 
goes back through the stack.

If it weren't for those we could probably just do something before we call 
dst_input().

> I guess first of all we need to decide whether it makes sense to perform
> SELinux flow controls on packets only one time on a packet after the packet
> has gone thru ALL iterations thru the stack or each time it goes thru the
> stack, keeping in mind other tunneling protos such as ipip.

I'm pretty sure the right thing to do here is to only apply a flow control 
once on the way in and once on the way out.  While this might be hard to 
implement it makes the most sense conceptually which is what really matters.  
We need to make it easy for the policy writers and the security admins, even 
if it does make our lives difficult :(

> If we want to flow-control just once, another option to consider would be
> using rcv_skb for locally destined traffic and a new hook into ip_forward()
> for flow-control of forwarded traffic coming-in.

Yeah, that's an option, I'm just a little adverse to having to add hooks in 
the different *_rcv_skb() functions; I'd much prefer them to be at a lower 
level where we would need less hooks.  Although, we could just piggyback on 
the existing sk_filter/security_sock_recv_skb() hook since it appears in most 
of the *_rcv_skb() functions I've looked at (I suspect it's in all, but 
haven't bothered to check yet).

Time to go for a walk and think about this some more ...

> > > +	/* See if skb can flow in thru the interface */
> > > +	err = sel_netif_sids(skb->dev, &if_sid, NULL);
> > > +	if (err)
> > > +		goto out;
> > > +
> > > +	err = avc_has_perm(skb->secid, if_sid,
> > > +					SECCLASS_NETIF,
> > > +					NETIF__FLOW_IN, &ad);
> >
> > I assume this is where the host/node check would go?  Would
> > it make sense to
> > create a combined interface/network label and check so that
> > we could do one
> > lookup and one access check instead of two?
>
> I believe it does make sense. I will ask around here to see
> if anyone can figure out a case where it wouldn't work.

Great, thanks.  The fewer the permission checks the better I think.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
