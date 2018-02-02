Message-ID: <1517580659.28460.9.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Peter Enderborg <peter.enderborg@sony.com>, Paul Moore
 <paul@paul-moore.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Date: Fri, 02 Feb 2018 09:10:59 -0500
In-Reply-To: <20180202080554.9689-1-peter.enderborg@sony.com>
References: <20180202080554.9689-1-peter.enderborg@sony.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH-selinuxns] selinux: Annotate lockdep for services locks
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2018-02-02 at 09:05 +0100, Peter Enderborg wrote:
> The locks are moved to dynamic allocation, we need to
> help the lockdep system to classify the locks.
> This adds to lockdep annotation for the page mutex and
> for the ss lock.

Thanks, but missing a Signed-off-by: line.  Also, just to be clear, you
shouldn't re-base your work on top of the entire selinuxns branch,
since I only expect the first few patches to be mergeable in the near
term.

I also will need to re-base again when the selinux next branch moves to
something 4.15-based, including fixing up the bpf hooks that were
introduced there.

> ---
>  security/selinux/ss/services.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index abc5383..ba463c0 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -70,6 +70,9 @@
>  #include "ebitmap.h"
>  #include "audit.h"
>  
> +static struct lock_class_key selinux_ss_class_key;
> +static struct lock_class_key selinux_status_class_key;
> +
>  /* Policy capability names */
>  char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>  	"network_peer_controls",
> @@ -88,7 +91,9 @@ int selinux_ss_create(struct selinux_ss **ss)
>  	if (!newss)
>  		return -ENOMEM;
>  	rwlock_init(&newss->policy_rwlock);
> +	lockdep_set_class(&newss->policy_rwlock,
> &selinux_ss_class_key);
>  	mutex_init(&newss->status_lock);
> +	lockdep_set_class(&newss->status_lock,
> &selinux_status_class_key);
>  	*ss = newss;
>  	return 0;
>  }
