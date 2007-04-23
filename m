From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] SELinux: use SECINITSID_NETMSG instead of SECINITSID_UNLABELED for NetLabel
Date: Mon, 23 Apr 2007 14:56:30 -0400
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Joshua Brindle <method@manicmethod.com>, dwalsh@redhat.com
References: <20070314025023.115872483@hp.com> <200703201358.05890.paul.moore@hp.com> <1174416211.22565.286.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1174416211.22565.286.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200704231456.30910.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It's spring here in the New England states with a projected high temperature 
of 91F degrees so it's time to do a little spring cleaning of my INBOX/Todo 
List ...

On Tuesday 20 March 2007 2:43:31 pm Stephen Smalley wrote:
> On Tue, 2007-03-20 at 13:58 -0400, Paul Moore wrote:
> > To get back to the compatibility question, current policy gives
> > unrestricted access to NetLabel (this may only be in RHEL5 right now but
> > Dan Walsh said he will be submitting the upstream [add Dan to the CC
> > line]):
> >
> >  allow domains unlabeled_t:{ tcp_socket udp_socket rawip_socket }
> > recvfrom;
> >
> > So in the worst case of a new policy on an old kernel, rebooted with a
> > newly defined SECINITSID_NETMSG value only domains which are only allowed
> > to receive NetLabel traffic will be blocked.  I consider this acceptable
> > as it is likely that anyone wishing to restrict domains only to labeled
> > traffic will want to upgrade to a kernel which supports this
> > functionality.
>
> IIUC, old/existing kernels skip the check altogether for non-netlabel'd
> traffic and apply the check with a context derived from base SID
> SECINITSID_UNLABELED (plus netlabel MLS value) for netlabel'd traffic,
> and old/existing policy allows the check for unlabeled_t (if the MLS
> constraint passes on the MLS value).

Yep, that's correct.

> New kernels would always apply the 
> check, using SECINITSID_UNLABELED for non-netlabel'd traffic and a
> context derived from base SID SECINITSID_NETMSG (plus netlabel MLS
> value) for netlabel'd traffic, allowing the check for netlabel_t (if the
> MLS constraint passes).

Yep.  The only clarification I have for the above statement is that incoming 
non-netlabel'd traffic, i.e. packets labeled 
SECINITSID_UNLABELED/unlabeled_t, would have a MLS constraint override 
similar to what is done for labeled IPsec.  This was already discussed 
earlier in the thread but after you made the comments below.

> What would new policy do for unlabeled_t with 
> SystemHigh?  I'd expect the check to fail in that case even if you allow
> it in the TE policy due to the MLS constraints except for processes with
> MLS overrides.

See the above comment regarding MLS constraints on unlabeled_t; this should 
not be an issue.

> So as I see it, the situation would be:
> 1) old kernel / new policy - still no checking of non-netlabel'd
> traffic, and checks for netlabel'd traffic will still be based on
> SECINITSID_UNLABELED, so it depends on what is allowed for unlabeled_t
> in new policy - possibly no breakage here,

In this situation the only problem I see is a MLS user making use of NetLabel. 
Labeled traffic will be labeled with unlabeled_t which according to the new 
policy has a MLS override associated with it which could result in previously 
denied traffic now being allowed.  This happens regardless of if the kernerl 
is rebooted or not after installing the new policy as the old kernel will 
always use SECINITSID_UNLABELED for the NetLabel "base SID".

I can't think of a good solution to this case other than to have the user 
upgrade the kernel along with the policy.  The only saving grace here is that 
this only affects users who care about both MLS and NetLabel - so none of you 
TE guys should care ;)

> 2) new kernel / old policy - checks for non-netlabel'd traffic will be
> against SECINITSID_UNLABELED (TE allowed, MLS denied except for
> processes with MLS overrides), checks for netlabel'd traffic will be
> against SECINITSID_NETMSG but will end up mapping to the unlabeled
> context still in the old policy, so likely TE allowed and MLS will
> depend on the particular value in the packet.  Here I expect breakage
> from the denials on non-netlabel'd traffic.

Here both SECINITSID_UNLABELED and SECINITSID_NETMSG are going to map to 
unlabeled_t and the kernel will perform a check against the receiving domain 
and unlabeled_t for both the labeled and unlabeled case as a result.  As you 
stated above, in the unlabeled traffic case this should most likely be fine 
from a TE point of view but could cause problems with people running MLS 
policies depending on the MLS label of the receiving domain.  In the case of 
labeled traffic there really shouldn't be any noticeable change from the 
old/current behavior.

> 3) new kernel / old policy -> new policy on reload - if the new policy
> drops access to unlabeled_t, then in this scenario we will end up
> denying access on all traffic since the initial SIDs won't be remapped
> until reboot.

Yes, but I think by default we would allow unlabeled traffic much like we do 
now for labeled IPsec.  The only real problem would be third-party policy 
modules which haven't been updated.  In this case I think dropping all 
traffic would be the "safe" thing to do.

The next logical questions are first, does anyone have a good idea on how to 
solve these compatibility breaks?  Second, assuming there is not an easy fix, 
do people consider the issues above to be deal breakers?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
