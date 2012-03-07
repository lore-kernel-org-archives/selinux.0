Subject: Re: [PATCH] SELinux: allow default source/target selectors for
 user/role/range
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1331080128-26425-1-git-send-email-eparis@redhat.com>
References: <1331080128-26425-1-git-send-email-eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Mar 2012 09:37:20 -0500
Message-ID: <1331131040.16697.37.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-03-06 at 19:28 -0500, Eric Paris wrote:
> When new objects are created we have great and flexible rules to
> determine the type of the new object.  We aren't quite as flexible or
> mature when it comes to determining the user, role, and range.  This
> patch adds a new ability to specify the place a new objects user, role,
> and range should come from.  For users and roles it can come from either
> the source or the target of the operation.  aka for files the user can
> either come from the source (the running process and todays default) or
> it can come from the target (aka the parent directory of the new file)
> 
> examples always are done with
> directory context: system_u:object_r:mnt_t:s0-s0:c0.c512
> process context: unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> 
> [no rule]
> 	unconfined_u:object_r:mnt_t:s0   test_none
> [default user source]
> 	unconfined_u:object_r:mnt_t:s0   test_user_source
> [default user target]
> 	system_u:object_r:mnt_t:s0       test_user_target
> [default role source]
> 	unconfined_u:unconfined_r:mnt_t:s0 test_role_source
> [default role target]
> 	unconfined_u:object_r:mnt_t:s0   test_role_target
> [default range source low]
> 	unconfined_u:object_r:mnt_t:s0 test_range_source_low
> [default range source high]
> 	unconfined_u:object_r:mnt_t:s0:c0.c1023 test_range_source_high
> [default range source low-high]
> 	unconfined_u:object_r:mnt_t:s0-s0:c0.c1023 test_range_source_low-high
> [default range target low]
> 	unconfined_u:object_r:mnt_t:s0 test_range_target_low
> [default range target high]
> 	unconfined_u:object_r:mnt_t:s0:c0.c512 test_range_target_high
> [default range target low-high]
> 	unconfined_u:object_r:mnt_t:s0-s0:c0.c512 test_range_target_low-high

Very nice. Harry's point about also supporting configurable defaults
(source or target) for the type field also makes sense.  Some comments
below.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 185f849..579c8b0 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1389,6 +1389,7 @@ static int security_compute_sid(u32 ssid,
>  				u32 *out_sid,
>  				bool kern)
>  {
> +	struct class_datum *cladatum;
>  	struct context *scontext = NULL, *tcontext = NULL, newcontext;
>  	struct role_trans *roletr = NULL;
>  	struct avtab_key avkey;
> @@ -1437,12 +1438,17 @@ static int security_compute_sid(u32 ssid,
>  		goto out_unlock;
>  	}
>  
> +	cladatum = policydb.class_val_to_struct[tclass - 1];

Need to check that tclass is in the legal range first, as in
context_struct_compute_av() and security_validate_transition().

>  	/* Set the user identity. */
>  	switch (specified) {
>  	case AVTAB_TRANSITION:
>  	case AVTAB_CHANGE:
> -		/* Use the process user identity. */
> -		newcontext.user = scontext->user;
> +		if (cladatum->default_user == DEFAULT_TARGET)
> +			/* Use the process user identity. */

Comment is no longer correct.

> @@ -1450,17 +1456,25 @@ static int security_compute_sid(u32 ssid,
>  		break;
>  	}
>  
> -	/* Set the role and type to default values. */
> -	if ((tclass == policydb.process_class) || (sock == true)) {
> -		/* Use the current role and type of process. */
> +	/* Set the role to default values. */
> +	if (cladatum->default_role == DEFAULT_SOURCE) {
>  		newcontext.role = scontext->role;
> -		newcontext.type = scontext->type;
> +	} else if (cladatum->default_role == DEFAULT_TARGET) {
> +		newcontext.role = tcontext->role;
>  	} else {
> -		/* Use the well-defined object role. */
> -		newcontext.role = OBJECT_R_VAL;
> +		if ((tclass == policydb.process_class) || (sock == true))
> +			newcontext.role = scontext->role;
> +		else
> +			newcontext.role = OBJECT_R_VAL;
> +	}
> +
> +	/* Set the type to default values. */
> +	if ((tclass == policydb.process_class) || (sock == true))
> +		/* Use the type of process. */
> +		newcontext.type = scontext->type;
> +	else
>  		/* Use the type of the related object. */
>  		newcontext.type = tcontext->type;
> -	}

I guess it isn't required, but isn't it nicer to use { } around the
block when there is a comment line?  Just for readability?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
