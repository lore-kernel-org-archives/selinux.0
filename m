Subject: Re: [PATCH 1/1] selinux: Delete mls_copy_context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <457ED543.80905@hp.com>
References: <457EC911.7060006@trustedcs.com>  <457ED543.80905@hp.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 13:31:24 -0500
Message-Id: <1165948284.998.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-12-12 at 11:13 -0500, Paul Moore wrote:
> Venkat Yekkirala wrote:
> > diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
> > index 0562bac..3f57585 100644
> > --- a/security/selinux/ss/context.h
> > +++ b/security/selinux/ss/context.h
> > @@ -55,6 +55,29 @@ out:
> >  	return rc;
> >  }
> >  
> > +/*
> > + * Copies the effective MLS range from `src' into `dst'.
> > + */
> 
> This isn't your fault, the old code used the same comment, but I wonder if it is
> better to say:
> 
>  "Copies the low MLS range from 'src' into 'dst'."
> 
> As the concept of "effective" and "clearance" are policy constructs and not
> hardcoded into the kernel.

Possibly "Sets both levels in the MLS range of 'dst' to the low level of
'src'."   And renaming the function to something that more clearly
indicates that purpose (neither the old name nor the new one are very
obvious in their meaning).

> 
> > +static inline int mls_context_scpy(struct context *dst, struct context *src)
> > +{
> > +	int rc;
> > +
> > +	if (!selinux_mls_enabled)
> > +		return 0;
> > +
> > +	dst->range.level[0].sens = src->range.level[0].sens;
> > +	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
> > +	if (rc)
> > +		goto out;
> > +
> > +	dst->range.level[1].sens = src->range.level[0].sens;
> > +	rc = ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[0].cat);
> > +	if (rc)
> > +		ebitmap_destroy(&dst->range.level[0].cat);
> > +out:
> > +	return rc;
> > +}

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
