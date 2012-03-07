Message-ID: <1331130216.3040.8.camel@localhost>
Subject: Re: [PATCH] SELinux: allow default source/target selectors for
 user/role/range
From: Eric Paris <eparis@redhat.com>
To: qingtao.cao@windriver.com
Cc: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Date: Wed, 07 Mar 2012 09:23:36 -0500
In-Reply-To: <4F571D9E.5060706@windriver.com>
References: <1331080128-26425-1-git-send-email-eparis@redhat.com>
	 <4F571D9E.5060706@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-03-07 at 16:34 +0800, Harry Ciao wrote:
> Comments embedded below.

[lots of snipping throughout]

> > @@ -530,6 +531,24 @@ int mls_compute_sid(struct context *scontext,
> >   		r = hashtab_search(policydb.range_tr,&rtr);
> >   		if (r)
> >   			return mls_range_set(newcontext, r);
> > +
> > +		cladatum = policydb.class_val_to_struct[tclass - 1];
> > +
> > +		switch (cladatum->default_range) {
> > +		case DEFAULT_SOURCE_LOW:
> > +			return mls_context_cpy_low(newcontext, scontext);
> > +		case DEFAULT_SOURCE_HIGH:
> > +			return mls_context_cpy_high(newcontext, scontext);
> > +		case DEFAULT_SOURCE_LOW_HIGH:
> > +			return mls_context_cpy(newcontext, scontext);
> > +		case DEFAULT_TARGET_LOW:
> > +			return mls_context_cpy_low(newcontext, tcontext);
> > +		case DEFAULT_TARGET_HIGH:
> > +			return mls_context_cpy_high(newcontext, tcontext);
> > +		case DEFAULT_TARGET_LOW_HIGH:
> > +			return mls_context_cpy(newcontext, tcontext);
> 
> How about introducing a default case to take care of when default_range 
> is unset ? where mls_context_cpy_low(newcontext, scontext) could be 
> leveraged to handle such case.

Notice the fallthrough.  I added a few more lines of context.  We do
exactly what you ask for.  If unset nothing changes from today.  If set
we get the defaults policy set.

> > +		}
> > +
> >   		/* Fallthrough */
> >   	case AVTAB_CHANGE:
> >   		if ((tclass == policydb.process_class) || (sock == true))
                        /* Use the process MLS attributes. */
                        return mls_context_cpy(newcontext, scontext);
                else
                        /* Use the process effective MLS attributes. */
                        return mls_context_cpy_low(newcontext, scontext);

> > @@ -1450,17 +1456,25 @@ static int security_compute_sid(u32 ssid,
> >   		break;
> >   	}
> >
> > -	/* Set the role and type to default values. */
> > -	if ((tclass == policydb.process_class) || (sock == true)) {
> > -		/* Use the current role and type of process. */
> > +	/* Set the role to default values. */
> > +	if (cladatum->default_role == DEFAULT_SOURCE) {
> >   		newcontext.role = scontext->role;
> > -		newcontext.type = scontext->type;
> > +	} else if (cladatum->default_role == DEFAULT_TARGET) {
> > +		newcontext.role = tcontext->role;
> >   	} else {
> > -		/* Use the well-defined object role. */
> > -		newcontext.role = OBJECT_R_VAL;
> > +		if ((tclass == policydb.process_class) || (sock == true))
> > +			newcontext.role = scontext->role;
> > +		else
> > +			newcontext.role = OBJECT_R_VAL;
> 
> OBJECT_R_VAL will be fallen back on when the default_role is unset, I 
> assume the above if-else condition could be eliminated if the 
> default_role for the process and various socket classes are specifically 
> defined as DEFAULT_SOURCE.

Yes, it absolutely could.  But we don't want to force a policy upgrade
to upgrade the kernel.  Thus we can't get rid of the legacy process/sock
handling.  I feel like any other option here would make the code worse,
not better looking.

> > +	}
> > +
> > +	/* Set the type to default values. */
> > +	if ((tclass == policydb.process_class) || (sock == true))
> > +		/* Use the type of process. */
> > +		newcontext.type = scontext->type;
> > +	else
> 
> If default_type would be employed then the process and all socket 
> classes won't have to be differentiated from other classes. Moreover, 
> the support for the "socket labeling" behavior would be obsolete now 
> that we have a much better solution and could be properly reverted.

Yup.  If it only weren't for those blasted users that don't update
everything every time I might want them to *smile*

Thanks for the comments!  Though, I don't think there is a lot we can do
to really make the code better while still supporting old systems.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
