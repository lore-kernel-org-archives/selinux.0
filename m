Subject: Re: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be
	called from the SELinux hook for inode_setsecctx.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>, Christoph Hellwig <hch@lst.de>,
        chrisw@sous-sol.org, jmorris@namei.org, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <421534.56373.qm@web36613.mail.mud.yahoo.com>
References: <421534.56373.qm@web36613.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 15:05:00 -0500
Message-Id: <1204920300.1397.554.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-07 at 11:48 -0800, Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > 
> > ...
> > > So this is a way for filesystem code to pass information to an LSM
> > > without specifying semantics. Is there an expectation that
> > > inode_getsecctx return the value sent by inode_notifysecctx, or
> > > would you expect the "notify" secctx to be stored elsewhere?
> > 
> > The former (getsecctx should return the value sent by notifysecctx).
> > Not a separate value.
> 
> Now that took me by surprise.
> 
> I spent a good deal of time working with POSIX, so my perspective
> may be a bit twisted, but I looks to me that from an interface
> standpoint, inode_setsecctx and inode_notifysecctx are
> indistinguishable. How would the man pages for the two differ?
> Would you ever use both interfaces on the same inode?
> 
> Don't take this as me being contrary, I really want to understand
> how this makes for a better LSM, not just a bigger one.

I'll try again to explain, but everything below has been said previously
in this discussion.

inode_setsecctx:  Change the security context of an inode.  Updates the
incore security context managed by the security module and invokes the
fs code as needed (via __vfs_setxattr_noperm) to update any backing
xattrs that represent the context.  Example usage:  NFS server invokes
this hook to change the security context in its incore inode and on the
backing filesystem to a value provided by the client on a SETATTR
operation.

inode_notifysecctx:  Notify the security module of what the security
context of an inode should be.  Initializes the incore security context
managed by the security module for this inode.  Example usage:  NFS
client invokes this hook to initialize the security context in its
incore inode to the value provided by the server for the file when the
server returned the file's attributes to the client.
 
> > The other model I suppose would be something more along the lines of
> > David Howell's interfaces for creating a task security struct with a
> > particular value and then letting the caller set ->security directly.
> > In this case, it would be creating an inode security struct with a
> > particular value and then letting the fs code set inode->i_security
> > directly.  That seems non-optimal though for this situation (in David's
> > case, the setup of the task security struct happens once early on, and
> > then the swapping of the task security pointer happens later when
> > performing actions that shouldn't be treated as happening under the
> > current task's credentials). 
> 
> David has said, unless I'm remembering incorrectly again, that he
> would expect NFS to use his scheme. I would be happier with a single
> scheme than this pair. Which of the real/effective secctx values
> would be affected by each of these interfaces? Maybe the right
> thing is to have setsecctx hit the real and notifysecctx the
> effective. Maybe that's a dumb idea. I hope that the interactions
> between those schemes can be worked out before either gets adopted.
> If not, there's likely to be tears.

You're confusing the task security credentials with the inode security
context again.  David's work is only dealing with assuming different
task credentials than the current process.  Not managing the inode
security contexts.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
