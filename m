Subject: Re: [PATCH] genhomedircon: add support for %group syntax
To: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov
References: <1469654706-26930-1-git-send-email-gary.tierney@gmx.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2a66b4e4-6064-1248-bdfc-8b41b822c749@tycho.nsa.gov>
Date: Mon, 15 Aug 2016 15:58:44 -0400
MIME-Version: 1.0
In-Reply-To: <1469654706-26930-1-git-send-email-gary.tierney@gmx.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/27/2016 05:25 PM, Gary Tierney wrote:
> semanage-login supports login mappings using the %group syntax, but
> genhomedircon does not expand groups to the users belonging to them.
> 
> This commit adds support for generating home directory contexts for login
> mappings using the group syntax and adds error reporting for handling cases
> where there is ambiguity due to a user belonging to multiple groups mapped by
> semanage-login. If a login mapping is added for the user which belongs to
> multiple groups it will take precedence and resolve the ambiguity issue.

Sorry for the long delay in responding.  One question/comment below.

> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
> ---
>  libsemanage/src/genhomedircon.c | 319 +++++++++++++++++++++++++++++++---------
>  1 file changed, 247 insertions(+), 72 deletions(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index c5ea436..2955b19 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -838,94 +1064,43 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
>  		nusers = 0;
>  	}
>  
> +	qsort(seuser_list, nseusers, sizeof(semanage_seuser_t *),
> +	      &seuser_sort_func);
>  	qsort(user_list, nusers, sizeof(semanage_user_t *),
>  	      (int (*)(const void *, const void *))&user_sort_func);
>  
> -	/* Allocate space for the getpwnam_r buffer */
> -	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> -	if (rbuflen <= 0)
> -		goto cleanup;
> -	rbuf = malloc(rbuflen);
> -	if (rbuf == NULL)
> -		goto cleanup;
> -
>  	for (i = 0; i < nseusers; i++) {
>  		seuname = semanage_seuser_get_sename(seuser_list[i]);
>  		name = semanage_seuser_get_name(seuser_list[i]);
>  
> -		if (strcmp(name,"root") && strcmp(seuname, s->fallback->sename) == 0)
> -			continue;
> -

This appears to change the behavior of genhomedircon in general, not
just with respect to %group handling.  Was this intentional?
I'm not necessarily opposed to this change, but I am unclear on the
implications.  It seems that previously genhomedircon would not generate
file_contexts.homedirs entries for users who were mapped to the fallback
seuser, with an exception for root for /root labeling.  With this
change, they will have entries added.

>  		if (strcmp(name, DEFAULT_LOGIN) == 0)
>  			continue;
>  
>  		if (strcmp(name, TEMPLATE_SEUSER) == 0)
>  			continue;
>  
> -		/* %groupname syntax */
> -		if (name[0] == '%')
> -			continue;
> -
>  		/* find the user structure given the name */
> -		u = bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
> +		u = bsearch(seuname, user_list, nusers,
> +			    sizeof(semanage_user_t *),
>  			    (int (*)(const void *, const void *))
>  			    &name_user_cmp);
> -		if (u) {
> -			prefix = semanage_user_get_prefix(*u);
> -			level = semanage_user_get_mlslevel(*u);
> -			if (!level)
> -				level = FALLBACK_LEVEL;
> -		} else {
> -			prefix = name;
> -			level = FALLBACK_LEVEL;
> -		}
> -
> -		retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
> -		if (retval != 0 || pwent == NULL) {
> -			if (retval != 0 && retval != ENOENT) {
> -				*errors = STATUS_ERR;
> -				goto cleanup;
> -			}
> -
> -			WARN(s->h_semanage,
> -			     "user %s not in password file", name);
> -			continue;
> -		}
>  
> -		int len = strlen(pwent->pw_dir) -1;
> -		for(; len > 0 && pwent->pw_dir[len] == '/'; len--) {
> -			pwent->pw_dir[len] = '\0';
> +		/* %groupname syntax */
> +		if (name[0] == '%') {
> +			retval = get_group_users(s, &head, *u, seuname,
> +						name);
> +		} else {
> +			retval = add_user(s, &head, *u, name,
> +					  seuname, name);
>  		}
>  
> -		if (strcmp(pwent->pw_dir, "/") == 0) {
> -			/* don't relabel / genhomdircon checked to see if root
> -			 * was the user and if so, set his home directory to
> -			 * /root */
> -			continue;
> -		}
> -		if (ignore(pwent->pw_dir))
> -			continue;
> -
> -		len = snprintf(uid, sizeof(uid), "%u", pwent->pw_uid);
> -		if (len < 0 || len >= (int)sizeof(uid)) {
> +		if (retval != 0) {
>  			*errors = STATUS_ERR;
>  			goto cleanup;
>  		}
> -		len = snprintf(gid, sizeof(gid), "%u", pwent->pw_gid);
> -		if (len < 0 || len >= (int)sizeof(gid)) {
> -			*errors = STATUS_ERR;
> -			goto cleanup;
> -		}
> -
> -		if (push_user_entry(&head, name, uid, gid, seuname,
> -				    prefix, pwent->pw_dir, level) != STATUS_SUCCESS) {
> -			*errors = STATUS_ERR;
> -			break;
> -		}
>  	}
>  
>        cleanup:
> -	free(rbuf);
>  	if (*errors) {
>  		for (; head; pop_user_entry(&head)) {
>  			/* the pop function takes care of all the cleanup
> 
