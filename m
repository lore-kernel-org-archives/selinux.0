Date: Wed, 30 Sep 2009 20:14:38 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: reset the security_ops before flushing the avc
 cache
In-Reply-To: <20090921012301.2357.73818.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.0909302014310.26932@tundra.namei.org>
References: <20090921012301.2357.73818.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 20 Sep 2009, Eric Paris wrote:

> This patch resets the security_ops to the secondary_ops before it flushes
> the avc.  It's still possible that a task on another processor could have
> already passed the security_ops dereference and be executing an selinux hook
> function which would add a new avc entry.  That entry would still not be
> freed.  This should however help to reduce the number of needless avcs the
> kernel has when selinux is disabled at run time.  There is no wasted
> memory if selinux is disabled on the command line or not compiled.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

> ---
> 
>  security/selinux/hooks.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 417f7c9..e1170ed 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5830,12 +5830,12 @@ int selinux_disable(void)
>  	selinux_disabled = 1;
>  	selinux_enabled = 0;
>  
> -	/* Try to destroy the avc node cache */
> -	avc_disable();
> -
>  	/* Reset security_ops to the secondary module, dummy or capability. */
>  	security_ops = secondary_ops;
>  
> +	/* Try to destroy the avc node cache */
> +	avc_disable();
> +
>  	/* Unregister netfilter hooks. */
>  	selinux_nf_ip_exit();
>  
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
