Subject: Re: [PATCH 2/2] LSM/SELinux: inode_{get,set}secctx hooks to access
	LSM security context information.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, "David P. Quigley" <dpquigl@tycho.nsa.gov>,
        casey@schaufler-ca.com, chrisw@sous-sol.org, jmorris@namei.org,
        viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20080306135444.GA5216@infradead.org>
References: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1204743288-3461-3-git-send-email-dpquigl@tycho.nsa.gov>
	 <20080306123013.GB4648@lst.de>
	 <1204811422.1397.205.camel@moss-spartans.epoch.ncsc.mil>
	 <20080306135444.GA5216@infradead.org>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 09:05:04 -0500
Message-Id: <1204812304.1397.213.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-03-06 at 08:54 -0500, Christoph Hellwig wrote:
> On Thu, Mar 06, 2008 at 08:50:22AM -0500, Stephen Smalley wrote:
> > In-core only:  NFS client gets the file security context for an inode
> > from the server and needs to set the in-core security context for its
> > inode accordingly.  But it does not want to call back to i_op->setxattr
> > and try to _set_ the context on the server when it does this.  So it
> > only calls with the incore flag.
> > 
> > On-disk:  NFS server receives a file security context to set on a file
> > from the client, and wants to update both the in-core security context
> > for the inode and the on-disk xattr.  So it calls with the ondisk flag.
> > 
> > It actually only requires a boolean flag.  
> 
> Yes, the boolean might be better.
> 
> I still don't quite understand why we would only set the security
> context in-core only as this looks like a potential loss of metadata
> updates for me.

It isn't truly changing the security context - it is notifying the
security module on the client side of the security context provided by
the server for a given inode.  In the case of uids, the nfs client code
can directly set the inode->i_uid to the server-provided value from the
fattr, but for the inode->i_security, the nfs client code has to call
into the security module to set it in-core.

Maybe they should be different hooks altogether - just not sure what to
call the incore case.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
