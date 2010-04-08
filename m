Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o38IXqYB006961
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2010 14:33:52 -0400
Received: from g1t0026.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o38IYfaT004702
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2010 18:34:42 GMT
From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Subject: Re: [PATCH] selinux: UNIX domain socket fixes
Date: Thu, 8 Apr 2010 14:33:48 -0400
Cc: selinux@tycho.nsa.gov
References: <20100405190124.6015.72502.stgit@flek.lan> <1270746903.3722.8.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1270746903.3722.8.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201004081433.48992.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 08 April 2010 01:15:03 pm Stephen Smalley wrote:
> On Mon, 2010-04-05 at 15:01 -0400, Paul Moore wrote:
> > Correct a problem where we weren't setting the peer label correctly on
> > connected UNIX domain sockets and do some other general fixup while we
> > are messing with the code.
> 
> I think you should state the user-visible behavior change(s) more
> explicitly, e.g.
> - getpeercon() by client on connected LOCAL socket will now return the
> context of the new connection / server socket rather than the context of
> the listening socket, matching INET behavior.
> - All permission checks and peer SID assignment will use the sock SID
> rather than the inode SID so if they are ever out of sync, the end
> result will be different (different permission check, different peer SID
> visible).  Only case where that can happen today is if someone is using
> fsetxattr() on sockets, which isn't allowed by refpolicy and isn't truly
> supported (needs a .setxattr handler in the socket inode code that
> propagates the SID down to the sock).

Thanks for the response, didn't realize you guys were still having network 
problems.

Let's just nix this patch for right now, while the client getpeercon() label 
is an issue, it is unlikely that it is causing anyone a problem and you're 
right, we really should fix the setxattr handler for sockets; it has been on 
my todo list (although very near the bottom) for some time now and this seems 
like as good an excuse as any.  I'll start working on a patchset to address 
that, as well as the other things already discussed, but I think that is more 
of a 2.6.35 candidate than something worth putting into 2.6.34-rcX.

> > Signed-off-by: Paul Moore <paul.moore@hp.com>
> > 
> > ---
> > 
> > This patch has now been tested on 2.6.34-rc3 without any visible
> > problems. ---
> > 
> >  security/selinux/hooks.c |   45
> >  +++++++++++++++++---------------------------- 1 files changed, 17
> >  insertions(+), 28 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 5feecb4..326e014 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4002,56 +4002,45 @@ static int
> > selinux_socket_unix_stream_connect(struct socket *sock,
> > 
> >  					      struct socket *other,
> >  					      struct sock *newsk)
> >  
> >  {
> > 
> > -	struct sk_security_struct *ssec;
> > -	struct inode_security_struct *isec;
> > -	struct inode_security_struct *other_isec;
> > +	struct sk_security_struct *s_sksec = sock->sk->sk_security;
> > +	struct sk_security_struct *o_sksec = other->sk->sk_security;
> > +	struct sk_security_struct *n_sksec = newsk->sk_security;
> > 
> >  	struct common_audit_data ad;
> >  	int err;
> > 
> > -	isec = SOCK_INODE(sock)->i_security;
> > -	other_isec = SOCK_INODE(other)->i_security;
> > -
> > 
> >  	COMMON_AUDIT_DATA_INIT(&ad, NET);
> >  	ad.u.net.sk = other->sk;
> > 
> > -	err = avc_has_perm(isec->sid, other_isec->sid,
> > -			   isec->sclass,
> > +	err = avc_has_perm(s_sksec->sid, o_sksec->sid, o_sksec->sclass,
> > 
> >  			   UNIX_STREAM_SOCKET__CONNECTTO, &ad);
> >  	
> >  	if (err)
> >  	
> >  		return err;
> > 
> > -	/* connecting socket */
> > -	ssec = sock->sk->sk_security;
> > -	ssec->peer_sid = other_isec->sid;
> > -
> > 
> >  	/* server child socket */
> > 
> > -	ssec = newsk->sk_security;
> > -	ssec->peer_sid = isec->sid;
> > -	err = security_sid_mls_copy(other_isec->sid, ssec->peer_sid,
> > &ssec->sid); +	n_sksec->peer_sid = s_sksec->sid;
> > +	err = security_sid_mls_copy(o_sksec->sid, s_sksec->peer_sid,
> > +				    &n_sksec->sid);
> 
> Here you use s_sksec->peer_sid.
> 
> > +	if (err)
> > +		return err;
> > 
> > -	return err;
> > +	/* connecting socket */
> > +	s_sksec->peer_sid = n_sksec->sid;
> 
> Here you assign s_sksec->peer_sid.
> 
> That's a bug introduced by the "clean up", I think.  Which is why I'd
> prefer separating the bug fix from the cleanup generally.
> 
> > +
> > +	return 0;
> > 
> >  }
> >  
> >  static int selinux_socket_unix_may_send(struct socket *sock,
> >  
> >  					struct socket *other)
> >  
> >  {
> > 
> > -	struct inode_security_struct *isec;
> > -	struct inode_security_struct *other_isec;
> > +	struct sk_security_struct *ssec = sock->sk->sk_security;
> > +	struct sk_security_struct *osec = other->sk->sk_security;
> > 
> >  	struct common_audit_data ad;
> > 
> > -	int err;
> > -
> > -	isec = SOCK_INODE(sock)->i_security;
> > -	other_isec = SOCK_INODE(other)->i_security;
> > 
> >  	COMMON_AUDIT_DATA_INIT(&ad, NET);
> >  	ad.u.net.sk = other->sk;
> > 
> > -	err = avc_has_perm(isec->sid, other_isec->sid,
> > -			   isec->sclass, SOCKET__SENDTO, &ad);
> > -	if (err)
> > -		return err;
> > -
> > -	return 0;
> > +	return avc_has_perm(ssec->sid, osec->sid, osec->sclass, 
SOCKET__SENDTO,
> > +			    &ad);
> > 
> >  }
> >  
> >  static int selinux_inet_sys_rcv_skb(int ifindex, char *addrp, u16
> >  family,
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
