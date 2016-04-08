Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u38GNwpC025728
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 12:23:58 -0400
Subject: Re: [PATCH net-next] security: drop the unused hook skb_owned_by
To: Paolo Abeni <pabeni@redhat.com>, linux-security-module@vger.kernel.org
References: <25cbac8df32da8527bac7187f606e6351862702d.1460110723.git.pabeni@redhat.com>
Cc: James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Kees Cook <keescook@chromium.org>, Paul Moore <pmoore@redhat.com>,
 linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5707DB19.6010702@schaufler-ca.com>
Date: Fri, 8 Apr 2016 09:23:54 -0700
MIME-Version: 1.0
In-Reply-To: <25cbac8df32da8527bac7187f606e6351862702d.1460110723.git.pabeni@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/8/2016 3:20 AM, Paolo Abeni wrote:
> The skb_owned_by hook was added with the commit ca10b9e9a8ca
> ("selinux: add a skb_owned_by() hook") and later removed
> when said commit was reverted.
>
> Later on, when switching to list of hooks, a field named
> 'skb_owned_by' was included into the security_hook_head struct,
> but without any users nor caller.
>
> This commit removes the said left-over field.
>
> Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hooks.h | 1 -
>  security/security.c       | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index cdee11c..ae25378 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1804,7 +1804,6 @@ struct security_hook_heads {
>  	struct list_head tun_dev_attach_queue;
>  	struct list_head tun_dev_attach;
>  	struct list_head tun_dev_open;
> -	struct list_head skb_owned_by;
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  #ifdef CONFIG_SECURITY_NETWORK_XFRM
>  	struct list_head xfrm_policy_alloc_security;
> diff --git a/security/security.c b/security/security.c
> index 3644b03..554c3fb 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1848,7 +1848,6 @@ struct security_hook_heads security_hook_heads = {
>  	.tun_dev_attach =
>  		LIST_HEAD_INIT(security_hook_heads.tun_dev_attach),
>  	.tun_dev_open =	LIST_HEAD_INIT(security_hook_heads.tun_dev_open),
> -	.skb_owned_by =	LIST_HEAD_INIT(security_hook_heads.skb_owned_by),
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  #ifdef CONFIG_SECURITY_NETWORK_XFRM
>  	.xfrm_policy_alloc_security =
