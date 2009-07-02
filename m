From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v1] There is a problem where packets being sent by the TUN driver are not
Date: Thu, 2 Jul 2009 12:57:58 -0400
Cc: selinux@tycho.nsa.gov
References: <20090701221257.7590.75518.stgit@flek.lan> <1246536447.13464.245.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246536447.13464.245.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200907021257.58213.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 02 July 2009 08:07:27 am Stephen Smalley wrote:
> On Wed, 2009-07-01 at 18:12 -0400, Paul Moore wrote:
> > correctly handled by SELinux in the postrouting code.  The issue is that
> > the SELinux network access controls rely on a packet's associated sock,
> > when present, for it's security label.  The TUN driver does create a sock
> > to send network traffic but it only calls into the LSM/SELinux code once
> > via the security_sk_alloc() hook which never fully initializes the sock's
> > label.  This patch attempts to correct this problem by adding additional
> > checks in the SELinux security_sk_alloc() alloc code to determine if the
> > TUN driver is allocating a socket and if so, set the socket's label.
> >
> > NOTE: this is an RFC patch intended to demonstrate a possible solution
> > not discussed earlier; it is crude, untested and only deals with SELinux.
> >  Please take a look and see if this approach is even worth pursuing ...
> > thanks. ---
> >
> >  include/linux/security.h |    7 ++++---
> >  net/core/sock.c          |    2 +-
> >  security/capability.c    |    2 +-
> >  security/security.c      |    4 ++--
> >  security/selinux/hooks.c |   43
> > ++++++++++++++++++++++++------------------- 5 files changed, 32
> > insertions(+), 26 deletions(-)
> >
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 15c2a08..dde57d1 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -298,16 +298,21 @@ static void superblock_free_security(struct
> > super_block *sb) kfree(sbsec);
> >  }
> >
> > -static int sk_alloc_security(struct sock *sk, int family, gfp_t
> > priority) +static int sk_alloc_security(struct sock *sk, int family,
> > const struct proto *prot, gfp_t priority) {
> >  	struct sk_security_struct *ssec;
> > +	const struct task_security_struct *tsec = current_security();
> >
> >  	ssec = kzalloc(sizeof(*ssec), priority);
> >  	if (!ssec)
> >  		return -ENOMEM;
> >
> > +	if (strcmp(prot->name, "tun") == 0) {
>
> I'm sure that won't go over well.

Yeah, I'm not real excited about that either.

> Question:  The allocated sock is then associated with a struct socket in
> the tun_struct.  Should that socket get set up in the usual way?

For some reason I completely missed the socket in tun_struct, I was fixated on 
the sock.  Let me think about this a bit more and I'll send out another patch, 
probably next week.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
