From: Paul Moore <pmoore@redhat.com>
To: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: correctly label /proc inodes in use before the
 policy is loaded
Date: Wed, 05 Mar 2014 14:26:34 -0500
Message-ID: <1821968.ne38jZ0Fly@sifl>
In-Reply-To: <1394044822.4862.1.camel@flatline.rdu.redhat.com>
References: <20140305164407.16288.91349.stgit@localhost>
 <53175F8B.7010704@tycho.nsa.gov>
 <1394044822.4862.1.camel@flatline.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, March 05, 2014 01:40:22 PM Eric Paris wrote:
> On Wed, 2014-03-05 at 12:31 -0500, Stephen Smalley wrote:
> > On 03/05/2014 11:44 AM, Paul Moore wrote:
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 57b0b49..d554e7e 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -1419,15 +1419,32 @@ static int inode_doinit_with_dentry(struct inode
> > > *inode, struct dentry *opt_dent> > 
> > >  		isec->sid = sbsec->sid;
> > >  		
> > >  		if ((sbsec->flags & SE_SBPROC) && !S_ISLNK(inode->i_mode)) {
> > > 
> > > -			if (opt_dentry) {
> > > -				isec->sclass = inode_mode_to_security_class(inode-
>i_mode);
> > > -				rc = selinux_proc_get_sid(opt_dentry,
> > > -							  isec->sclass,
> > > -							  &sid);
> > > -				if (rc)
> > > -					goto out_unlock;
> > > -				isec->sid = sid;
> > > -			}
> > > +			/* Need a dentry, since the procfs API requires one. */
> > 
> > Comment isn't accurate; unlike the xattr case where the dentry
> > requirement originates from the ->getxattr API, here we need a dentry
> > for our own internal selinux_proc_get_sid() helper.  Otherwise, looks
> > fine.
> 
> I guess I could have written that comment better...
> 
> /* We must have a dentry to determine the label on procfs inodes */
> 
> With a comment change like that
> 
> Acked-by: Eric Paris <eparis@redhat.com>

Updated.  I'll push it to next later today.

-- 
paul moore
security and virtualization @ redhat
