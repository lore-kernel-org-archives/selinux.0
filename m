Subject: Re: [PATCH] SELinux: introduce permissive types
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>, jmorris@namei.org,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1205167649.23866.91.camel@moss-spartans.epoch.ncsc.mil>
References: <1205166057.5297.20.camel@localhost.localdomain>
	 <1205167649.23866.91.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 10 Mar 2008 13:15:25 -0400
Message-Id: <1205169325.5297.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-10 at 12:47 -0400, Stephen Smalley wrote:
> On Mon, 2008-03-10 at 12:20 -0400, Eric Paris wrote:
> > Introduce the concept of a permissive type.  A new ebitmap is introduced
> > to the policy database which indicates if a given type has the
> > permissive bit set or not.  This bit is tested for the scontext of any
> > denial.  The bit is meaningless on types which only appear as the target
> > of a decision and never the source.  A domain running with a permissive
> > type will be allowed to perform any action similarly to when the system
> > is globally set permissive.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > 
> > ---
> > 
> > I 'solved' the issue where security_compute_av and the permissive sid
> > checking are not atomic by checking that the seqno in the avd still
> > matches the latest_granting.  latest_granting is protected by
> > POLICY_WRLOCK except when !ss_initialized so this should close any
> > races.  Also cleaned up some formatting and fixed Kconfig.
> > 
> >  security/selinux/Kconfig            |    2 +-
> >  security/selinux/avc.c              |   11 +++++++----
> >  security/selinux/include/security.h |    5 ++++-
> >  security/selinux/ss/policydb.c      |   11 +++++++++++
> >  security/selinux/ss/policydb.h      |    2 ++
> >  security/selinux/ss/services.c      |   25 +++++++++++++++++++++++++
> >  6 files changed, 50 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> > index 2b517d6..a436d1c 100644
> > --- a/security/selinux/Kconfig
> > +++ b/security/selinux/Kconfig
> > @@ -145,7 +145,7 @@ config SECURITY_SELINUX_POLICYDB_VERSION_MAX
> >  config SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
> >  	int "NSA SELinux maximum supported policy format version value"
> >  	depends on SECURITY_SELINUX_POLICYDB_VERSION_MAX
> > -	range 15 22
> > +	range 15 23
> >  	default 19
> >  	help
> >  	  This option sets the value for the maximum policy format version
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index 187964e..b13cbc6 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -891,12 +891,15 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> >  	denied = requested & ~(p_ae->avd.allowed);
> >  
> >  	if (!requested || denied) {
> > -		if (selinux_enforcing || (flags & AVC_STRICT))
> > +		if (flags & AVC_STRICT)
> >  			rc = -EACCES;
> > +		else if ((!selinux_enforcing) ||
> 
> Extraneous parens?

yeah, I can't format code.

> 
> > +			 (unlikely(security_permissive_sid(ssid, p_ae->avd.seqno) &&
> > +				   requested && node)))
> 
> Do we really need the test of requested here?

What is supposed to be the return code of !requested?  I was surprised
to find that !requested would typically get back -EACCES even though
clearly nothing was denied.  Not quite sure what !requested means in
this context so I'm not sure what the correct handling of the permissive
bit should be.

> > +/*
> > + * Given a sid find if the type has the permissive flag set
> > + */
> > +int security_permissive_sid(u32 sid, u32 seqno)
> > +{
> > +	struct context *context;
> > +	u32 type;
> > +	int rc;
> > +
> > +	POLICY_RDLOCK;
> > +
> > +	/* return 0 if policy changed since decision was made */
> > +	if (seqno != latest_granting)
> > +		return 0;
> 
> Is this really needed?  May cause false denials.

I decided to be less worried about false denials then false allows.
Assume policy has type1_t not permissive and type1_t is number 100.  It
gets a denial and between the av_computer call and the permissive check
someone loads new policy with some_other_type_t as number 100.  If
some_other_type_t is permissive I want to make sure that type1_t still
gets its denial.  Its not a particularly large window (reload between
the compute and the permissive check) and I'm not sure if we would
rather have accidental allows or accidental denials?  I'll leave that up
to the list.

Then again anyone using a permissive domain is probably the type of user
who would prefer an accidental allow to an accidental denial....

> > +
> > +	context = sidtab_search(&sidtab, sid);
> > +	BUG_ON(!context);
> > +
> > +	type = context->type;
> > +	rc = ebitmap_get_bit(&policydb.permissive_map, type);
> 
> Typically we'd use (type - 1) above.

Yes, I actually left bit 0 open in case we ever wanted to put global
permissive into the policy rather than through the selinuxfs interface.
Using bit 0 to do this seemed like an easy and ideal solution.  I wasn't
going to bring that discussion up just yet to see if people liked the
idea but here it is.  Who would be interested in seeing global
permissive inside policy rather than through selinuxfs?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
