Message-ID: <1508171259.2722.5.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov
Date: Mon, 16 Oct 2017 12:27:39 -0400
In-Reply-To: <alpine.LFD.2.20.1710161736340.9932@t440.gateway.2wire.net>
References: <alpine.LFD.2.20.1710161736340.9932@t440.gateway.2wire.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH][RFC] selinuxns: mark init_selinux_ns as __ro_after_init
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-10-16 at 17:44 +1100, James Morris wrote:
> This is a patch against the SELinux namespace work.
> 
> Mark the initial SELinux namespace pointer as __ro_after_init, to
> harden 
> against malicious overwrite by an attacker.
> 
> Signed-off-by: James Morris <james.l.morris@oracle.com>

Thanks, this looks fine; I can apply it on my branch if you want.
Note however that at this point, I am looking more for design
discussion and resolution of the problems noted in the patch
descriptions for the existing patches, and anticipate many of those
patches being substantially rewritten or discarded in any final
versiopn.  This particular patch however could likely be rebased on top
of the first patch in the series and wouldn't be affected by such
changes.

> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3daad14..98dbf57 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -97,7 +97,7 @@
>  #include "audit.h"
>  #include "avc_ss.h"
>  
> -struct selinux_ns *init_selinux_ns;
> +struct selinux_ns *init_selinux_ns __ro_after_init;
>  
>  /* SECMARK reference count */
>  static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
> -- 
> 1.8.3.1
> 
> 
