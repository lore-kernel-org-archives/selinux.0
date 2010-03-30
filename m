From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v1] selinux: UNIX domain socket fixes
Date: Tue, 30 Mar 2010 16:35:33 -0400
Cc: selinux@tycho.nsa.gov
References: <20100330195115.8079.15161.stgit@flek.lan> <1269980830.9831.23.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1269980830.9831.23.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201003301635.33964.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 30 March 2010 04:27:10 pm Stephen Smalley wrote:
> On Tue, 2010-03-30 at 15:51 -0400, Paul Moore wrote:
> > Correct a problem where we weren't setting the peer label correctly on
> > connected UNIX domain sockets and do some other general fixup while we
> > are messing with the code.
> > 
> > This patch really is RFC quality; I've only boot tested it once so
> > beware ...
> 
> I'm not sure why you are changing anything here other than the
> assignment of the peer_sid.
> 
> The inode SID and the sock SID should be the same.  The only case today
> where I know they can become inconsistent is upon fsetxattr() on a
> socket, which is not allowed by existing policy, and that can be
> addressed by introducing a setxattr handler for sockets that propagates
> the SID down to the sock.

Cleanliness mainly.  Granted the changes in may_send() have zero effect and 
are largely to satisfy my own desire to shift the socket controls to using the 
sock SID as much as possible (instead of the inode's SID).  However, in 
stream_connect() the changes actually make the code a bit smaller and cleaner; 
we need the sk_security_struct for each socket to gain access to the peer SID 
and it can also give us the socket's SID, fetching the inode's SID adds extra 
work and consumes more stack for no advantage.

> > Signed-off-by: XXX
> > ---
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
> > +	if (err)
> > +		return err;
> > 
> > -	return err;
> > +	/* connecting socket */
> > +	s_sksec->peer_sid = n_sksec->sid;
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
