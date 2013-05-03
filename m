Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r43JaxbX027118
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2013 15:36:59 -0400
From: Paul Moore <pmoore@redhat.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Clarification of labeled IPsec checks
Date: Fri, 03 May 2013 15:20 -0400
Message-ID: <39078390.44gaRjNkjA@sifl>
In-Reply-To: <51840BF4.7000302@tresys.com>
References: <51840BF4.7000302@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, May 03, 2013 03:11:48 PM Christopher J. PeBenito wrote:
> I'm doing some spring cleaning on refpolicy, cleaning out some old
> unused/unnecessary networking permissions.  I'm trying to make sure I have
> the permissions checks straight, since labeled networking isn't common use.
>  For labeled IPsec, we have the following permissions (assuming all policy
> capabilities are on--assume maximum checks):
> 
> netif: ingress/egress
> node: sendto/recvfrom
> peer: recv
> association: sendto/recvfrom
> 
> I'm told that association perms are checked in the following cases:
> 
> sendto: when a packet leaves the box (legacy only) and when a SA/flow is
> checked recvfrom: when an incoming packet is queued on a socket (legacy
> only)
> 
> Does "legacy only" mean the checks will eventually go away, or is it for a
> legacy IPsec configuration?

In this case "legacy" refers to a SELinux policy that doesn't have the netpeer 
policy capability enabled.

It has been a while since we introduced the netpeer policy capability so I 
imagine we could start a process of deprecating policies that don't enable it.  
We could dump a warning message if someone loads a policy with the netpeer 
capability disabled and then after a few releases (how many?) we could remove 
the legacy bits from the kernel and reject policies which don't have the 
netpeer capability set.

Thoughts?

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
