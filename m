Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0HGRke8006298
 for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2017 11:27:47 -0500
Subject: Re: [PATCH 07/46] selinux: Delete unnecessary variable assignments in
 policydb_index()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <247c0e27-c442-3408-4f92-492629d61fbf@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <16b4fb1b-a6b4-a84c-3541-ca6a156d651e@schaufler-ca.com>
Date: Tue, 17 Jan 2017 08:27:38 -0800
MIME-Version: 1.0
In-Reply-To: <247c0e27-c442-3408-4f92-492629d61fbf@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 1/15/2017 7:04 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 13:40:25 +0100
>
> The local variable "rc" was reset with an error code up to five times
> before a memory allocation failure was detected.
>
> Add a jump target so that this assignment will only be performed after
> a concrete software failure.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Of course the maintainers get the call on this,
but I see this as an example of the kind of code
that led to the "gotos considered harmful" mindset.
What value does it add? All I see is unnecessary
code churn. And a backwards goto.


> ---
>  security/selinux/ss/policydb.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 21869b622c0c..4d4ba1ad910d 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -539,34 +539,30 @@ static int policydb_index(struct policydb *p)
>  	symtab_hash_eval(p->symtab);
>  #endif
>  
> -	rc = -ENOMEM;
>  	p->class_val_to_struct = kcalloc(p->p_classes.nprim,
>  					 sizeof(*p->class_val_to_struct),
>  					 GFP_KERNEL);
>  	if (!p->class_val_to_struct)
> -		goto out;
> +		goto failure_indication;
>  
> -	rc = -ENOMEM;
>  	p->role_val_to_struct = kcalloc(p->p_roles.nprim,
>  					sizeof(*p->role_val_to_struct),
>  					GFP_KERNEL);
>  	if (!p->role_val_to_struct)
> -		goto out;
> +		goto failure_indication;
>  
> -	rc = -ENOMEM;
>  	p->user_val_to_struct = kcalloc(p->p_users.nprim,
>  					sizeof(*p->user_val_to_struct),
>  					GFP_KERNEL);
>  	if (!p->user_val_to_struct)
> -		goto out;
> +		goto failure_indication;
>  
>  	/* Yes, I want the sizeof the pointer, not the structure */
> -	rc = -ENOMEM;
>  	p->type_val_to_struct_array = flex_array_alloc(sizeof(struct type_datum *),
>  						       p->p_types.nprim,
>  						       GFP_KERNEL | __GFP_ZERO);
>  	if (!p->type_val_to_struct_array)
> -		goto out;
> +		goto failure_indication;
>  
>  	rc = flex_array_prealloc(p->type_val_to_struct_array, 0,
>  				 p->p_types.nprim, GFP_KERNEL | __GFP_ZERO);
> @@ -578,12 +574,11 @@ static int policydb_index(struct policydb *p)
>  		goto out;
>  
>  	for (i = 0; i < SYM_NUM; i++) {
> -		rc = -ENOMEM;
>  		p->sym_val_to_name[i] = flex_array_alloc(sizeof(char *),
>  							 p->symtab[i].nprim,
>  							 GFP_KERNEL | __GFP_ZERO);
>  		if (!p->sym_val_to_name[i])
> -			goto out;
> +			goto failure_indication;
>  
>  		rc = flex_array_prealloc(p->sym_val_to_name[i],
>  					 0, p->symtab[i].nprim,
> @@ -598,6 +593,9 @@ static int policydb_index(struct policydb *p)
>  	rc = 0;
>  out:
>  	return rc;
> +failure_indication:
> +	rc = -ENOMEM;
> +	goto out;
>  }
>  
>  /*
