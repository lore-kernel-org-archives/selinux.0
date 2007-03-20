Subject: Re: [RFC] SELinux: use SECINITSID_NETMSG instead of
	SECINITSID_UNLABELED for NetLabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Joshua Brindle <method@manicmethod.com>, dwalsh@redhat.com
In-Reply-To: <200703201358.05890.paul.moore@hp.com>
References: <20070314025023.115872483@hp.com>
	 <1174331007.22565.193.camel@moss-spartans.epoch.ncsc.mil>
	 <200703201358.05890.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 20 Mar 2007 14:43:31 -0400
Message-Id: <1174416211.22565.286.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-20 at 13:58 -0400, Paul Moore wrote:
> Yes, while it is both simple and tempting I don't see that solution as viable 
> since it requires encoding meaning into the MLS sensitivity labels.  I 
> understand that in certain other MLS implementations specific sensitivity 
> labels have been given "special" meaning but I think doing so in an 
> implementation as flexible as SELinux is a mistake.

I wasn't actually suggesting any special or fixed meaning for a
particular label value in the code, just assigning the unlabeled SID a
level that dominates all of the levels that are legitimate for the
system in policy (which is actually what current policy does - unlabeled
sid is mapped to mls_systemhigh definition in refpolicy), and then using
the ordinary MLS logic to ensure that packets with such a level cannot
be received without network MLS overrides.  Then any non-MLS-privileged
application would be denied access to such "unlabeled" packets, vs. the
netlabel'd packets that would have a MLS value < systemhigh.  Same
situation as for unlabeled filesystems - they have to be treated as
systemhigh under MLS.  So what is your goal?  Do you want to allow
non-netlabel'd packets under MLS (problematic then to use unlabeled SID
as the basis) or deny it?

> I have given some passing thought to this, but I'll admit to not having 
> solutions for every angle of this ... yet.  I posted this as an RFC patch 
> because before I put to much effort into this I wanted to make sure the basic 
> idea was acceptable to the community at large.  So far only you and Joshua 
> have responded and while Joshua didn't seem to be too excited by it, he did 
> appear to understand the need for such a change.  Assuming the compatibility 
> issues can be resolved, would you be in favor of such a change?  I ask 
> because from what I heard last week you are _always_ right ;)

Depends on whether it actually solves the problem any better than what
we have currently.  And I'm not always right, no matter what Karl
says ;)

> To get back to the compatibility question, current policy gives unrestricted 
> access to NetLabel (this may only be in RHEL5 right now but Dan Walsh said he 
> will be submitting the upstream [add Dan to the CC line]):
> 
>  allow domains unlabeled_t:{ tcp_socket udp_socket rawip_socket } recvfrom;
> 
> So in the worst case of a new policy on an old kernel, rebooted with a newly 
> defined SECINITSID_NETMSG value only domains which are only allowed to 
> receive NetLabel traffic will be blocked.  I consider this acceptable as it 
> is likely that anyone wishing to restrict domains only to labeled traffic 
> will want to upgrade to a kernel which supports this functionality.

IIUC, old/existing kernels skip the check altogether for non-netlabel'd
traffic and apply the check with a context derived from base SID
SECINITSID_UNLABELED (plus netlabel MLS value) for netlabel'd traffic,
and old/existing policy allows the check for unlabeled_t (if the MLS
constraint passes on the MLS value).  New kernels would always apply the
check, using SECINITSID_UNLABELED for non-netlabel'd traffic and a
context derived from base SID SECINITSID_NETMSG (plus netlabel MLS
value) for netlabel'd traffic, allowing the check for netlabel_t (if the
MLS constraint passes).  What would new policy do for unlabeled_t with
SystemHigh?  I'd expect the check to fail in that case even if you allow
it in the TE policy due to the MLS constraints except for processes with
MLS overrides.

So as I see it, the situation would be:
1) old kernel / new policy - still no checking of non-netlabel'd
traffic, and checks for netlabel'd traffic will still be based on
SECINITSID_UNLABELED, so it depends on what is allowed for unlabeled_t
in new policy - possibly no breakage here,
2) new kernel / old policy - checks for non-netlabel'd traffic will be
against SECINITSID_UNLABELED (TE allowed, MLS denied except for
processes with MLS overrides), checks for netlabel'd traffic will be
against SECINITSID_NETMSG but will end up mapping to the unlabeled
context still in the old policy, so likely TE allowed and MLS will
depend on the particular value in the packet.  Here I expect breakage
from the denials on non-netlabel'd traffic.
3) new kernel / old policy -> new policy on reload - if the new policy
drops access to unlabeled_t, then in this scenario we will end up
denying access on all traffic since the initial SIDs won't be remapped
until reboot.

> Like I said, it still needs more thought, i.e. all the combinations need to be 
> evaluated, but I think it should be doable.  If all else fails, we would need 
> to put a little more effort into solving RH BZ #195238 and then make use of 
> this new functionality to toggle a compatibility mode.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
