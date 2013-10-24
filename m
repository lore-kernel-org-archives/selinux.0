Message-ID: <5269859E.1080807@tycho.nsa.gov>
Date: Thu, 24 Oct 2013 16:39:58 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux: Update policy version to support constraints info
References: <1382398322.27942.61.camel@localhost>
In-Reply-To: <1382398322.27942.61.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/21/2013 07:32 PM, Eric Paris wrote:
> From: Richard Haines <richard_c_haines@btinternet.com>
> Date: Tue, 18 Dec 2012 19:37:46 +0000
> 
> Update the policy version (POLICYDB_VERSION_CONSTRAINT_NAMES) to allow
> holding of policy source info for constraints.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  security/selinux/include/security.h |    3 +-
>  security/selinux/ss/constraint.h    |    1 +
>  security/selinux/ss/policydb.c      |  100 ++++++++++++++++++++++++++++++++---
>  security/selinux/ss/policydb.h      |   11 ++++
>  4 files changed, 107 insertions(+), 8 deletions(-)
> 

> diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
> index 149dda7..3855ea8 100644
> --- a/security/selinux/ss/constraint.h
> +++ b/security/selinux/ss/constraint.h
> @@ -48,6 +48,7 @@ struct constraint_expr {
>  	u32 op;			/* operator */
>  
>  	struct ebitmap names;	/* names */
> +	struct type_set_datum *type_names;

Why did you change the name of the structure in the kernel from the one
used in libsepol (struct type_set)?

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 9cd9b7c..f1b23df 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -613,11 +618,20 @@ static int common_destroy(void *key, void *datum, void *p)
>  	return 0;
>  }
>  
> -static int cls_destroy(void *key, void *datum, void *p)
> +static void type_set_destroy(struct type_set_datum * t)
> +{
> +	if (t != NULL) {
> +		ebitmap_destroy(&t->types);
> +		ebitmap_destroy(&t->negset);
> +	}
> +}

So you don't free(t) here, yet every caller does so afterward.
Although I see it isn't that way in libsepol so maybe you are trying to
stay consistent in case you use these elsewhere in the kernel as is done
in libsepol?

> @@ -629,6 +643,10 @@ static int cls_destroy(void *key, void *datum, void *p)
>  			e = constraint->expr;
>  			while (e) {
>  				ebitmap_destroy(&e->names);
> +				if (p->policyvers >= POLICYDB_VERSION_CONSTRAINT_NAMES) {
> +					type_set_destroy(e->type_names);
> +					kfree(e->type_names);
> +				}

Should we have a constraint_expr_destroy() as we do in libsepol?

>  				etmp = e;
>  				e = e->next;
>  				kfree(etmp);
> @@ -643,6 +661,10 @@ static int cls_destroy(void *key, void *datum, void *p)
>  			e = constraint->expr;
>  			while (e) {
>  				ebitmap_destroy(&e->names);
> +				if (p->policyvers >= POLICYDB_VERSION_CONSTRAINT_NAMES) {
> +					type_set_destroy(e->type_names);
> +					kfree(e->type_names);
> +				}

So we don't have to repeat this?

>  				etmp = e;
>  				e = e->next;
>  				kfree(etmp);
> @@ -775,7 +797,7 @@ void policydb_destroy(struct policydb *p)
>  
>  	for (i = 0; i < SYM_NUM; i++) {
>  		cond_resched();
> -		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
> +		hashtab_map(p->symtab[i].table, destroy_f[i], p);

Couldn't we avoid the need for passing down the policydb and checking
the version just by ensuring e->type_names gets initialized to NULL and
then the type_set_destroy() and kfree() calls degenerate to no-ops?  I
suppose this works, but it complicates the code a bit.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
