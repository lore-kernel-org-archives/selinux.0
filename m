Subject: Re: [RFC PATCH v1] There is a problem where packets being sent by
 the TUN driver are not
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20090701221257.7590.75518.stgit@flek.lan>
References: <20090701221257.7590.75518.stgit@flek.lan>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 08:07:27 -0400
Message-Id: <1246536447.13464.245.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-01 at 18:12 -0400, Paul Moore wrote:
> correctly handled by SELinux in the postrouting code.  The issue is that
> the SELinux network access controls rely on a packet's associated sock, when
> present, for it's security label.  The TUN driver does create a sock to send
> network traffic but it only calls into the LSM/SELinux code once via the
> security_sk_alloc() hook which never fully initializes the sock's label.  This
> patch attempts to correct this problem by adding additional checks in the
> SELinux security_sk_alloc() alloc code to determine if the TUN driver is
> allocating a socket and if so, set the socket's label.
> 
> NOTE: this is an RFC patch intended to demonstrate a possible solution not
> discussed earlier; it is crude, untested and only deals with SELinux.  Please
> take a look and see if this approach is even worth pursuing ... thanks.
> ---
> 
>  include/linux/security.h |    7 ++++---
>  net/core/sock.c          |    2 +-
>  security/capability.c    |    2 +-
>  security/security.c      |    4 ++--
>  security/selinux/hooks.c |   43 ++++++++++++++++++++++++-------------------
>  5 files changed, 32 insertions(+), 26 deletions(-)
> 

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 15c2a08..dde57d1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -298,16 +298,21 @@ static void superblock_free_security(struct super_block *sb)
>  	kfree(sbsec);
>  }
>  
> -static int sk_alloc_security(struct sock *sk, int family, gfp_t priority)
> +static int sk_alloc_security(struct sock *sk, int family, const struct proto *prot, gfp_t priority)
>  {
>  	struct sk_security_struct *ssec;
> +	const struct task_security_struct *tsec = current_security();
>  
>  	ssec = kzalloc(sizeof(*ssec), priority);
>  	if (!ssec)
>  		return -ENOMEM;
>  
> +	if (strcmp(prot->name, "tun") == 0) {

I'm sure that won't go over well.

Question:  The allocated sock is then associated with a struct socket in
the tun_struct.  Should that socket get set up in the usual way?

> +		ssec->sid = (tsec->sockcreate_sid ? : tsec->sid);
> +		/* XXX - probably want to label the socket here too */

Not associated yet, so we can't.

> +	} else
> +		ssec->sid = SECINITSID_UNLABELED;
>  	ssec->peer_sid = SECINITSID_UNLABELED;
> -	ssec->sid = SECINITSID_UNLABELED;
>  	sk->sk_security = ssec;
>  
>  	selinux_netlbl_sk_security_reset(ssec);
> @@ -3673,32 +3678,32 @@ out:
>  static int selinux_socket_post_create(struct socket *sock, int family,
>  				      int type, int protocol, int kern)
>  {
> -	const struct cred *cred = current_cred();
> -	const struct task_security_struct *tsec = cred->security;
> -	struct inode_security_struct *isec;
> +	const struct task_security_struct *tsec = current_security();
> +	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
>  	struct sk_security_struct *sksec;
> -	u32 sid, newsid;
> +	u32 sid;
>  	int err = 0;
>  
> -	sid = tsec->sid;
> -	newsid = tsec->sockcreate_sid;
> -
> -	isec = SOCK_INODE(sock)->i_security;
> +	if (sock->sk)
> +		sksec = sock->sk->sk_security;
> +	else
> +		sksec = NULL;
>  
>  	if (kern)
> -		isec->sid = SECINITSID_KERNEL;
> -	else if (newsid)
> -		isec->sid = newsid;
> +		sid = SECINITSID_KERNEL;
> +	else if (sksec && sksec->sid != SECINITSID_UNLABELED)
> +		sid = sksec->sid;
>  	else
> -		isec->sid = sid;
> +		sid = (tsec->sockcreate_sid ? : tsec->sid);

Something went wrong here - isec->sid never gets set now.
>  
>  	isec->sclass = socket_type_to_security_class(family, type, protocol);
>  	isec->initialized = 1;
>  
> -	if (sock->sk) {
> -		sksec = sock->sk->sk_security;
> -		sksec->sid = isec->sid;
> +	if (sksec) {
> +		/* XXX - end up changing this if kern is true - problem? */
> +		sksec->sid = sid;
>  		sksec->sclass = isec->sclass;
> +		/* XXX - this will be tricky depending on how things work out */
>  		err = selinux_netlbl_socket_post_create(sock->sk, family);
>  	}
>  
> @@ -4187,9 +4192,9 @@ out:
>  	return 0;
>  }
>  
> -static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
> +static int selinux_sk_alloc_security(struct sock *sk, int family, const struct proto *prot, gfp_t priority)
>  {
> -	return sk_alloc_security(sk, family, priority);
> +	return sk_alloc_security(sk, family, prot, priority);
>  }
>  
>  static void selinux_sk_free_security(struct sock *sk)
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
