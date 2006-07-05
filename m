Subject: Re: [PATCH] 2/2 rootcontext=, are RELABELFROM and ASSOCIATE enough
	in may_context_mount_inode_relabel?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1152128604.26384.198.camel@localhost.localdomain>
References: <1152121645.26384.171.camel@localhost.localdomain>
	 <1152123400.12435.97.camel@moss-spartans.epoch.ncsc.mil>
	 <1152128604.26384.198.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 16:36:44 -0400
Message-Id: <1152131804.13773.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-07-05 at 15:43 -0400, Eric Paris wrote:
> > > +static int may_context_mount_inode_relabel(u32 sid, 
> > > +			struct superblock_security_struct *sbsec,
> > > +			struct task_security_struct *tsec)
> > > +{
> > > +	int rc;
> > > +	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
> > > +			  FILESYSTEM__RELABELFROM, NULL);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	rc = avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM,
> > > +			  FILESYSTEM__ASSOCIATE, NULL);
> > > +	return rc;
> > > +}
> 
> Not trying to bomb my own ack'd patch, but I do question why we don't
> check RELABEL_TO for the new context we set either from rootcontext or
> defcontext.  Wouldn't there be cases where we pass associate but
> wouldn't want to allow relabel_to?  Does associate inherently mean that
> we are allowed to relabel to that type?  I've been trying to think of a
> way to exploit this for some usable purpose and admittedly I can't think
> of one, but that doesn't mean that it isn't there...

First, you need to distinguish between the file relabeling checks (of
selinux_inode_setxattr) and the context mount checks.  Don't confuse
file relabelfrom/relabelto with filesystem relabelfrom/relabelto.

Second, keep in mind that there is some overloading going on here, as we
didn't originally have context mount options and when they were
introduced, they leveraged the old permissions for relabeling of
superblock security contexts that used to be supported when SELinux had
its own persistent label mapping on the filesystem (prior to migration
to using xattrs).

The filesystem relabelto check is expected to occur against a
filesystem/superblock SID, not an inode SID, and represents the
relabeling of the superblock to a new value.  That is why we don't
presently apply it to defcontext= (which doesn't actually relabel any
object with an existing label - it just defines the default label for
inodes without an xattr).  Given the relabelfrom check against the
superblock SID and the associate check, we can at least establish a
transitive relationship between the process and the defcontext SID (or
the rootcontext SID in your case).  If we needed something
finer-grained, we could introduce a further check there, but that should
really be a separate permission check against the inode's security
class, not the filesystem relabelto check.  But we don't yet have an
example needing that granularity.

> on another note in may_context_mount_sb_relabel, when I set both
> fscontext and context shouldn't we be checking the associate permission
> between the context= (all files on the fs) and the context set to the sb
> from fscontext?

Hmmm...I suppose in that case, the context= value is not being used as a
superblock security context, and thus you should be applying the
associate check instead of the relabelto check for it.

> should we check all 3 perms for all 4 context mount options?  My patch
> doesn't change what we have today, but I'm not convinced they are
> complete....

Ideally, we'd only check filesystem class permissions against superblock
SIDs (as the target SID).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
