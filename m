Subject: Re: fuse and selinux don't seem to work well together
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, Xavier Toth <txtoth@gmail.com>,
        SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1280193138.23427.111.camel@localhost>
References: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
	 <1279909967.8180.43.camel@moss-terrapins.epoch.ncsc.mil>
	 <AANLkTiniFb1LjDJQRoc7zOVgD0FVXi=gBaxjusP36RZ3@mail.gmail.com>
	 <1279913697.32473.8.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTi=CwucVcfRWN5Uk5=5HbVZRtuwVC6zW_w=_UEyH@mail.gmail.com>
	 <AANLkTimNxi1bOPQU1jrC6H--sCdX4Cm0PuNJZa4hNkwv@mail.gmail.com>
	 <4C4D0310.5040703@countercultured.net>
	 <AANLkTin16BrQyNYAfbU95=0c3_R9uzPqqiORDz-Nrvu8@mail.gmail.com>
	 <1280172135.2673.30.camel@moss-terrapins.epoch.ncsc.mil>
	 <AANLkTi=A=cSctYqD+5f_J55JZ-5+wrDmPf0fdnbkBVC9@mail.gmail.com>
	 <1280176276.2673.34.camel@moss-terrapins.epoch.ncsc.mil>
	 <1280179389.23427.83.camel@localhost>
	 <1280180443.2673.45.camel@moss-terrapins.epoch.ncsc.mil>
	 <1280193138.23427.111.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 08:43:27 -0400
Message-ID: <1280234607.4789.6.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-07-26 at 21:12 -0400, Eric Paris wrote:
> On Mon, 2010-07-26 at 17:40 -0400, David P. Quigley wrote:
> > <snip>
> > > 
> > > I'm not sure how the deadlock issues can be 'solved.'  The fuse people
> > > have repeatedly stated that until mount(8) (not even mount (2)) is
> > > finished it is illegal to call call getxattr() and they have every right
> > > to deadlock.  They will not budge on this position.
> > > 
> > > The only possibility I can think of is to extend fuse such that the
> > > support of xattrs is known during mount(2).   No idea what that would
> > > look like.
> > > 
> > > I believe that my autodetection patch is dead in the water with fuse as
> > > it stands today....
> > > 
> > > -Eric
> > 
> > So where is this dead locking occuring? The only thing kernel side that
> > I can think might deadlock is mount will probably lock the new super
> > block for writing (although it shouldn't be available yet so maybe not)
> > and when we call vfs_getxattr on the mount point it might need to grab a
> > lock on the sb for something. I don't think this is the case since I
> > looked through the code from vfs_getxattr through the fuse getxattr
> > handler and I don't see any locking in there for the SB. I'm more
> > inclined to believe that it is the userspace code for fuse or the
> > interface they use to send the requests to user space. Actually the
> > latter sounds more reasonable since fuse_send_request places the request
> > in a queue. So if we are waiting on mount to finish before we send the
> > getxattr request but mount depends on the getxattr request we can have a
> > problem. Maybe the mount request can be modified to make a nested
> > getxattr call on the file system to find out of it is supported and if
> > it is add something to indicate xattr support?
> 
> It's not an in kernel deadlock.  fuse userspace refuses to respond to
> anything until mount(8) is finished.  So if mount(8) at any point (even
> during mount(2)) is waiting on the fuse userspace to respond you are
> just stuck.

Then we can't support labeling with fuse filesystems.  Regardless of
whether you pass down the sub-fstype information.  Because to support
fs_use_xattr behavior, we have to be allowed to invoke ->getxattr on the
root inode as part of mount(2) so that we can set up the root inode's
security information before it is grafted into the namespace and
accessible to userspace.  That already happens for any fs_use_xattr
filesystem type; sb_finish_set_opts() first probes ->getxattr to make
sure that the fs truly supports security.selinux and later calls
inode_doinit* on the root inode and on any other inodes set up during
get_sb.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
