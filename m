Subject: Re: [RFC PATCH] 1/2 decouple fscontext/context
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1151596403.6999.83.camel@moss-spartans.epoch.ncsc.mil>
References: <1151536165.26384.48.camel@localhost.localdomain>
	 <1151596403.6999.83.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 18:11:32 -0400
Message-Id: <1151619092.26384.90.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-29 at 11:53 -0400, Stephen Smalley wrote:
> On Wed, 2006-06-28 at 19:09 -0400, Eric Paris wrote:
> > This patch will remove the conflict between fscontext and context mount
> > options.  It is now possible to use them both.  If context= is specified
> > without fscontext it will operate just as before, if both are specified
> > we will use mount point labeling and all inodes will get the label
> > specified by context=.   The superblock will be labeled with the label
> > of fscontext=, thus affecting associate permissions.
> 
> >  hooks.c          |   62 ++++++++++++++++++++++++++++++++++++++++++++++++-------
> >  include/objsec.h |    3 +-
> >  2 files changed, 57 insertions(+), 8 deletions(-)
> 
> diffstat -p1

Will do
> 
> > --- linux-2.6.17-rootcontext/security/selinux/hooks.c.rootcontext	2006-06-23 16:42:30.000000000 -0400
> > +++ linux-2.6.17-rootcontext/security/selinux/hooks.c	2006-06-28 17:47:18.000000000 -0400
> > @@ -441,6 +443,42 @@ static int try_context_mount(struct supe
> >  	if (!seen)
> >  		goto out;
> >  
> > +	/* 
> > +	 * sets the context of the superblock, sbsec->sid for the fs being mounted
> > +	 * is done before context= because context= will also set the superblock
> > +	 * if it is not already set by fscontext=
> 
> Needs a bit of a rewrite.  Watch for trailing whitespace.
> Describe what the code does, not how it does it, as per CodingStyle.

Coding Style re-read and paid particular attention to comments section.
> 
> > +	 */
> > +	if (fscontext) {
> > +		rc = security_context_to_sid(fscontext, strlen(fscontext), &sid);
> > +		if (rc) {
> > +			printk(KERN_WARNING "SELinux: security_context_to_sid"
> > +			       "(%s) failed for (dev %s, type %s) errno=%d\n",
> > +			       fscontext, sb->s_id, name, rc);
> > +			goto out_free;
> > +		}
> > +
> > +		rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
> > +		                  FILESYSTEM__RELABELFROM, NULL);
> > +		if (rc)
> > +			goto out_free;
> > +
> > +		rc = avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
> > +		                  FILESYSTEM__RELABELTO, NULL);
> > +		if (rc)
> > +			goto out_free;
> 
> I'd split out the permission checks and do them once, or move them into
> a helper function and call it twice.

suggestion for a meaningful name?  context_mount_set_perm()?

[snip]

> > @@ -450,7 +488,7 @@ static int try_context_mount(struct supe
> >  			goto out_free;
> >  		}
> >  
> > -		rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
> > +		rc = avc_has_perm(tsec->sid, sbsec->mntpoint_sid, SECCLASS_FILESYSTEM,
> >  		                  FILESYSTEM__RELABELFROM, NULL);
> 
> This will always end up checking against unlabeled_t, right?  I don't
> think it is what you want, and it changes the existing behavior for
> people using context= mounts.

So you are saying that both should check against the superblock.  The
question is if this second check should be the 'new' superblock context
(since may have been just set by fscontext=) or should I be checking the
'old' sb sid here?  

> 
> >  		if (rc)
> >  			goto out_free;
> > @@ -460,7 +498,9 @@ static int try_context_mount(struct supe
> >  		if (rc)
> >  			goto out_free;
> >  
> > -		sbsec->sid = sid;
> > +		if (sbsec->sid == SECINITSID_UNLABELED)
> > +			sbsec->sid = sid;
> > +		sbsec->mntpoint_sid = sid;
> 
> sbsec->sid is initialized by the security_fs_use() call (based on the
> policy configuration for the fs, either fs_use* or genfs) prior to
> try_context_mount(), so testing for unlabeled isn't sufficient, right?
> I think you want to explicitly check whether fscontext was set here.

now, if (!fscontext)

> 
> >  		if (seen & Opt_context)
> >  			sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
> 
> No longer needs to be conditional here, right?  Since this branch is now
> specific to the context= option?

Yup

> 
> > +	case SECURITY_FS_USE_MNTPOINT:
> > +		/* use the mntpoint_sid */
> > +		if (sbsec->mntpoint_sid != SECINITSID_UNLABELED)
> > +			isec->sid = sbsec->mntpoint_sid;
> > +		else
> > +			isec->sid = sbsec->sid;
> > +		break;
> 
> Why wouldn't this always be using mntpoint_sid?  

Originally when I put this in I didn't know if there was any way to get
mount point labeling behavior without a context= option.  During testing
I looked around and realized there was no other way (that I saw) but
never pulled this back out.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
