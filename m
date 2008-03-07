Subject: Re: [PATCH 2/2] LSM/SELinux: inode_{get,set}secctx hooks to access
	LSM security context information.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@lst.de, sds@tycho.nsa.gov, jmorris@namei.org, hch@infradead.org,
        casey@schaufler-ca.com, chrisw@sous-sol.org, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <E1JXj6y-000241-IP@pomaz-ex.szeredi.hu>
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
	 <1204911010.14520.287.camel@moss-terrapins.epoch.ncsc.mil>
	 <E1JXj6y-000241-IP@pomaz-ex.szeredi.hu>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 16:07:59 -0500
Message-Id: <1204924079.14520.319.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-07 at 21:24 +0100, Miklos Szeredi wrote:
> > This isn't hiding information from the lower layers. The only use of the
> > dentry is much higher up in the call chain. If you take a look at
> > sys_chmod (another inode attr modifying call) the dentry is really only
> > used in
> > 
> > sys_chmod->chown_common->notify_change->fsnotify_change
> 
> And i_op->setattr().

Which is in the same boat as setxattr since most filesystems just grab
the inode from the dentry that is passed in (although I didn't look as
extensively as I did with setxattr). This is another example of
needlessly passing a dentry where an inode is sufficient and correct. So
once again the only real purpose for the dentry to be there is
fsnotify_change. 

I also don't see a reason for getattr to take a vfsmount and a dentry.
Even fuse_getattr does nothing with the vfsmount and only pulls the
inode from the dentry to pass into fuse_do_getattr(which takes an
inode). The libfs code for simple_getattr does nothing with them as
well. Can anyone cite a real use for all of this? It seems that the
pervasiveness of dentries in all the file system code isn't justified.
Note I haven't looked through every file system (yet) but from what I've
seen there are no real users of these dentries except for CIFS.

> 
> > 
> > The operations that actually change the inode metadata on disk do not
> > touch the dentry at all except to get the inode(rightly so since it is
> > an INODE operation). 
> 
> "Disk" and "inode" are concepts specific to a certain class of
> filesystems, but make no sense for a different set.  What makes sense
> for all filesystems is the hierarchy of path components, which is what
> dentries represent.


Would you care to elaborate? Perhaps an example in tree (or out). Path
names are nothing but a user friendly way of telling the file system
which inode you want. I've even had someone ask me once if they could
just open a file by inode.

> 
> Miklos


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
