Subject: Re: Configuring kernel module for labeling ...
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: jsingh@ensim.com
Cc: Russell Coker <russell@coker.com.au>, nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1099417545.12370.21.camel@jsingh>
References: <1099385154.11681.3.camel@jsingh>
	 <200411030323.16648.russell@coker.com.au>
	 <1099417545.12370.21.camel@jsingh>
Content-Type: text/plain
Message-Id: <1099420134.31739.250.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 13:28:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 12:45, Jaspreet Singh wrote:
> > Your problem is that the filesystem has type unlabeled_t.
> 
> How can i change that ???

I think you already handled that problem by defining a fs_use entry for
the filesystem type.

> One interesting thing was .. whenever i used to change xattrs of a
> directory of the underlying filesys directly using
> dentry->d_inode->i_op->setxattr the selinux used to refuse any
> type_transitions for any file creating in that changed directory.
> Although the xattrs of the dir used to be perfect.

Yes, this makes sense.  SELinux gets the xattr when the inode is
attached to a dentry, maps it to a SID, and caches that SID in the
incore inode.  Note that fs/xattr.c:setxattr() calls a
security_inode_post_setxattr() hook function upon successful setting of
the attribute to tell SELinux to update its incore inode SID as well. 
You need to do likewise.

> How can i check if the inode is exposing itself correctly or not ..
> given the fact .. everything appears to be fine with unconfined_t and
> problematic with httpd_t :-(

Possibly a permissions problem, e.g. if your stacked filesystem calls
VFS functions that internally trigger security hook calls, it may run
afoul of a SELinux permission check (which will be performed against the
current process context) and possibly denied to httpd_t while allowed to
unconfined_t, thereby preventing further progress in setting up the
state.

Also, stacked filesystems might be a problem in general, as SELinux is
initializing the inode security state upon d_instantiate.  Natural
question is when does it perform the d_instantiate upon the underlying
inode vs. the virtual one?  And when does it copy state like the mode
from the underlying inode to the virtual one?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
