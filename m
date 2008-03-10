Subject: Re: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be
	called from the SELinux hook for inode_setsecctx.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>, Christoph Hellwig <hch@lst.de>,
        chrisw@sous-sol.org, jmorris@namei.org, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <265945.39014.qm@web36604.mail.mud.yahoo.com>
References: <265945.39014.qm@web36604.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 10 Mar 2008 08:37:50 -0400
Message-Id: <1205152670.23866.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-07 at 13:13 -0800, Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > 
> > On Fri, 2008-03-07 at 11:48 -0800, Casey Schaufler wrote:
> > > --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > 
> > > > 
> > > > ...
> > > > > So this is a way for filesystem code to pass information to an LSM
> > > > > without specifying semantics. Is there an expectation that
> > > > > inode_getsecctx return the value sent by inode_notifysecctx, or
> > > > > would you expect the "notify" secctx to be stored elsewhere?
> > > > 
> > > > The former (getsecctx should return the value sent by notifysecctx).
> > > > Not a separate value.
> > > 
> > > Now that took me by surprise.
> > > 
> > > I spent a good deal of time working with POSIX, so my perspective
> > > may be a bit twisted, but I looks to me that from an interface
> > > standpoint, inode_setsecctx and inode_notifysecctx are
> > > indistinguishable. How would the man pages for the two differ?
> > > Would you ever use both interfaces on the same inode?
> > > 
> > > Don't take this as me being contrary, I really want to understand
> > > how this makes for a better LSM, not just a bigger one.
> > 
> > I'll try again to explain, but everything below has been said previously
> > in this discussion.
> 
> Never hurts to review the bidding.
> 
> > inode_setsecctx:  Change the security context of an inode.  Updates the
> > incore security context managed by the security module and invokes the
> > fs code as needed (via __vfs_setxattr_noperm) to update any backing
> > xattrs that represent the context.  Example usage:  NFS server invokes
> > this hook to change the security context in its incore inode and on the
> > backing filesystem to a value provided by the client on a SETATTR
> > operation.
> > 
> > inode_notifysecctx:  Notify the security module of what the security
> > context of an inode should be.  Initializes the incore security context
> > managed by the security module for this inode.
> 
> I'm not convinced that building a mechanism into the LSM that
> prohibits one from maintaining secctx integrity is a good thing.
> I suppose an LSM that cares about such things can always refuse
> to go along with the inode_notifysecctx hook semantics. That
> will mean such an LSM couldn't support NFS. Oh well.

I don't understand how this prohibits one from maintaining secctx
integrity.  And you continue to respond in a non-constructive manner
that suggests you are more interested in arguing that in solving
problems.  If not, please demonstrate otherwise.

As I've already said, the NFS client code directly sets the i_uid in the
in-core inode from the fattr->uid supplied by the server to reflect the
state of the server's inode.  All we are doing here is providing a
mechanism for it to do likewise for the inode security context.  That is
what inode_notifysecctx() is about.  If you don't like the hook name,
feel free to suggest another one - I already asked for suggestions on
that too.

hch already indicated that he was ok with the basic idea,
http://marc.info/?l=linux-fsdevel&m=120481283810898&w=2

> 
> > Example usage:  NFS
> > client invokes this hook to initialize the security context in its
> > incore inode to the value provided by the server for the file when the
> > server returned the file's attributes to the client.
> >  
> > > > The other model I suppose would be something more along the lines of
> > > > David Howell's interfaces for creating a task security struct with a
> > > > particular value and then letting the caller set ->security directly.
> > > > In this case, it would be creating an inode security struct with a
> > > > particular value and then letting the fs code set inode->i_security
> > > > directly.  That seems non-optimal though for this situation (in David's
> > > > case, the setup of the task security struct happens once early on, and
> > > > then the swapping of the task security pointer happens later when
> > > > performing actions that shouldn't be treated as happening under the
> > > > current task's credentials). 
> > > 
> > > David has said, unless I'm remembering incorrectly again, that he
> > > would expect NFS to use his scheme. I would be happier with a single
> > > scheme than this pair. Which of the real/effective secctx values
> > > would be affected by each of these interfaces? Maybe the right
> > > thing is to have setsecctx hit the real and notifysecctx the
> > > effective. Maybe that's a dumb idea. I hope that the interactions
> > > between those schemes can be worked out before either gets adopted.
> > > If not, there's likely to be tears.
> > 
> > You're confusing the task security credentials with the inode security
> > context again.  David's work is only dealing with assuming different
> > task credentials than the current process.  Not managing the inode
> > security contexts.
> 
> Err, yeah. If I've got two task blobs and two ways to deal with
> inode blobs there are more ways to get it wrong than if there is
> only one way to deal with exactly one blob. I'm not confusing
> anything, I'm looking at the implications of all this complexity
> and, although some people don't seem to mind if the internals of
> Linux start to look like the spagetti factory kitchen on all you
> can eat night, I do.

No, you are confusing things - the fact that you suggested that the
inode_setsecctx would affect the real and inode_notifysecctx would
affect the effective shows that you are conflating the two ideas.  And
they are quite different.  David's work enables a kernel service to
assume a particular task context for a particular operation, such as
cachefiles assuming a different context than the current process when
accessing the cache, and nfsd assuming the context of the client process
when performing operations on its behalf.  These inode hooks enable the
server side to set the inode security context in a generic way (w/o
knowing what attribute or attributes or other mechanism may be used for
storage, as per your earlier request) and enable the client side to
update its incore inode security context to reflect the server's inode
state.

Please, be constructive and take the time to actually read what we have
written and to think about the code.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
