Subject: Re: [PATCH] Rename class_destroy to prevent namespace conflicts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <XMMS.LNX.4.64.0611291628410.24574@d.namei>
References: <XMMS.LNX.4.64.0611291628410.24574@d.namei>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 16:34:58 -0500
Message-Id: <1164836098.23019.286.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-29 at 16:32 -0500, James Morris wrote:
> Stephen,
> 
> We keep hitting naming conflicts with class_destroy included via 
> linux/device.h, as networking related headers are increasingly being used 
> on in the core SELinux code.  I've tried using external declarations 
> previously to prevent e.g. skbuff.h being included, but it's not going to 
> work in the general case.  I suggest we simply rename the SELinux function 
> to cls_destroy per the patch below.
> 
> Please review.

That's fine, although you might want to just add a qualifying prefix to
those functions, like policydb_ or sel_ or whatever.

> 
> Signed-off-by: James Morris <jmorris@namei.org>
> 
> ---
> 
>  policydb.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index ba48961..cd79c63 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -468,7 +468,7 @@ static int common_destroy(void *key, voi
>  	return 0;
>  }
>  
> -static int class_destroy(void *key, void *datum, void *p)
> +static int cls_destroy(void *key, void *datum, void *p)
>  {
>  	struct class_datum *cladatum;
>  	struct constraint_node *constraint, *ctemp;
> @@ -566,7 +566,7 @@ static int cat_destroy(void *key, void *
>  static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
>  {
>  	common_destroy,
> -	class_destroy,
> +	cls_destroy,
>  	role_destroy,
>  	type_destroy,
>  	user_destroy,
> @@ -1124,7 +1124,7 @@ static int class_read(struct policydb *p
>  out:
>  	return rc;
>  bad:
> -	class_destroy(key, cladatum, NULL);
> +	cls_destroy(key, cladatum, NULL);
>  	goto out;
>  }
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
