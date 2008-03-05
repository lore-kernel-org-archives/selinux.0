Date: Tue, 4 Mar 2008 16:10:13 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Quigley <dpquigl@tycho.nsa.gov>
Cc: Chris Wright <chrisw@sous-sol.org>, sds@tycho.nsa.gov, jmorris@namei.org,
        casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
	security context information.
Message-ID: <20080305001013.GF4416@sequoia.sous-sol.org>
References: <1204667623-16224-1-git-send-email-dpquigl@tycho.nsa.gov> <20080304232608.GD4416@sequoia.sous-sol.org> <1204672026.14520.133.camel@moss-terrapins.epoch.ncsc.mil> <20080304235225.GE4416@sequoia.sous-sol.org> <1204673709.14520.141.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204673709.14520.141.camel@moss-terrapins.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Dave Quigley (dpquigl@tycho.nsa.gov) wrote:
> 
> On Tue, 2008-03-04 at 15:52 -0800, Chris Wright wrote:
> > * Dave Quigley (dpquigl@tycho.nsa.gov) wrote:
> > > The reason for the differentiation is that NFS inodes don't need their
> > > on-disk representation set. Normally this would be taken care of with an
> > > inode_getsecurity call but as you noted Casey objected to a hook to get
> > > the suffix name. Also he did have a point in that the context may have
> > > several components to it that could have multiple suffixes. So I need a
> > > hook that allows us to set possibly multiple internal security values
> > > based on a security context and without using an xattr name.
> > 
> > Can you work on a couple things..first the fn name is not particularly
> > helpful ({get,set}context are just vague), and second, the SELinux
> > implementation is far too close to VFS code (you should not be manually
> > calling fsnotify, for example).  IOW, it looks more like a higher
> > level helper.
> 
> Is James' suggestion of getsecctx and setsecctx better or would you
> prefer another name?

Mainly capturing that it's doing this to a file not another object.

> The code for the selinux hook is taken from
> vfs_setxattr. The issue is that we are going to be doing some VFSish
> things in there. We are going to take a string and break it into zero or
> more xattr calls (in SELinux's case it is only one). I guess we could
> just set the xattr and then rely on the caller of this function to call
> fsnotify.

Yes, can we formalize this?  the xattr_security code could be cleaned
up if you need better helpers in VFS.

BTW, this is unnecessary after cut 'n paste:

+		rc = -EOPNOTSUPP;  <-- superfluous (and err works better for "if (!err)")
+		if (inode->i_op->setxattr) {
+			rc = inode->i_op->setxattr(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
...
+		} else {
+			rc = security_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx,


thanks,
-chris

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
