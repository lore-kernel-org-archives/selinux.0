Subject: Re: [PATCH] SELinux: introduce permissive types
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>, jmorris@namei.org,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1205177759.5297.54.camel@localhost.localdomain>
References: <1205166057.5297.20.camel@localhost.localdomain>
	 <1205167649.23866.91.camel@moss-spartans.epoch.ncsc.mil>
	 <1205169325.5297.45.camel@localhost.localdomain>
	 <1205170145.23866.104.camel@moss-spartans.epoch.ncsc.mil>
	 <1205177759.5297.54.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 10:39:59 -0400
Message-Id: <1205246399.23866.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-10 at 15:35 -0400, Eric Paris wrote:
> On Mon, 2008-03-10 at 13:29 -0400, Stephen Smalley wrote:
> > On Mon, 2008-03-10 at 13:15 -0400, Eric Paris wrote:
> > > On Mon, 2008-03-10 at 12:47 -0400, Stephen Smalley wrote:
> > > > On Mon, 2008-03-10 at 12:20 -0400, Eric Paris wrote:
> > > > > Introduce the concept of a permissive type.  A new ebitmap is introduced
> > > > > to the policy database which indicates if a given type has the
> > > > > permissive bit set or not.  This bit is tested for the scontext of any
> > > > > denial.  The bit is meaningless on types which only appear as the target
> > > > > of a decision and never the source.  A domain running with a permissive
> > > > > type will be allowed to perform any action similarly to when the system
> > > > > is globally set permissive.
> 
> 
> > > > > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > > > > index 187964e..b13cbc6 100644
> > > > > --- a/security/selinux/avc.c
> > > > > +++ b/security/selinux/avc.c
> > > > > @@ -891,12 +891,15 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> > > > >  	denied = requested & ~(p_ae->avd.allowed);
> > > > >  
> > > > >  	if (!requested || denied) {
> > > > > -		if (selinux_enforcing || (flags & AVC_STRICT))
> > > > > +		if (flags & AVC_STRICT)
> > > > >  			rc = -EACCES;
> > > > > +		else if ((!selinux_enforcing) ||
> > > > 
> > > > Extraneous parens?
> > > 
> > > yeah, I can't format code.
> > > 
> > > > 
> > > > > +			 (unlikely(security_permissive_sid(ssid, p_ae->avd.seqno) &&
> > > > > +				   requested && node)))
> > 
> > Ditto here.
> 
> No, I think those parens are correct....
> 
> > 
> > > > 
> > > > Do we really need the test of requested here?
> > > 
> > > What is supposed to be the return code of !requested?  I was surprised
> > > to find that !requested would typically get back -EACCES even though
> > > clearly nothing was denied.  Not quite sure what !requested means in
> > > this context so I'm not sure what the correct handling of the permissive
> > > bit should be.
> > 
> > It's really a bug, but we were turning it into a null denial.
> > Except avc_audit doesn't quite get it right, as we found in userspace
> > (the avc:  granted null bug, recently fixed in libselinux AVC but not in
> > the kernel one).
> > 
> > I suppose we could just make it a BUG_ON(!requested) on entry.
> 
> Ok then, how about I stop paying attention to !requested at all, I think
> that whole section gets a little easier....
> 
> if (unlikely(!requested)) {
> 	printk("null requested\n")
> 	WARN_ON(1);
> 	return -EACCES;
> }

I'd just make it a BUG_ON.  But make that a separate patch.  You can put
it first in the series.

> 
> if (denied)
> 	do cool stuff
> 
> > > > > +/*
> > > > > + * Given a sid find if the type has the permissive flag set
> > > > > + */
> > > > > +int security_permissive_sid(u32 sid, u32 seqno)
> > > > > +{
> > > > > +	struct context *context;
> > > > > +	u32 type;
> > > > > +	int rc;
> > > > > +
> > > > > +	POLICY_RDLOCK;
> > > > > +
> > > > > +	/* return 0 if policy changed since decision was made */
> > > > > +	if (seqno != latest_granting)
> > > > > +		return 0;
> > > > 
> > > > Is this really needed?  May cause false denials.
> > > 
> > > I decided to be less worried about false denials then false allows.
> > 
> > Bad strategy for permissive domains, as it can cause breakage which is
> > precisely the thing you are trying to prevent with permissive domains.
> > 
> > > Assume policy has type1_t not permissive and type1_t is number 100.  It
> > > gets a denial and between the av_computer call and the permissive check
> > > someone loads new policy with some_other_type_t as number 100.  If
> > > some_other_type_t is permissive I want to make sure that type1_t still
> > > gets its denial.
> > 
> > Contexts in the sidtab get remapped across policy reload.
> 
> I'll reread the remapping stuff to convince myself that all of this is
> going to work correctly.  As is most likely you are right and just
> allowing the permissive bit even on policy reload is the right way to
> go.
> 
> > > > > +
> > > > > +	context = sidtab_search(&sidtab, sid);
> > > > > +	BUG_ON(!context);
> > > > > +
> > > > > +	type = context->type;
> > > > > +	rc = ebitmap_get_bit(&policydb.permissive_map, type);
> > > > 
> > > > Typically we'd use (type - 1) above.
> > > 
> > > Yes, I actually left bit 0 open in case we ever wanted to put global
> > > permissive into the policy rather than through the selinuxfs interface.
> > > Using bit 0 to do this seemed like an easy and ideal solution.  I wasn't
> > > going to bring that discussion up just yet to see if people liked the
> > > idea but here it is.  Who would be interested in seeing global
> > > permissive inside policy rather than through selinuxfs?
> > 
> > Hmmm...but selinuxfs would still be able to override the policy setting?
> > And what about enforcing=0 on the command line - who wins at initial
> > policy load?  Seems confusing.
> 
> Still a bit of thought before it comes to pass.  But there was a reason
> I left the 0 bit unused...
> 
> -Eric
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
