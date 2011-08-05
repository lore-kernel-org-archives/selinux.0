Subject: Re: [PATCH 1/5] Define the function to write sock's security
 context to seq_file.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: rongqing.li@windriver.com
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        lsm
 <linux-security-module@vger.kernel.org>
In-Reply-To: <1312534686-4099-2-git-send-email-rongqing.li@windriver.com>
References: <1312534686-4099-1-git-send-email-rongqing.li@windriver.com>
	 <1312534686-4099-2-git-send-email-rongqing.li@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Aug 2011 09:32:38 -0400
Message-ID: <1312551158.19283.39.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-08-05 at 16:58 +0800, rongqing.li@windriver.com wrote:
> From: Roy.Li <rongqing.li@windriver.com>
> 
> This function will write the sock's security context to a seq_file
> and return the error code, and the number of characters successfully
> written is written in int pointers parameter.
> 
> This function will be called when export socket information to proc.
> 
> Signed-off-by: Roy.Li <rongqing.li@windriver.com>
> ---
>  include/net/sock.h |    1 +
>  net/core/sock.c    |   26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 0 deletions(-)
> 

> diff --git a/net/core/sock.c b/net/core/sock.c
> index bc745d0..1126a49 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2254,6 +2254,32 @@ void sk_common_release(struct sock *sk)
>  }
>  EXPORT_SYMBOL(sk_common_release);
>  
> +int sock_write_secctx(struct sock *sk, struct seq_file *seq, int *len)
> +{
> +	struct flowi fl;
> +	char *ctx = NULL;
> +	u32 ctxlen;
> +	int res = 0;
> +
> +	*len = 0;
> +
> +	if (sk == NULL)
> +		return -EINVAL;
> +	res = security_socket_getsockname(sk->sk_socket);
> +	if (res)
> +		return res;
> +
> +	security_sk_classify_flow(sk, &fl);

Rather than using a fake flowi, just define and use
security_sk_getsecid().  There is already a security_ops->sk_getsecid()
hook, so you just need the wrapper function.

> +
> +	res = security_secid_to_secctx(fl.flowi_secid, &ctx, &ctxlen);
> +	if (res)
> +		return res;
> +
> +	seq_printf(seq, " %s%n", ctx, len);
> +	security_release_secctx(ctx, ctxlen);
> +	return res;
> +}
> +
>  static DEFINE_RWLOCK(proto_list_lock);
>  static LIST_HEAD(proto_list);
>  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
