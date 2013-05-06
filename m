Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r46DoINY019961
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2013 09:50:18 -0400
Message-ID: <5187B50C.4020106@tresys.com>
Date: Mon, 6 May 2013 09:50:04 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Clarification of labeled IPsec checks
References: <51840BF4.7000302@tresys.com> <39078390.44gaRjNkjA@sifl>
In-Reply-To: <39078390.44gaRjNkjA@sifl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/03/13 15:20, Paul Moore wrote:
> On Friday, May 03, 2013 03:11:48 PM Christopher J. PeBenito wrote:
>> I'm doing some spring cleaning on refpolicy, cleaning out some old
>> unused/unnecessary networking permissions.  I'm trying to make sure I have
>> the permissions checks straight, since labeled networking isn't common use.
>>  For labeled IPsec, we have the following permissions (assuming all policy
>> capabilities are on--assume maximum checks):
>>
>> netif: ingress/egress
>> node: sendto/recvfrom
>> peer: recv
>> association: sendto/recvfrom
>>
>> I'm told that association perms are checked in the following cases:
>>
>> sendto: when a packet leaves the box (legacy only) and when a SA/flow is
>> checked recvfrom: when an incoming packet is queued on a socket (legacy
>> only)
>>
>> Does "legacy only" mean the checks will eventually go away, or is it for a
>> legacy IPsec configuration?
> 
> In this case "legacy" refers to a SELinux policy that doesn't have the netpeer 
> policy capability enabled.

So with the capability on, you can only get a sendto check for association, never recvfrom?  Wouldn't it make more sense to have a peer send permission instead, going forward?  That way we can have the something more expected (send/recv for the same class), rather than peer:recv and association:sendto which seems confusing.
 
> It has been a while since we introduced the netpeer policy capability so I 
> imagine we could start a process of deprecating policies that don't enable it.  
> We could dump a warning message if someone loads a policy with the netpeer 
> capability disabled and then after a few releases (how many?) we could remove 
> the legacy bits from the kernel and reject policies which don't have the 
> netpeer capability set.

The common case obviously is no labeling, and in that case, there wouldn't be checks.  So I suspect this wouldn't have any real problems.  My guess is systems that use this wouldn't be changing their OS very often, and when they do, it would be major jumps (e.g. RHEL6 to RHEL7), so they'd be anticipating changes like this.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
