Subject: Re: [PATCH 2/2] LSM/SELinux: inode_{get,set}secctx hooks to access
	LSM security context information.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christoph Hellwig <hch@lst.de>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, casey@schaufler-ca.com,
        chrisw@sous-sol.org, jmorris@namei.org, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20080306123013.GB4648@lst.de>
References: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1204743288-3461-3-git-send-email-dpquigl@tycho.nsa.gov>
	 <20080306123013.GB4648@lst.de>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 08:50:22 -0500
Message-Id: <1204811422.1397.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-03-06 at 13:30 +0100, Christoph Hellwig wrote:
> On Wed, Mar 05, 2008 at 01:54:48PM -0500, David P. Quigley wrote:
> > This patch introduces two new hooks. One to get all relevant information from
> > an LSM about an inode an the second given that context to set it on the
> > inode. The setcontext call takes a flag to indicate if it should set the incore
> > representation, the ondisk representation or both. This hook is for use in the
> > labeled NFS code and addresses concerns of how to set security on an inode in a
> > multi-xattr LSM.
> 
> I don't quite understand the rationale of the incore vs ondisk flag.
> Why are these separate?

In-core only:  NFS client gets the file security context for an inode
from the server and needs to set the in-core security context for its
inode accordingly.  But it does not want to call back to i_op->setxattr
and try to _set_ the context on the server when it does this.  So it
only calls with the incore flag.

On-disk:  NFS server receives a file security context to set on a file
from the client, and wants to update both the in-core security context
for the inode and the on-disk xattr.  So it calls with the ondisk flag.

It actually only requires a boolean flag.  

> > +	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen, int flags);
> > +	int (*inode_getsecctx)(struct dentry *dentry, void **ctx, u32 *ctxlen);
> 
> The dentry in here seems odd given the inode name.   Given that we're
> talking about per-inode security labels here an struct inode * would
> make more sense to me.

We'd agree, but unfortunately the i_op->setxattr and ->getxattr methods
take a dentry as input even though the fs code immediately turns around
and extracts the inode from it.  Not sure why that is or whether it can
be changed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
