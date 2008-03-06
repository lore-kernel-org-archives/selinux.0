Subject: Re: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be
	called from the SELinux hook for inode_setsecctx.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Christoph Hellwig <hch@lst.de>
Cc: casey@schaufler-ca.com, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20080306122703.GA4648@lst.de>
References: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1204743288-3461-2-git-send-email-dpquigl@tycho.nsa.gov>
	 <20080306122703.GA4648@lst.de>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 11:47:06 -0500
Message-Id: <1204822026.14520.193.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-03-06 at 13:27 +0100, Christoph Hellwig wrote:
> On Wed, Mar 05, 2008 at 01:54:47PM -0500, David P. Quigley wrote:
> > This factors out the part of the vfs_setxattr function that performs the
> > setting of the xattr and its notification. This is needed so the SELinux
> > implementation of inode_setsecctx can handle the setting of it's xattr while
> > maintaining the proper separation of layers.
> 
> Looks good, but I'm not entirely sure do_setxattr is a good name for
> this exported functionality.  __vfs_setxattr_noperm might be better.
> 
> Please also add a kerneldoc comment for each new global function.

Will do. I have to release a new patch set with the hook changed to take
a bool instead of a flag so you should see this updated sometime later
today.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
