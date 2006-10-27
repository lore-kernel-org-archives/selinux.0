Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: aviro@redhat.com, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        chrisw@sous-sol.org, jmorris@namei.org
In-Reply-To: <5506.1161966323@redhat.com>
References: <1161965410.1306.47.camel@moss-spartans.epoch.ncsc.mil>
	 <1161960520.16681.380.camel@moss-spartans.epoch.ncsc.mil>
	 <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil>
	 <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil>
	 <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil>
	 <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <8567.1161859255@redhat.com>
	 <22702.1161878644@redhat.com> <24017.1161882574@redhat.com>
	 <2340.1161903200@redhat.com> <4786.1161963766@redhat.com>
	 <5506.1161966323@redhat.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 13:09:02 -0400
Message-Id: <1161968942.1306.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 17:25 +0100, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > > I was also wondering if I could generalise it to handle all cache types,
> > > but the permissions checks are probably going to be quite different for
> > > each type.  For instance, CacheFiles uses files on a mounted fs, whilst
> > > CacheFS uses a block device.
> > 
> > So in the latter case, the daemon supplies the path of a block device
> > node?
> 
> No.  In the latter case, there is no userspace daemon.  As there are no
> dentries, filenames and paths in CacheFS, keeping track of the cull table
> consumes a less space than for CacheFiles.
> 
> You start the cache by mounting it:
> 
> 	mount -t cachefs /dev/hdx9 /cachefs
> 
> Then it's online.  However, you might want to check that whoever's calling
> mount has permission to bring a cache online...

Hmmm...that raises a separate issue - how does SELinux label cachefs
inodes?  Does cachefs support xattrs?  Other option is to use a mount
context (mount -o context=...) to apply a single context to all inodes
within it.  Where exactly is the cachefs code available?

I'm also unclear on where you establish the binding between the files
being cached and the cache.  What specifies that e.g. a given NFS mount
should be backed to a given cache?  We need to be able to control that
relationship too, to establish that the cache is being protected
adequately for the source data.

> Actually, I think the permission to bring a cache online applies in all cases,
> and is probably separate from checking that CacheFiles(d) is permitted to
> mangle the filesystem it's using for a cache.  With CacheFS, we could do the
> equivalent and do a MAC check to make sure we're permitted to read and write
> the blockdev, as you suggest in the next bit:
> 
> > I suppose the hook could internally check the type of inode to decide what
> > checks to apply, using the checks I previously sketched when it is a
> > directory and using a different set of checks for the block device
> > (substituting a write check against the block device for the
> > directory-specific checks).  The hook interface itself would look the same
> > IIUC, i.e. providing the (mnt, dentry) pair to which the path resolved and
> > the secid to which the context resolved.
> 
> So, to summarise, is it worth having two checks:
> 
>  (1) Permission to bring a cache online or to take a cache offline.

At present, this will show up as the usual checking on mount (security
hooks in do_mount and vfs_kern_mount) and on umount (security hook in
do_umount) by SELinux.  I'm not sure whether you need anything specific
to the cache.

>  (2) Permission for the process bringing the cache online (cachefilesd or
>      mount) to access the backing store, be it a set of files and directories,
>      or be it a blockdev.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
