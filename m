Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r47D5cSu026082
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2013 09:05:39 -0400
From: Paul Moore <pmoore@redhat.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Clarification of labeled IPsec checks
Date: Tue, 07 May 2013 09:05:30 -0400
Message-ID: <1703453.4GWkgsHxla@sifl>
In-Reply-To: <5187B50C.4020106@tresys.com>
References: <51840BF4.7000302@tresys.com> <39078390.44gaRjNkjA@sifl> <5187B50C.4020106@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, May 06, 2013 09:50:04 AM Christopher J. PeBenito wrote:
> On 05/03/13 15:20, Paul Moore wrote:
> > On Friday, May 03, 2013 03:11:48 PM Christopher J. PeBenito wrote:
> >> I'm doing some spring cleaning on refpolicy, cleaning out some old
> >> unused/unnecessary networking permissions.  I'm trying to make sure I
> >> have the permissions checks straight, since labeled networking isn't
> >> common use.
> >> 
> >>  For labeled IPsec, we have the following permissions (assuming all
> >>  policy
> >> 
> >> capabilities are on--assume maximum checks):
> >> 
> >> netif: ingress/egress
> >> node: sendto/recvfrom
> >> peer: recv
> >> association: sendto/recvfrom
> >> 
> >> I'm told that association perms are checked in the following cases:
> >> 
> >> sendto: when a packet leaves the box (legacy only) and when a SA/flow is
> >> checked recvfrom: when an incoming packet is queued on a socket (legacy
> >> only)
> >> 
> >> Does "legacy only" mean the checks will eventually go away, or is it for
> >> a legacy IPsec configuration?
> > 
> > In this case "legacy" refers to a SELinux policy that doesn't have the
> > netpeer policy capability enabled.
> 
> So with the capability on, you can only get a sendto check for association,
> never recvfrom?

It might be worthwhile for you to look at the code, all the answers you're 
looking for are in there ...

The association:recvfrom check happens in selinux_xfrm_sock_rcv_skb() which is 
now a legacy function/hook.  The association:sendto check happens in 
selinux_xfrm_postroute_last() and selinux_xfrm_state_pol_flow_match(); the 
XFRM postroute hook is a legacy function and the flow_match hook is not.

The legacy XFRM sock_rcv_skb() hook is replaced by the peer:recv check in 
selinux_socket_sock_rcv_skb().  The legacy XFRM postroute hook is replaced by 
the checks in selinux_ip_postroute().

> Wouldn't it make more sense to have a peer send permission instead, going
> forward?

Huh?  Why?  To replace the association:sendto check in the XFRM 
pol_flow_match() hook?  I don't think so, there isn't any "peer" checking 
happening there, just matching SAs/policies.

Did you mean something else?  Or am I misunderstanding you?

> That way we can have the something more expected (send/recv for the same
> class), rather than peer:recv and association:sendto which seems confusing.

I think you may be misunderstanding the association:sendto check that is 
happening in the pol_flow_match() hook.  This is probably compounded a bit by 
the poor name for the permission, but it was has been there forever and 
unfortunately it isn't likely to change anytime soon ...

> > It has been a while since we introduced the netpeer policy capability so I
> > imagine we could start a process of deprecating policies that don't enable
> > it. We could dump a warning message if someone loads a policy with the
> > netpeer capability disabled and then after a few releases (how many?) we
> > could remove the legacy bits from the kernel and reject policies which
> > don't have the netpeer capability set.
> 
> The common case obviously is no labeling, and in that case, there wouldn't
> be checks.  So I suspect this wouldn't have any real problems.  My guess is
> systems that use this wouldn't be changing their OS very often, and when
> they do, it would be major jumps (e.g. RHEL6 to RHEL7), so they'd be
> anticipating changes like this.

Yeah, I agree.  I'll throw together a deprecation patch and toss it out so we 
can have a bit more of a discussion on this.

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
