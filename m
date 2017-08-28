Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7SMpMRl030777
 for <selinux@tycho.nsa.gov>; Mon, 28 Aug 2017 18:51:22 -0400
Received: by mail-lf0-f67.google.com with SMTP id y15so1112359lfd.0
 for <selinux@tycho.nsa.gov>; Mon, 28 Aug 2017 14:35:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0cf3cc3fd48c3b0b9d1766c73ac4faea2a733bf3.1503744266.git.arvind.yadav.cs@gmail.com>
References: <0cf3cc3fd48c3b0b9d1766c73ac4faea2a733bf3.1503744266.git.arvind.yadav.cs@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Aug 2017 17:34:31 -0400
Message-ID: <CAHC9VhQzXMzOv0JsLWHd0sfB2S0T_U2Ax-dGwiedOHV4vKu-AA@mail.gmail.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: selinux@tycho.nsa.gov, serge@hallyn.com,
 James Morris <james.l.morris@oracle.com>,
 Eric Paris <eparis@parisplace.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: constify nf_hook_ops
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Aug 26, 2017 at 6:47 AM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> nf_hook_ops are not supposed to change at runtime. nf_register_net_hooks
> and nf_unregister_net_hooks are working with const nf_hook_ops.
> So mark the non-const nf_hook_ops structs as const.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 33fd061..2f2e133 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6530,7 +6530,7 @@ security_initcall(selinux_init);
>
>  #if defined(CONFIG_NETFILTER)
>
> -static struct nf_hook_ops selinux_nf_ops[] = {
> +static const struct nf_hook_ops selinux_nf_ops[] = {
>         {
>                 .hook =         selinux_ipv4_postroute,
>                 .pf =           NFPROTO_IPV4,
> --
> 2.7.4

-- 
paul moore
www.paul-moore.com
