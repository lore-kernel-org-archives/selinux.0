Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i44CGSRb011633
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 08:16:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i44CGQYW006762
	for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 12:16:26 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i44CGQBf006759 for <selinux@tycho.nsa.gov>; Tue, 4 May 2004 12:16:26 GMT
Subject: Re: [PATCH][SELINUX] Re-open descriptors closed on exec by SELinux
	to /dev/null
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
   selinux@tycho.nsa.gov,
   Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040503144130.42ba1fda.akpm@osdl.org>
References: <1083603014.7446.197.camel@moss-spartans.epoch.ncsc.mil>
	 <20040503144130.42ba1fda.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1083672952.19086.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 04 May 2004 08:15:52 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-05-03 at 17:41, Andrew Morton wrote:
> Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> >
> > +/* Create an open file that refers to the null device.
> > +   Derived from the OpenWall LSM. */
> > +struct file *open_devnull(void) 
> > +{
> > +	struct inode *inode;
> > +	struct dentry *dentry;
> > +	struct file *file = NULL;
> > +	struct inode_security_struct *isec;
> > +	dev_t dev;
> > +
> > +	inode = new_inode(current->fs->rootmnt->mnt_sb);
> > +	if (!inode)
> > +		goto out;
> > +
> > +	dentry = dget(d_alloc_root(inode));
> > +	if (!dentry)
> > +		goto out_iput;
> > +
> > +	file = get_empty_filp();
> > +	if (!file)
> > +		goto out_dput;
> > +
> > +	dev = MKDEV(MEM_MAJOR, 3); /* null device */
> > +
> > +	inode->i_uid = current->fsuid;
> > +	inode->i_gid = current->fsgid;
> > +	inode->i_blksize = PAGE_SIZE;
> > +	inode->i_blocks = 0;
> > +	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
> > +	inode->i_state = I_DIRTY; /* so that mark_inode_dirty won't touch us */
> > +
> > +	isec = inode->i_security;
> > +	isec->sid = SECINITSID_DEVNULL;
> > +	isec->sclass = SECCLASS_CHR_FILE;
> > +	isec->initialized = 1;
> > +
> > +	file->f_flags = O_RDWR;
> > +	file->f_mode = FMODE_READ | FMODE_WRITE;
> > +	file->f_dentry = dentry;
> > +	file->f_vfsmnt = mntget(current->fs->rootmnt);
> > +	file->f_pos = 0;
> > +
> > +	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, dev);
> > +	if (inode->i_fop->open(inode, file))
> > +		goto out_fput;
> > +
> > +out:
> > +	return file;
> > +out_fput:
> > +	mntput(file->f_vfsmnt);
> > +	put_filp(file);
> > +out_dput:	
> > +	dput(dentry);
> > +out_iput:	
> > +	iput(inode);
> > +	file = NULL;
> > +	goto out;
> > +}
> 
> That seems to be a heck of a lot of code to get a file* which refers to
> /dev/null.  I guess calling flip_open("/dev/null") is a bit grubby, but are
> you sure there's no simpler way?

Not that I know of.  Perhaps Al has a suggestion?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
