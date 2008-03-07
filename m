Subject: Re: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be
	called from the SELinux hook for inode_setsecctx.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>, Christoph Hellwig <hch@lst.de>,
        chrisw@sous-sol.org, jmorris@namei.org, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <233981.53031.qm@web36601.mail.mud.yahoo.com>
References: <233981.53031.qm@web36601.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 14:17:16 -0500
Message-Id: <1204917436.1397.519.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-07 at 10:49 -0800, Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > 
> > On Fri, 2008-03-07 at 10:14 -0800, Casey Schaufler wrote:
> > > --- Dave Quigley <dpquigl@tycho.nsa.gov> wrote:
> > > 
> > > > For some odd reason I can't quite parse the first two parts
> > > 
> > > Let me try a different angle on the question. Maybe it just
> > > doesn't come up as a real issue, and I'm concerned about nothing.
> > > 
> > > Just for grins lets say I wanted to set the secctx on a directory
> > > in a derivative of ramfs in some unspecified way that is not
> > > related to mkdir. There are no on-disk inodes. Should the code call
> > > inode_setsecctx, inode_notifysecctx, or both? It seems rational to
> > > me to call inode_setsecctx, but since the differentiation between
> > > the interfaces is the "on disk" factor and ramfs only exists as
> > > in core, it would seem that inode_notifysecctx would be correct.
> > 
> > If you are setting (changing) the value, then use inode_setsecctx (or
> > the existing inode_setsecurity, which is used by the xattr code, but
> > that is limited to setting a single xattr value by name).
> 
> So any code that wants to explicitly set the secctx (as opposed to a
> specific attribute value) calls inode_setsecctx. This makes perfect
> sense.
> 
> > If you are just notifying the security module of a value that should be
> > associated with the inode, use inode_notifysecctx.
> 
> So this is a way for filesystem code to pass information to an LSM
> without specifying semantics. Is there an expectation that
> inode_getsecctx return the value sent by inode_notifysecctx, or
> would you expect the "notify" secctx to be stored elsewhere?

The former (getsecctx should return the value sent by notifysecctx).
Not a separate value.

The other model I suppose would be something more along the lines of
David Howell's interfaces for creating a task security struct with a
particular value and then letting the caller set ->security directly.
In this case, it would be creating an inode security struct with a
particular value and then letting the fs code set inode->i_security
directly.  That seems non-optimal though for this situation (in David's
case, the setup of the task security struct happens once early on, and
then the swapping of the task security pointer happens later when
performing actions that shouldn't be treated as happening under the
current task's credentials). 

> > Reasonable?
> 
> I think that the theory is fine, but I forsee implementation
> complications if the details of what is expected of an LSM aren't
> clear. At this point I'm not objecting to the interface so much as
> hoping to be able to use it properly, even with my limited and
> deteriorating mental facilties.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
