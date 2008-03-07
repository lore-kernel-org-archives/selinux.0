Subject: Re: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be
	called from the SELinux hook for inode_setsecctx.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>, Christoph Hellwig <hch@lst.de>,
        chrisw@sous-sol.org, jmorris@namei.org, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <520476.89184.qm@web36601.mail.mud.yahoo.com>
References: <520476.89184.qm@web36601.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 13:17:33 -0500
Message-Id: <1204913853.1397.490.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-07 at 10:14 -0800, Casey Schaufler wrote:
> --- Dave Quigley <dpquigl@tycho.nsa.gov> wrote:
> 
> > For some odd reason I can't quite parse the first two parts
> 
> Let me try a different angle on the question. Maybe it just
> doesn't come up as a real issue, and I'm concerned about nothing.
> 
> Just for grins lets say I wanted to set the secctx on a directory
> in a derivative of ramfs in some unspecified way that is not
> related to mkdir. There are no on-disk inodes. Should the code call
> inode_setsecctx, inode_notifysecctx, or both? It seems rational to
> me to call inode_setsecctx, but since the differentiation between
> the interfaces is the "on disk" factor and ramfs only exists as
> in core, it would seem that inode_notifysecctx would be correct.

If you are setting (changing) the value, then use inode_setsecctx (or
the existing inode_setsecurity, which is used by the xattr code, but
that is limited to setting a single xattr value by name).

If you are just notifying the security module of a value that should be
associated with the inode, use inode_notifysecctx.

Reasonable?

> 
> Like I say, maybe it never comes up, but having these two very
> similar interfaces (or the old flag) begs the question of when
> to use each for things other than their original purpose. I think
> we'll live in a better LSM if it's clear.
> 
> > of your
> > email but to answer your question about it being an NFS only hook. As of
> > right now the only user is going to be NFS however any remote filesystem
> > (labeled CIFS anyone?) will potentially have this problem. Also even
> > though we don't have one today if there ever were an LSM that used
> > multiple xattrs for their security attributes this is a useful interface
> > to them. So there are many uses for this hook but currently the only one
> > is NFS.
> 
> Ok then, no worries.
> 
> Thank you
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
