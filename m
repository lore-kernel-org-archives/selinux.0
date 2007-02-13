Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1171388941.3242.93.camel@moss-spartans.epoch.ncsc.mil>
References: <1171309430.10871.2.camel@localhost.localdomain>
	 <1171369673.3242.16.camel@moss-spartans.epoch.ncsc.mil>
	 <1171387714.10871.22.camel@localhost.localdomain>
	 <1171388407.3242.87.camel@moss-spartans.epoch.ncsc.mil>
	 <1171388941.3242.93.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 12:57:12 -0500
Message-Id: <1171389432.3242.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-13 at 12:49 -0500, Stephen Smalley wrote:
> On Tue, 2007-02-13 at 12:40 -0500, Stephen Smalley wrote:
> > On Tue, 2007-02-13 at 12:28 -0500, Eric Paris wrote:
> > > On Tue, 2007-02-13 at 07:27 -0500, Stephen Smalley wrote:
> > > > You moved the bounds checks on tclass down further, but here you use
> > > > tclass as an index.  Also, why [tclass] vs. [tclass-1] as in other code?
> > > > Aren't you wasting undefined_perms[0]?
> > > 
> > > I'll work a little on the bounds checking but only the it(!tclass) part
> > > is even relevant since the padding array is large enough even if tclass
> > > is greater than the # of kernel classes.
> > 
> > The entire bounds check is either relevant together or not at all; you
> > either check that the inputs to the function are within the
> > policy-defined range before using them as indices or you treat that as a
> > kernel bug (in which case you BUG_ON it).  We have seen cases where
> > completely out of range classes have been passed in as a result of a
> > kernel bug elsewhere.
> > 
> > > > > @@ -1045,6 +1054,19 @@ static int validate_classes(struct policydb *p)
> > > > >  	const char *def_class, *def_perm, *pol_class;
> > > > >  	struct symtab *perms;
> > > > >  
> > > > > +	if (selinux_allow_unknown) {
> > > > > +		int num_classes;
> > > > 
> > > > u32
> > > 
> > > u16?  But irrelevant. 
> > 
> > You were assigning u32 values to it (from kdefs->cts_len or
> > p->p_classes.nprim).
> > 
> > > This is a vestige of the original av padding where I had to be concerned
> > > that p->p_classes.nprim was larger than kdefs->cts_len.  Since now I
> > > only use the array when making permission checks I can assume that I
> > > will never get a class from the check greater than the number of kernel
> > > classes defined.  So all that can be simplified to just
> > > p->undefined_perms = kzalloc(sizeof(u32)*kdefs->cts_len, GFP_KERNEL);
> > 
> > No - security_compute_av can also be called via selinuxfs to check
> > userland security classes (from libselinux for userspace object
> > managers).
> 
> Also, keep in mind that the plan is to strip the userland class and
> permission definitions out of the kernel headers so that it stops
> validating them and they can change without affecting the kernel.  Just
> requires an update to the scripts that generate those headers to split
> the output to different sets of headers for kernel vs. libselinux based
> on the already existing "userspace" comment marker in the
> security_classes file.  That is allegedly already done for refpolicy,
> although I don't see it yet in the public svn, at least on the trunk.

Ah, it looks like there is a flask-headers-2121 branch there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
