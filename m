Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n22G89bR012168
	for <selinux@tycho.nsa.gov>; Mon, 2 Mar 2009 11:08:09 -0500
Received: from g1t0029.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n22G87Lm007678
	for <selinux@tycho.nsa.gov>; Mon, 2 Mar 2009 16:08:07 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH] selinux: Fix a panic in selinux_netlbl_inode_permission()
Date: Mon, 2 Mar 2009 11:08:00 -0500
Cc: selinux@tycho.nsa.gov, rick.mcneal@lsi.com
References: <20090227200003.14235.99157.stgit@flek.lan> <alpine.LRH.2.00.0903020921320.867@tundra.namei.org>
In-Reply-To: <alpine.LRH.2.00.0903020921320.867@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903021108.00563.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 01 March 2009 05:23:00 pm James Morris wrote:
> On Fri, 27 Feb 2009, Paul Moore wrote:
> > Rick McNeal from LSI identified a panic in
> > selinux_netlbl_inode_permission() caused by a certain sequence of SUNRPC
> > operations.  The problem appears to be due to the lack of NULL pointer
> > checking in the function; this patch adds the pointer checks so the
> > function will exit safely in the cases where the socket is not completely
> > initialized.
>
> From which kernel does this happen?

I suspect it started back when NetLabel was included back in 2.6.19 but I need 
to checking everything ... I'm working on that now.

> Does it happen for the standard configuration when SELinux is enabled?

I believe so, but Rick is the expert here, I'll defer you to his email.

> > Signed-off-by: Paul Moore <paul.moore@hp.com>
> > ---
> >
> >  security/selinux/netlabel.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> > index 3f4b266..350794a 100644
> > --- a/security/selinux/netlabel.c
> > +++ b/security/selinux/netlabel.c
> > @@ -386,11 +386,12 @@ int selinux_netlbl_inode_permission(struct inode
> > *inode, int mask) if (!S_ISSOCK(inode->i_mode) ||
> >  	    ((mask & (MAY_WRITE | MAY_APPEND)) == 0))
> >  		return 0;
> > -
> >  	sock = SOCKET_I(inode);
> >  	sk = sock->sk;
> > +	if (sk == NULL)
> > +		return 0;
> >  	sksec = sk->sk_security;
> > -	if (sksec->nlbl_state != NLBL_REQUIRE)
> > +	if (sksec == NULL || sksec->nlbl_state != NLBL_REQUIRE)
> >  		return 0;
> >
> >  	local_bh_disable();
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> > with the words "unsubscribe selinux" without quotes as the message.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
