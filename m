Subject: Re: [PATCH] SELinux: introduce permissive types
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>, jmorris@namei.org,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1204920587.1397.559.camel@moss-spartans.epoch.ncsc.mil>
References: <1204919043.2891.50.camel@localhost.localdomain>
	 <1204920587.1397.559.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 15:36:31 -0500
Message-Id: <1204922191.8402.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-03-07 at 15:09 -0500, Stephen Smalley wrote:
> On Fri, 2008-03-07 at 14:44 -0500, Eric Paris wrote:

> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index 187964e..3eb5d69 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -891,8 +891,15 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> >  	denied = requested & ~(p_ae->avd.allowed);
> >  
> >  	if (!requested || denied) {
> > -		if (selinux_enforcing || (flags & AVC_STRICT))
> > +		if (flags & AVC_STRICT)
> >  			rc = -EACCES;
> > +		else if (selinux_enforcing)
> > +			if (unlikely(security_permissive_sid(ssid) &&
> > +				     requested && node))
> > +				avc_update_node(AVC_CALLBACK_GRANT,requested,
> > +						ssid,tsid,tclass);
> > +			else
> > +				rc = -EACCES;
> >  		else
> >  			if (node)
> >  				avc_update_node(AVC_CALLBACK_GRANT,requested,
> 
> Can you unify the branches above so only one avc_update_node() call is
> present?

Yeah, I'm sure I can come up with something.

else if (!selinux_enforcing || 
	 (unlikely(security_permissive_sid(ssid)) && requested && node))
	avc_update_node(AVC_CALLBACK_GRANT.....
else
	rc = -EACCES;



> > -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_POLCAP
> > +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PERMISSIVE

Will make a similar change in Kconfig

> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index f374186..97b4453 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -416,6 +416,21 @@ inval_class:
> >  	return -EINVAL;
> >  }
> >  
> > +/*
> > + * Given a sid find if the type has the permissive flag set
> > + */
> > +int security_permissive_sid(u32 sid)
> > +{
> > +	struct context *context;
> > +	u32 type;
> > +
> > +	context = sidtab_search(&sidtab, sid);
> > +	BUG_ON(!context);
> > +
> > +	type = context->type;
> > +	return ebitmap_get_bit(&policydb.permissive_map, type);
> 
> This all needs to happen under policy rdlock - take it before looking up
> in the sidtab and release after ebitmap_get_bit (so you have to save
> result to temporary var and return that).  Otherwise, it can get freed
> under you by policy reload.

Do I only need to worry about it freeing under me or should I also worry
about atomicity from security_compute_av() ?  Do I really have any
guarantee that sid is still in the sidtab here?  My BUG_ON() might be
bogus, right?  Should I move the permissive bit check into
security_compute_av() and carry about the bit in the avd_decision?  Is
doing an ebitmap_get too high of a penalty to pay for all access as
opposed to this way which only does it for denials?  If we don't want
the penalty on successful permission requests I can just drop the
BUG_ON() and not worry about things changing under us....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
