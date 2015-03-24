Message-ID: <55115909.8080906@tycho.nsa.gov>
Date: Tue, 24 Mar 2015 08:31:05 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>, Paul Moore <paul@paul-moore.com>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinuxfs: Fix sel_write_enforce broken return value
References: <1427158895.16851.70.camel@perches.com>
In-Reply-To: <1427158895.16851.70.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/23/2015 09:01 PM, Joe Perches wrote:
> Return a negative error value like the rest
> of the entries in this function.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
> Maybe this should be stable, it goes back to
> commit b77a493b1dc8 ("SELinux: standardize return code
> handling in selinuxfs.c") back in Nov 2010, but it's
> guarded by a #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
> so it probably doesn't matter much.

That option is enabled by most distributions that enable SELinux; it is
what enables support for permissive mode.

> 
>  security/selinux/selinuxfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 1684bcc..5fde343 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -152,7 +152,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>  		goto out;
>  
>  	/* No partial writes. */
> -	length = EINVAL;
> +	length = -EINVAL;
>  	if (*ppos != 0)
>  		goto out;
>  
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 
