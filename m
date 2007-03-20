From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] SELinux: use SECINITSID_NETMSG instead of SECINITSID_UNLABELED for NetLabel
Date: Tue, 20 Mar 2007 13:58:05 -0400
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Joshua Brindle <method@manicmethod.com>, dwalsh@redhat.com
References: <20070314025023.115872483@hp.com> <1174331007.22565.193.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1174331007.22565.193.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703201358.05890.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 19 March 2007 3:03:26 pm Stephen Smalley wrote:
> On Tue, 2007-03-13 at 22:50 -0400, Paul Moore wrote:
> > I'm proposing two changes to the existing SELinux/NetLabel glue code:
> >
> > 1. Switch to using SECINITSID_NETMSG for packets with NetLabel security
> >    attributes
> > 2. Add a unlabeled check for packets without NetLabel security attributes
> >    using SECINITSID_UNLABELED
>
> If you applied the second change without the first, you could
> potentially distinguish the checks based on level by assigning a unique
> level to the unlabeled initial SID that dominates all levels that can be
> legitimately received in labeled packets.  I take it that you don't see
> that as practical?

Yes, while it is both simple and tempting I don't see that solution as viable 
since it requires encoding meaning into the MLS sensitivity labels.  I 
understand that in certain other MLS implementations specific sensitivity 
labels have been given "special" meaning but I think doing so in an 
implementation as flexible as SELinux is a mistake.

> > ... The changes to the policy would
> > be straight forward with the following necessary to receive labeled
> > traffic (assuming SECINITSID_NETMSG is defined to use "netlabel_t"):
> >
> >  allow mydomain_t netlabel_t:{ tcp_socket udp_socket rawip_socket }
> > recvfrom;
> >
> > The policy for unlabeled traffic would be:
> >
> >  allow mydomain_t unlabeled_t:{ tcp_socket udp_socket rawip_socket }
> > recvfrom;
>
> Have you thought through the compatibility issues for old kernel / new
> policy and new kernel / old policy pairings?  Also, note that policy
> reload won't alter the initial SID mappings, so those will only get
> updated upon reboot.  So you could have kernel with old initial SID
> mappings but new allow rules effective.

I have given some passing thought to this, but I'll admit to not having 
solutions for every angle of this ... yet.  I posted this as an RFC patch 
because before I put to much effort into this I wanted to make sure the basic 
idea was acceptable to the community at large.  So far only you and Joshua 
have responded and while Joshua didn't seem to be too excited by it, he did 
appear to understand the need for such a change.  Assuming the compatibility 
issues can be resolved, would you be in favor of such a change?  I ask 
because from what I heard last week you are _always_ right ;)

To get back to the compatibility question, current policy gives unrestricted 
access to NetLabel (this may only be in RHEL5 right now but Dan Walsh said he 
will be submitting the upstream [add Dan to the CC line]):

 allow domains unlabeled_t:{ tcp_socket udp_socket rawip_socket } recvfrom;

So in the worst case of a new policy on an old kernel, rebooted with a newly 
defined SECINITSID_NETMSG value only domains which are only allowed to 
receive NetLabel traffic will be blocked.  I consider this acceptable as it 
is likely that anyone wishing to restrict domains only to labeled traffic 
will want to upgrade to a kernel which supports this functionality.

Like I said, it still needs more thought, i.e. all the combinations need to be 
evaluated, but I think it should be doable.  If all else fails, we would need 
to put a little more effort into solving RH BZ #195238 and then make use of 
this new functionality to toggle a compatibility mode.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
