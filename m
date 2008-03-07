Subject: Re: [PATCH 2/2] LSM/SELinux: inode_{get,set}secctx hooks to access
	LSM security context information.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@lst.de, sds@tycho.nsa.gov, jmorris@namei.org, hch@infradead.org,
        casey@schaufler-ca.com, chrisw@sous-sol.org, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <E1JXfpu-0001d1-57@pomaz-ex.szeredi.hu>
References: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1204743288-3461-3-git-send-email-dpquigl@tycho.nsa.gov>
	 <20080306123013.GB4648@lst.de>
	 <1204811422.1397.205.camel@moss-spartans.epoch.ncsc.mil>
	 <20080306135444.GA5216@infradead.org>
	 <1204812304.1397.213.camel@moss-spartans.epoch.ncsc.mil>
	 <20080306140713.GA20087@infradead.org>
	 <Xine.LNX.4.64.0803070124160.2139@us.intercode.com.au>
	 <1204814886.1397.244.camel@moss-spartans.epoch.ncsc.mil>
	 <1204823638.14520.202.camel@moss-terrapins.epoch.ncsc.mil>
	 <20080307100353.GA16831@lst.de>
	 <1204906016.14520.268.camel@moss-terrapins.epoch.ncsc.mil>
	 <E1JXfpu-0001d1-57@pomaz-ex.szeredi.hu>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 12:30:10 -0500
Message-Id: <1204911010.14520.287.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-07 at 17:54 +0100, Miklos Szeredi wrote:
> > So I have converted all the xattr internals over to an inode from a
> > dentry but there is one issue with that. To set EAs on CIFS they need a
> > full path for the file. I don't think we can reconcile using inodes in
> > the vfs operation with CIFS needing a path. If you have a suggestion on
> > how to handle this I'm more than willing to listen. Everything else
> > however seems to be a trivial change.
> 
> Since there are no hardlinks in CIFS (or are there?) it coukld get the
> dentry back with d_find_alias().
> 
> But what's the point?  Why is it better to pass the inode, rather than
> dentry down to the filesystem?
> 
> Hiding info from lower layers is not generally a good idea if there
> are valid uses for it.  I don't buy Chritoph's argument, that
> filesystems working with paths instead of inodes are inherently
> broken.
> 
> Miklos

This isn't hiding information from the lower layers. The only use of the
dentry is much higher up in the call chain. If you take a look at
sys_chmod (another inode attr modifying call) the dentry is really only
used in

sys_chmod->chown_common->notify_change->fsnotify_change

The operations that actually change the inode metadata on disk do not
touch the dentry at all except to get the inode(rightly so since it is
an INODE operation). 

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
