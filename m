Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7GDUax5012050
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 09:30:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id h186so5508567pfg.2
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 06:29:53 -0700 (PDT)
Date: Tue, 16 Aug 2016 21:29:50 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] genhomedircon: add support for %group syntax
Message-ID: <20160816132950.GB28326@meriadoc.perfinion.com>
References: <1469654706-26930-1-git-send-email-gary.tierney@gmx.com>
 <2a66b4e4-6064-1248-bdfc-8b41b822c749@tycho.nsa.gov>
 <20160816131624.GA28326@meriadoc.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160816131624.GA28326@meriadoc.perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 16, 2016 at 09:16:24PM +0800, Jason Zaman wrote:
> On Mon, Aug 15, 2016 at 03:58:44PM -0400, Stephen Smalley wrote:
> > On 07/27/2016 05:25 PM, Gary Tierney wrote:
> > > semanage-login supports login mappings using the %group syntax, but
> > > genhomedircon does not expand groups to the users belonging to them.
> > > 
> > > This commit adds support for generating home directory contexts for login
> > > mappings using the group syntax and adds error reporting for handling cases
> > > where there is ambiguity due to a user belonging to multiple groups mapped by
> > > semanage-login. If a login mapping is added for the user which belongs to
> > > multiple groups it will take precedence and resolve the ambiguity issue.
> > 
> > Sorry for the long delay in responding.  One question/comment below.
> > 
> > > Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
> > > ---
> > >  libsemanage/src/genhomedircon.c | 319 +++++++++++++++++++++++++++++++---------
> > >  1 file changed, 247 insertions(+), 72 deletions(-)
> > > 
> > > diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> > > index c5ea436..2955b19 100644
> > > --- a/libsemanage/src/genhomedircon.c
> > > +++ b/libsemanage/src/genhomedircon.c
> > > @@ -838,94 +1064,43 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
> > >  		nusers = 0;
> > >  	}
> > >  
> > > +	qsort(seuser_list, nseusers, sizeof(semanage_seuser_t *),
> > > +	      &seuser_sort_func);
> > >  	qsort(user_list, nusers, sizeof(semanage_user_t *),
> > >  	      (int (*)(const void *, const void *))&user_sort_func);
> > >  
> > > -	/* Allocate space for the getpwnam_r buffer */
> > > -	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
> > > -	if (rbuflen <= 0)
> > > -		goto cleanup;
> > > -	rbuf = malloc(rbuflen);
> > > -	if (rbuf == NULL)
> > > -		goto cleanup;
> > > -
> > >  	for (i = 0; i < nseusers; i++) {
> > >  		seuname = semanage_seuser_get_sename(seuser_list[i]);
> > >  		name = semanage_seuser_get_name(seuser_list[i]);
> > >  
> > > -		if (strcmp(name,"root") && strcmp(seuname, s->fallback->sename) == 0)
> > > -			continue;
> > > -
> > 
> > This appears to change the behavior of genhomedircon in general, not
> > just with respect to %group handling.  Was this intentional?
> > I'm not necessarily opposed to this change, but I am unclear on the
> > implications.  It seems that previously genhomedircon would not generate
> > file_contexts.homedirs entries for users who were mapped to the fallback
> > seuser, with an exception for root for /root labeling.  With this
> > change, they will have entries added.
> 
> I just realized, this might actually be required. I dont remember if I
> checked what happens to %{USERID} or %{USERNAME} entries if they map to
> the fallback. Are fcontexts with those entries done anyway or are they
> skipped? cuz skipped would be bad.

Actually no %{USERNAME} and %{USERID} are fine, they map to [^/]+ and
[0-9]+ respectively in the fallback so there should be no problems
there.

But as far as I can tell having duplicate entries should not cause any
problems and i'd much rather have %group stuff working. ideally tho,
no dups would be preferable.

I will also test this patch, been meaning to but was investigating other
issues and forgot.

-- Jason
> 
> > >  		if (strcmp(name, DEFAULT_LOGIN) == 0)
> > >  			continue;
> > >  
> > >  		if (strcmp(name, TEMPLATE_SEUSER) == 0)
> > >  			continue;
> > >  
> > > -		/* %groupname syntax */
> > > -		if (name[0] == '%')
> > > -			continue;
> > > -
> > >  		/* find the user structure given the name */
> > > -		u = bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
> > > +		u = bsearch(seuname, user_list, nusers,
> > > +			    sizeof(semanage_user_t *),
> > >  			    (int (*)(const void *, const void *))
> > >  			    &name_user_cmp);
> > > -		if (u) {
> > > -			prefix = semanage_user_get_prefix(*u);
> > > -			level = semanage_user_get_mlslevel(*u);
> > > -			if (!level)
> > > -				level = FALLBACK_LEVEL;
> > > -		} else {
> > > -			prefix = name;
> > > -			level = FALLBACK_LEVEL;
> > > -		}
> > > -
> > > -		retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
> > > -		if (retval != 0 || pwent == NULL) {
> > > -			if (retval != 0 && retval != ENOENT) {
> > > -				*errors = STATUS_ERR;
> > > -				goto cleanup;
> > > -			}
> > > -
> > > -			WARN(s->h_semanage,
> > > -			     "user %s not in password file", name);
> > > -			continue;
> > > -		}
> > >  
> > > -		int len = strlen(pwent->pw_dir) -1;
> > > -		for(; len > 0 && pwent->pw_dir[len] == '/'; len--) {
> > > -			pwent->pw_dir[len] = '\0';
> > > +		/* %groupname syntax */
> > > +		if (name[0] == '%') {
> > > +			retval = get_group_users(s, &head, *u, seuname,
> > > +						name);
> > > +		} else {
> > > +			retval = add_user(s, &head, *u, name,
> > > +					  seuname, name);
> > >  		}
> > >  
> > > -		if (strcmp(pwent->pw_dir, "/") == 0) {
> > > -			/* don't relabel / genhomdircon checked to see if root
> > > -			 * was the user and if so, set his home directory to
> > > -			 * /root */
> > > -			continue;
> > > -		}
> > > -		if (ignore(pwent->pw_dir))
> > > -			continue;
> > > -
> > > -		len = snprintf(uid, sizeof(uid), "%u", pwent->pw_uid);
> > > -		if (len < 0 || len >= (int)sizeof(uid)) {
> > > +		if (retval != 0) {
> > >  			*errors = STATUS_ERR;
> > >  			goto cleanup;
> > >  		}
> > > -		len = snprintf(gid, sizeof(gid), "%u", pwent->pw_gid);
> > > -		if (len < 0 || len >= (int)sizeof(gid)) {
> > > -			*errors = STATUS_ERR;
> > > -			goto cleanup;
> > > -		}
> > > -
> > > -		if (push_user_entry(&head, name, uid, gid, seuname,
> > > -				    prefix, pwent->pw_dir, level) != STATUS_SUCCESS) {
> > > -			*errors = STATUS_ERR;
> > > -			break;
> > > -		}
> > >  	}
> > >  
> > >        cleanup:
> > > -	free(rbuf);
> > >  	if (*errors) {
> > >  		for (; head; pop_user_entry(&head)) {
> > >  			/* the pop function takes care of all the cleanup
> > > 
> > 
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
