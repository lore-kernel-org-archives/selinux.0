Subject: Re: [PATCH] 2/2 rootcontext=, are RELABELFROM and ASSOCIATE enough
	in may_context_mount_inode_relabel?
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1152123400.12435.97.camel@moss-spartans.epoch.ncsc.mil>
References: <1152121645.26384.171.camel@localhost.localdomain>
	 <1152123400.12435.97.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 15:43:24 -0400
Message-Id: <1152128604.26384.198.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > +static int may_context_mount_inode_relabel(u32 sid, 
> > +			struct superblock_security_struct *sbsec,
> > +			struct task_security_struct *tsec)
> > +{
> > +	int rc;
> > +	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
> > +			  FILESYSTEM__RELABELFROM, NULL);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM,
> > +			  FILESYSTEM__ASSOCIATE, NULL);
> > +	return rc;
> > +}

Not trying to bomb my own ack'd patch, but I do question why we don't
check RELABEL_TO for the new context we set either from rootcontext or
defcontext.  Wouldn't there be cases where we pass associate but
wouldn't want to allow relabel_to?  Does associate inherently mean that
we are allowed to relabel to that type?  I've been trying to think of a
way to exploit this for some usable purpose and admittedly I can't think
of one, but that doesn't mean that it isn't there...

on another note in may_context_mount_sb_relabel, when I set both
fscontext and context shouldn't we be checking the associate permission
between the context= (all files on the fs) and the context set to the sb
from fscontext?

should we check all 3 perms for all 4 context mount options?  My patch
doesn't change what we have today, but I'm not convinced they are
complete....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
