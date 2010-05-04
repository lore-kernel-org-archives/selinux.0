Subject: Re: [RFC PATCH v1 2/6] selinux: Set the peer label correctly on
 connected UNIX domain sockets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>
In-Reply-To: <20100503221128.8177.97693.stgit@flek.lan>
References: <20100503220455.8177.91177.stgit@flek.lan>
	 <20100503221128.8177.97693.stgit@flek.lan>
Content-Type: text/plain
Date: Tue, 04 May 2010 10:05:39 -0400
Message-Id: <1272981939.30175.57.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-05-03 at 18:11 -0400, Paul Moore wrote:
> Correct a problem where we weren't setting the peer label correctly on
> the client end of a pair of connected UNIX sockets.
> 
> Signed-off-by: XXX
> ---
>  security/selinux/hooks.c |   28 ++++++++++++----------------
>  1 files changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f9545c8..09973e2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4039,34 +4039,30 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
>  					      struct socket *other,
>  					      struct sock *newsk)
>  {
> -	struct sk_security_struct *ssec;
> -	struct inode_security_struct *isec;
> -	struct inode_security_struct *other_isec;
> +	struct sk_security_struct *sksec_s = sock->sk->sk_security;
> +	struct sk_security_struct *sksec_o = other->sk->sk_security;
> +	struct sk_security_struct *sksec_n = newsk->sk_security;

Don't you find the code using these names (sksec_[son]) to be rather
difficult to read compared to the old code?

Do we really need the sksec_ prefix?  What is this, BCPL?  Hungarian
notation considered harmful.

At the least, can we use more descriptive suffixes, e.g. _sock, _other,
_new, to match the input argument names, or if you prefer, _client,
_listener, _server?

>  	struct common_audit_data ad;
>  	int err;
>  
> -	isec = SOCK_INODE(sock)->i_security;
> -	other_isec = SOCK_INODE(other)->i_security;
> -
>  	COMMON_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.sk = other->sk;
>  
> -	err = avc_has_perm(isec->sid, other_isec->sid,
> -			   isec->sclass,
> +	err = avc_has_perm(sksec_s->sid, sksec_o->sid, sksec_o->sclass,
>  			   UNIX_STREAM_SOCKET__CONNECTTO, &ad);
>  	if (err)
>  		return err;
>  
> -	/* connecting socket */
> -	ssec = sock->sk->sk_security;
> -	ssec->peer_sid = other_isec->sid;
> -
>  	/* server child socket */
> -	ssec = newsk->sk_security;
> -	ssec->peer_sid = isec->sid;
> -	err = security_sid_mls_copy(other_isec->sid, ssec->peer_sid, &ssec->sid);
> +	sksec_n->peer_sid = sksec_s->sid;
> +	err = security_sid_mls_copy(sksec_o->sid, sksec_s->sid, &sksec_n->sid);
> +	if (err)
> +		return err;
>  
> -	return err;
> +	/* connecting socket */
> +	sksec_s->peer_sid = sksec_n->sid;
> +
> +	return 0;
>  }
>  
>  static int selinux_socket_unix_may_send(struct socket *sock,
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
