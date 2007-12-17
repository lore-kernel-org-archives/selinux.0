Subject: Re: [RFC PATCH v8 05/18] LSM: Add secctx_to_secid() LSM hook
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        vyekkirala@TrustedCS.com, chanson@TrustedCS.com
In-Reply-To: <20071214215020.10069.51960.stgit@flek.lan>
References: <20071214213548.10069.59135.stgit@flek.lan>
	 <20071214215020.10069.51960.stgit@flek.lan>
Content-Type: text/plain
Date: Mon, 17 Dec 2007 14:49:34 -0500
Message-Id: <1197920974.17307.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-12-14 at 16:50 -0500, Paul Moore wrote:
> Add a secctx_to_secid() LSM hook to go along with the existing
> secid_to_secctx() LSM hook.  This patch also includes the SELinux
> implementation for this hook.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

This one can go up anytime, as we have other people wanting such a hook
too.

Or alternatively we need to rationalize the entire selinux/exports
interface with these hooks as used by the networking and audit
subsystems, as that issue will be coming up anyway for other LSMs.

One thing to note is that some of these interfaces treat the context as
an opaque byte array of a given length, while other ones depend on the
context to be a NUL-terminated string (e.g. audit).

> ---
> 
>  include/linux/security.h |   13 +++++++++++++
>  security/dummy.c         |    6 ++++++
>  security/security.c      |    6 ++++++
>  security/selinux/hooks.c |    6 ++++++
>  4 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ac05083..db19c92 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1183,6 +1183,10 @@ struct request_sock;
>   *	Convert secid to security context.
>   *	@secid contains the security ID.
>   *	@secdata contains the pointer that stores the converted security context.
> + * @secctx_to_secid:
> + *      Convert security context to secid.
> + *      @secid contains the pointer to the generated security ID.
> + *      @secdata contains the security context.
>   *
>   * @release_secctx:
>   *	Release the security context.
> @@ -1371,6 +1375,7 @@ struct security_operations {
>   	int (*getprocattr)(struct task_struct *p, char *name, char **value);
>   	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t size);
>  	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
> +	int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
>  	void (*release_secctx)(char *secdata, u32 seclen);
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> @@ -1603,6 +1608,7 @@ int security_setprocattr(struct task_struct *p, char *name, void *value, size_t
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_netlink_recv(struct sk_buff *skb, int cap);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> +int security_secctx_to_secid(char *secdata, u32 seclen, u32 *secid);
>  void security_release_secctx(char *secdata, u32 seclen);
>  
>  #else /* CONFIG_SECURITY */
> @@ -2280,6 +2286,13 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int security_secctx_to_secid(char *secdata,
> +					   u32 seclen,
> +					   u32 *secid)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline void security_release_secctx(char *secdata, u32 seclen)
>  {
>  }
> diff --git a/security/dummy.c b/security/dummy.c
> index 3ccfbbe..0b62f95 100644
> --- a/security/dummy.c
> +++ b/security/dummy.c
> @@ -928,6 +928,11 @@ static int dummy_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  	return -EOPNOTSUPP;
>  }
>  
> +static int dummy_secctx_to_secid(char *secdata, u32 seclen, u32 *secid)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static void dummy_release_secctx(char *secdata, u32 seclen)
>  {
>  }
> @@ -1086,6 +1091,7 @@ void security_fixup_ops (struct security_operations *ops)
>   	set_to_dummy_if_null(ops, getprocattr);
>   	set_to_dummy_if_null(ops, setprocattr);
>   	set_to_dummy_if_null(ops, secid_to_secctx);
> +	set_to_dummy_if_null(ops, secctx_to_secid);
>   	set_to_dummy_if_null(ops, release_secctx);
>  #ifdef CONFIG_SECURITY_NETWORK
>  	set_to_dummy_if_null(ops, unix_stream_connect);
> diff --git a/security/security.c b/security/security.c
> index 0e1f1f1..3bdcada 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -816,6 +816,12 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
>  
> +int security_secctx_to_secid(char *secdata, u32 seclen, u32 *secid)
> +{
> +	return security_ops->secctx_to_secid(secdata, seclen, secid);
> +}
> +EXPORT_SYMBOL(security_secctx_to_secid);
> +
>  void security_release_secctx(char *secdata, u32 seclen)
>  {
>  	return security_ops->release_secctx(secdata, seclen);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9f3124b..8bb673b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4710,6 +4710,11 @@ static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  	return security_sid_to_context(secid, secdata, seclen);
>  }
>  
> +static int selinux_secctx_to_secid(char *secdata, u32 seclen, u32 *secid)
> +{
> +	return security_context_to_sid(secdata, seclen, secid);
> +}
> +
>  static void selinux_release_secctx(char *secdata, u32 seclen)
>  {
>  	kfree(secdata);
> @@ -4898,6 +4903,7 @@ static struct security_operations selinux_ops = {
>  	.setprocattr =                  selinux_setprocattr,
>  
>  	.secid_to_secctx =		selinux_secid_to_secctx,
> +	.secctx_to_secid =		selinux_secctx_to_secid,
>  	.release_secctx =		selinux_release_secctx,
>  
>          .unix_stream_connect =		selinux_socket_unix_stream_connect,
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
