Subject: Re: [RFC PATCH v1 3/6] selinux: Consolidate sockcreate_sid logic
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20100503221134.8177.57403.stgit@flek.lan>
References: <20100503220455.8177.91177.stgit@flek.lan>
	 <20100503221134.8177.57403.stgit@flek.lan>
Content-Type: text/plain
Date: Tue, 04 May 2010 09:52:25 -0400
Message-Id: <1272981145.30175.43.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-05-03 at 18:11 -0400, Paul Moore wrote:
> Consolidate the basic sockcreate_sid logic into a single helper function
> which allows us to do some cleanups in the related code.
> 
> Signed-off-by: XXX
> ---
>  security/selinux/hooks.c |   32 ++++++++++++--------------------
>  1 files changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 09973e2..4034a3a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3730,6 +3730,12 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
>  }
>  
>  /* socket security operations */
> +
> +static u32 socket_sockcreate_sid(const struct task_security_struct *tsec)
> +{
> +	return tsec->sockcreate_sid ? tsec->sockcreate_sid : tsec->sid;

Why is this clearer than just:
	return tsec->sockcreate_sid ?: tsec->sid;

> +}
> +
>  static int socket_has_perm(struct task_struct *task, struct socket *sock,
>  			   u32 perms)
>  {
> @@ -3757,21 +3763,15 @@ static int selinux_socket_create(int family, int type,
>  {
>  	const struct cred *cred = current_cred();
>  	const struct task_security_struct *tsec = cred->security;
> -	u32 sid, newsid;
> +	u32 newsid;
>  	u16 secclass;
> -	int err = 0;
>  
>  	if (kern)
> -		goto out;
> -
> -	sid = tsec->sid;
> -	newsid = tsec->sockcreate_sid ?: sid;
> +		return 0;
>  
> +	newsid = socket_sockcreate_sid(tsec);
>  	secclass = socket_type_to_security_class(family, type, protocol);
> -	err = avc_has_perm(sid, newsid, secclass, SOCKET__CREATE, NULL);
> -
> -out:
> -	return err;
> +	return avc_has_perm(tsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
>  }
>  
>  static int selinux_socket_post_create(struct socket *sock, int family,
> @@ -3779,22 +3779,14 @@ static int selinux_socket_post_create(struct socket *sock, int family,
>  {
>  	const struct cred *cred = current_cred();
>  	const struct task_security_struct *tsec = cred->security;
> -	struct inode_security_struct *isec;
> +	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
>  	struct sk_security_struct *sksec;
> -	u32 sid, newsid;
>  	int err = 0;
>  
> -	sid = tsec->sid;
> -	newsid = tsec->sockcreate_sid;
> -
> -	isec = SOCK_INODE(sock)->i_security;
> -
>  	if (kern)
>  		isec->sid = SECINITSID_KERNEL;
> -	else if (newsid)
> -		isec->sid = newsid;
>  	else
> -		isec->sid = sid;
> +		isec->sid = socket_sockcreate_sid(tsec);
>  
>  	isec->sclass = socket_type_to_security_class(family, type, protocol);
>  	isec->initialized = 1;
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
