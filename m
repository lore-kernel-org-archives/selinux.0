Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4KL87UY015728
 for <selinux@tycho.nsa.gov>; Fri, 20 May 2016 17:08:08 -0400
Received: by mail-qg0-f53.google.com with SMTP id 90so66621262qgz.1
 for <selinux@tycho.nsa.gov>; Fri, 20 May 2016 14:08:06 -0700 (PDT)
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v3] selinux: Only apply bounds checking to source types
Date: Fri, 20 May 2016 17:08:03 -0400
Message-ID: <2708730.ig19EvebP9@sifl>
In-Reply-To: <1462297700-31193-1-git-send-email-sds@tycho.nsa.gov>
References: <1462297700-31193-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, May 03, 2016 01:48:20 PM Stephen Smalley wrote:
> The current bounds checking of both source and target types
> requires allowing any domain that has access to the child
> domain to also have the same permissions to the parent, which
> is undesirable.  Drop the target bounds checking ...

Thanks for doing this, especially the detailed patch description.  It all 
looks reasonable to me and the code looks sane as well, a few comments below.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 89df646..48babec 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -553,33 +553,23 @@ static void type_attribute_bounds_av(struct context
> *scontext, scontext->type - 1);
>  	BUG_ON(!source);
> 
> +	if (!source->bounds)
> +		return;
> +
>  	target = flex_array_get_ptr(policydb.type_val_to_struct_array,
>  				    tcontext->type - 1);
>  	BUG_ON(!target);
> 
> -	if (source->bounds) {
> -		memset(&lo_avd, 0, sizeof(lo_avd));
> -
> -		memcpy(&lo_scontext, scontext, sizeof(lo_scontext));
> -		lo_scontext.type = source->bounds;
> +	memset(&lo_avd, 0, sizeof(lo_avd));
> 
> -		context_struct_compute_av(&lo_scontext,
> -					  tcontext,
> -					  tclass,
> -					  &lo_avd,
> -					  NULL);
> -		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
> -			return;		/* no masked permission */
> -		masked = ~lo_avd.allowed & avd->allowed;
> -	}
> +	memcpy(&lo_scontext, scontext, sizeof(lo_scontext));
> +	lo_scontext.type = source->bounds;
> 
>  	if (target->bounds) {
> -		memset(&lo_avd, 0, sizeof(lo_avd));
> -
>  		memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
>  		lo_tcontext.type = target->bounds;
> 
> -		context_struct_compute_av(scontext,
> +		context_struct_compute_av(&lo_scontext,
>  					  &lo_tcontext,
>  					  tclass,
>  					  &lo_avd,
> @@ -587,17 +577,9 @@ static void type_attribute_bounds_av(struct context
> *scontext, if ((lo_avd.allowed & avd->allowed) == avd->allowed)
>  			return;		/* no masked permission */
>  		masked = ~lo_avd.allowed & avd->allowed;
> -	}
> -
> -	if (source->bounds && target->bounds) {
> -		memset(&lo_avd, 0, sizeof(lo_avd));
> -		/*
> -		 * lo_scontext and lo_tcontext are already
> -		 * set up.
> -		 */
> -
> +	} else {
>  		context_struct_compute_av(&lo_scontext,
> -					  &lo_tcontext,
> +					  tcontext,
>  					  tclass,
>  					  &lo_avd,
>  					  NULL);

Now that we are ignoring the unbounded subject/source, it seems like we could 
even further simplify the code; no change to the logic, just tidy the 
implementation a bit.

I think we could move the lo_avd/avd comparison and masked calculation outside 
the if statement as it is common to both the true and false conditions.

We could also likely move the compute_av() call outside the if statement too 
if we abstract the target/object behind a pointer which could either reference 
tcontext or lo_tcontext depending on the target.

I might be missing some small detail, but I don't believe the "if (masked)" 
check is ever going to be false; if correct we can toss the conditional check.

-- 
paul moore
security @ redhat
