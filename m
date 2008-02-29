From: Paul Moore <paul.moore@hp.com>
To: James Antill <james.antill@redhat.com>
Subject: Re: [RFC PATCH] SELinux: Cleanup the secid/secctx conversion functions
Date: Fri, 29 Feb 2008 12:03:40 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20080228214152.32557.76137.stgit@flek.americas.hpqcorp.net> <1204294426.31790.256.camel@moss-spartans.epoch.ncsc.mil> <1204303255.11268.326.camel@code.and.org>
In-Reply-To: <1204303255.11268.326.camel@code.and.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802291203.40204.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 29 February 2008 11:40:55 am James Antill wrote:
> On Fri, 2008-02-29 at 09:13 -0500, Stephen Smalley wrote:
> > On Fri, 2008-02-29 at 08:54 -0500, Stephen Smalley wrote:
> > > The snippet below looks like a step backward rather than an
> > > improvement - single sprintf replaced by series of strcat calls. 
> > > That can't be more efficient.
> >
> > Hmm...well, maybe I'm wrong (after looking at the implementations).
> > Pity that Linux doesn't have stpcpy (as in glibc) - that is much
> > nicer than a series of strcat's since it returns the end pointer
> > and doesn't require finding the end of string each time.
>
>  Note that you can do (only slightly abusing the interface):
>
> 	ctx = *scontext;
>
> 	ctx += strlcpy(ctx, policydb.p_user_val_to_name[context->user - 1],
> -1); ctx += strlcpy(ctx, ":", -1);
> 	ctx += strlcpy(ctx, policydb.p_role_val_to_name[context->role - 1],
> -1); ctx += strlcpy(ctx, ":", -1);
> 	ctx += strlcpy(ctx, policydb.p_type_val_to_name[context->type - 1],
> -1);
>
> ...which is basically a memcpy() with a simple if test.

... except for that strlen() call right at the top, there are also two 
comparisons (you only accounted for one) and a add/subtract 
operation :)

[NOTE: I'm comparing the architecture independent versions of these 
functions]

The strlcpy() implementation does a strlen() and a memcpy() call along 
with two comparisons and some trivial math.  The strcat() 
implementation does pretty much the same thing but with less 
comparisons and no additional math.  The strcpy() implementation only 
does a byte-by-byte copy which should be faster then strlcpy() even 
when one factors in an optimized memcpy() implementation due to the 
strlen() call.

My conclusion is that the strcpy()/strcat() approach should be at least 
as fast as the strlcpy() approach if not a smidge faster.

> > > > -	*scontextp = 0;
> > > > +	ctx = *scontext;
> > > > +	strcpy(ctx, policydb.p_user_val_to_name[context->user - 1]);
> > > > +	strcat(ctx, ":");
> > > > +	strcat(ctx, policydb.p_role_val_to_name[context->role - 1]);
> > > > +	strcat(ctx, ":");
> > > > +	strcat(ctx, policydb.p_type_val_to_name[context->type - 1]);

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
