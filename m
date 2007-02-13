Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1171369673.3242.16.camel@moss-spartans.epoch.ncsc.mil>
References: <1171309430.10871.2.camel@localhost.localdomain>
	 <1171369673.3242.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 12:28:34 -0500
Message-Id: <1171387714.10871.22.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-13 at 07:27 -0500, Stephen Smalley wrote:
> On Mon, 2007-02-12 at 14:43 -0500, Eric Paris wrote:
> > I do still have a problem.  I don't really understand the 'inherits'
> > ideas and so I'm not sure how to pad my p->undefined_perms[tclass] with
> > permissions which are missing in policy due to an incorrect or missing
> > inherits statement.  If this approach seems good and reasonable I will
> > try to better understand how I can glean those bits from
> > validate_classes() and I will also move this to use config flags and
> > have multiple options on how to handle policies.
> 
> Missing or incorrect inherits clause should remain fatal, I'd say - it
> is too substantive a change to the class definition to expect a running
> kernel to adapt.  Classes that inherit a common definition pick up their
> initial set of permission bits from that common definition, such that
> those bits are uniform across those classes and can be checked by a
> single permission check (e.g. for common file or socket checks).  But as
> soon as you remove or change them, in addition to removing all of those
> inherited permissions, you will have disturbed the values of any
> subsequent class-specific permissions.

ATM one of the inherits checking paths is non-fatal in validate_classes
I'll spend some time to understand it and either make it fatal or figure
out how to fill my table correctly

> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index ca9154d..e6a60a5 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -306,22 +306,30 @@ static int context_struct_compute_av(struct context *scontext,
> >  		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
> >  			tclass = SECCLASS_NETLINK_SOCKET;
> >  
> > -	if (!tclass || tclass > policydb.p_classes.nprim) {
> > -		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> > -		       tclass);
> > -		return -EINVAL;
> > -	}
> > -	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> > -
> >  	/*
> >  	 * Initialize the access vectors to the default values.
> > +	 * This will pad the allow for undefined perms if appropriete.
> >  	 */
> > -	avd->allowed = 0;
> > +	if(selinux_allow_unknown)
> > +		avd->allowed = policydb.undefined_perms[tclass];
> 
> You moved the bounds checks on tclass down further, but here you use
> tclass as an index.  Also, why [tclass] vs. [tclass-1] as in other code?
> Aren't you wasting undefined_perms[0]?

I'll work a little on the bounds checking but only the it(!tclass) part
is even relevant since the padding array is large enough even if tclass
is greater than the # of kernel classes.  I'll look at tclass vs. tclass
-1.  I'm surprised I didn't get a notice I was writing outside of my
malloc'd area now that I think about it....

> > @@ -1045,6 +1054,19 @@ static int validate_classes(struct policydb *p)
> >  	const char *def_class, *def_perm, *pol_class;
> >  	struct symtab *perms;
> >  
> > +	if (selinux_allow_unknown) {
> > +		int num_classes;
> 
> u32

u16?  But irrelevant. 

> > +		if (kdefs->cts_len > p->p_classes.nprim)
> > +			num_classes = kdefs->cts_len;
> > +		else
> > +			num_classes = p->p_classes.nprim;
> > +		p->undefined_perms = kzalloc(sizeof(u32)*num_classes, GFP_KERNEL);
> > +		if (!p->undefined_perms) {
> > +			rc = -ENOMEM;
> > +			goto out;
> > +		}
> > +	}
> > +
> >  	for (i = 1; i < kdefs->cts_len; i++) {
> >  		def_class = kdefs->class_to_string[i];
> >  		if (i > p->p_classes.nprim) {

This is a vestige of the original av padding where I had to be concerned
that p->p_classes.nprim was larger than kdefs->cts_len.  Since now I
only use the array when making permission checks I can assume that I
will never get a class from the check greater than the number of kernel
classes defined.  So all that can be simplified to just
p->undefined_perms = kzalloc(sizeof(u32)*kdefs->cts_len, GFP_KERNEL);

> > @@ -1083,14 +1108,16 @@ static int validate_classes(struct policydb *p)
> >  			printk(KERN_ERR
> >  			       "security:  permission %s in class %s not found in policy\n",
> >  			       def_perm, pol_class);
> > -			return -EINVAL;
> > +			rc = -EINVAL;
> > +			goto out;
> 
> I would have thought that this also would have turned into a non-fatal
> error if (selinux_allow_unknown).  No?

Yup, can fix.

> > @@ -1126,17 +1154,24 @@ static int validate_classes(struct policydb *p)
> >  				printk(KERN_ERR
> >  				       "security:  permission %s in class %s not found in policy\n",
> >  				       def_perm, pol_class);
> > -				return -EINVAL;
> > +				rc = -EINVAL;
> > +				goto out;
> 
> Ditto.

Part of the inherits stuff that I still don't fully understand.  If made
non-fatal I have to fill my table properly.

> 
> > +out:
> > +	if (rc && selinux_allow_unknown) {
> > +		kfree(p->undefined_perms);
> > +		p->undefined_perms = NULL;
> 
> Is this necessary - it would be caught when the policydb is destroyed on
> the final exit path of the caller, right?  Once we link something into a
> policydb, we generally don't free it except upon policydb_destroy.

Another vestige of original implementation before I realized that I
could (and needed to) carry this information inside the policydb.
Removing this also allows me to revert all of the goto additions.

As I oh so slowly work through this I see that this patch is going to
end up being about 10 lines!!

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
