Date: Fri, 7 Mar 2008 12:28:54 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Dave Quigley <dpquigl@tycho.nsa.gov>,
        Christoph Hellwig <hch@lst.de>, chrisw@sous-sol.org, jmorris@namei.org,
        viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be
	called from the SELinux hook for inode_setsecctx.
Message-ID: <20080307202854.GX4416@sequoia.sous-sol.org>
References: <1204917436.1397.519.camel@moss-spartans.epoch.ncsc.mil> <421534.56373.qm@web36613.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <421534.56373.qm@web36613.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Casey Schaufler (casey@schaufler-ca.com) wrote:
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

Assuming a simple model (no time of day magic or composite labels) they
differ by calling ->setxattr so that the fs actually puts bit on persitent
storage (may not be disk for ram backed fs).  The callers are from the
kernel (you don't have to worry about that) and the implementation is
simply update your blob or update your blob and tell fs to update as well.

thanks,
-chris

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
