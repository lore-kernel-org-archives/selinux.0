MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: SELinux and LSM chaining.
Date: Wed, 24 Jan 2007 09:52:49 -0800
Message-ID: <2069DE2C1E4BD64CABAB75F191A2B993A62732@beaexmb1.corp.nai.org>
From: <Martin_Stoilov@mcafee.com>
To: <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, <jmorris@namei.org>, <Valdis.Kletnieks@vt.edu>,
        <jbrindle@tresys.com>, <eparis@parisplace.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Than you Stephen,

That was helpful, although disappointing. At least I understand that I
should be looking for a different approach and don't expect SELinux to
play nicely with secondary security modules.

Best Regards,
-Martin

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Wednesday, January 24, 2007 9:12 AM
To: Stoilov, Martin
Cc: selinux@tycho.nsa.gov; James Morris; Valdis Kletnieks; Joshua
Brindle; Eric Paris
Subject: Re: SELinux and LSM chaining.

On Tue, 2007-01-23 at 15:38 -0500, Stephen Smalley wrote:
> On Tue, 2007-01-23 at 12:35 -0800, Martin_Stoilov@McAfee.com wrote:
> > Hello,
> > 
> >  
> > 
> > I have a question about SELinux and LSM chaining. It looks like
> > SELinux hooks support module chaining, but unfortunately not all
hooks
> > pass the security requests to the chained module. For example the
> > inode_create hook is implemented like this:
> > 
> > static int selinux_inode_create(struct inode *dir, struct dentry
> > *dentry, int mask)
> > 
> > {
> > 
> >     return may_create(dir, dentry, SECCLASS_FILE);
> > 
> > }
> > 
> >  
> > 
> > Instead of:
> > 
> > static int selinux_inode_create(struct inode *dir, struct dentry
> > *dentry, int mask)
> > 
> > {
> > 
> >     Int rc;
> > 
> >     rc = secondary_ops->inode_lcreate(dir, dentry, mask);
> > 
> >     if (rc)
> > 
> >         return rc;
> > 
> >     return may_create(dir, dentry, SECCLASS_FILE);
> > 
> > }
> > 
> >  
> > 
> > Is there any particular reason to implement security module chaining
> > for some operations only? What is the preferred way to hook
operations
> > that SELinux don't pass to the chained module?
> 
> You may wish to read the following thread:
> http://marc.theaimsgroup.com/?l=selinux&m=116897135223285&w=2

Also, with regard to your specific question, we originally only made
calls to the secondary module where necessary to support trivial
stacking with the capabilities module.  We later added a few more
secondary calls upon request to support some other trivial security
modules, but I'm not clear that they are still being used, and am
inclined to remove those if I don't hear otherwise.

We may also want to remove the use of secondary_ops altogether from
SELinux and just hard code direct calls to the cap_ functions, since we
don't gain any real benefit there (but we would need to take care that
we still fall back cleanly to capabilities only when selinux is disabled
at runtime).

And there has been some consideration of replacing LSM's dynamic
registration with compile-time selection of security module to avoid
misuse.

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
