Subject: Re: [PATCH] SELinux: Use unknown perm handling to handle unknown
 netlink msg types
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <200811051138.59683.paul.moore@hp.com>
References: <1225895682.3300.111.camel@localhost.localdomain>
	 <200811051138.59683.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 07 Nov 2008 11:07:41 -0500
Message-Id: <1226074061.3339.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-11-05 at 11:38 -0500, Paul Moore wrote:
> On Wednesday 05 November 2008 9:34:42 am Eric Paris wrote:
> > Currently when SELinux has not been updated to handle a netlink
> > message type the operation is denied with EINVAL.  This patch will
> > leave the audit/warning message so things get fixed but if policy
> > chose to allow unknowns this will allow the netlink operation.
> >
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> >
> >  security/selinux/hooks.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index f85597a..c6f8f3e 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4387,7 +4387,7 @@ static int selinux_nlmsg_perm(struct sock *sk,
> > struct sk_buff *skb) "SELinux:  unrecognized netlink message"
> >  				  " type=%hu for sclass=%hu\n",
> >  				  nlh->nlmsg_type, isec->sclass);
> > -			if (!selinux_enforcing)
> > +			if (!selinux_enforcing || security_get_allow_unknown())
> >  				err = 0;
> >  		}
> 
> What about moving the security_get_allow_unknown() call to the default 
> switch clause of selinux_nlmsg_lookup()?  Something like this:
> 
>         /* No messaging from userspace, or class unknown/unhandled */
>         default:
>                 if (!security_get_allow_unknown())
> 			err = -ENOENT;
>                 break;
> 
> This seems like a more natural fit to me (although maybe the audit 
> message should be moved to selinux_nlmsg_lookup() too?) and it has the 
> benefit of still checking the socket permissions via socket_has_perm() 
> in the event that the netlink message is unknown.

We already just blindly allow the case where a new/unknown sclass is
used which is what this part of the switch statement hits.  I wanted to
get the case where a known class has a new mesg type (aka nlmsg_perm
returns -EINVAL)

Not sure that the socket check is worth anything since I don't (in
either case) know what perms to ask for.

I also considered making the case of unknown msg type return ALL of the
perms for that entire socket class but I think what I did is the
best/easiest way we can go....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
