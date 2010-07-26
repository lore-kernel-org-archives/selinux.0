Subject: Re: fuse and selinux don't seem to work well together
From: Eric Paris <eparis@redhat.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: merlin <merlin@countercultured.net>, Eric Paris
 <eparis@parisplace.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "David P.
 Quigley" <dpquigl@tycho.nsa.gov>,
        SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTin-e33oxHUVJ2wX92YmQou-pN5MR8kKTG7LMZEM@mail.gmail.com>
References: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
	 <1279909967.8180.43.camel@moss-terrapins.epoch.ncsc.mil>
	 <AANLkTiniFb1LjDJQRoc7zOVgD0FVXi=gBaxjusP36RZ3@mail.gmail.com>
	 <1279913697.32473.8.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTi=CwucVcfRWN5Uk5=5HbVZRtuwVC6zW_w=_UEyH@mail.gmail.com>
	 <AANLkTimNxi1bOPQU1jrC6H--sCdX4Cm0PuNJZa4hNkwv@mail.gmail.com>
	 <4C4D0310.5040703@countercultured.net>
	 <AANLkTin16BrQyNYAfbU95=0c3_R9uzPqqiORDz-Nrvu8@mail.gmail.com>
	 <AANLkTin-e33oxHUVJ2wX92YmQou-pN5MR8kKTG7LMZEM@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Jul 2010 14:30:35 -0400
Message-ID: <1280169035.23427.43.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-07-26 at 13:13 -0500, Xavier Toth wrote:
> On Mon, Jul 26, 2010 at 8:44 AM, Xavier Toth <txtoth@gmail.com> wrote:
> > On Sun, Jul 25, 2010 at 10:37 PM, merlin <merlin@countercultured.net> wrote:

> >>> Fuse can deal with xattrs but only AFTER the fuse userspace program
> >>> believes the filesystem is mounted (and if the filesystem can handle
> >>> it).  My original patches didn't work, because I was calling getxattr
> >>> during the mount(2) syscall.  It gets even worse.  We had a 'bug' in
> >>> which the mount(8) program would call stat (or something like that) on
> >>> the root inode before it told the fuse userspace program the mount was
> >>> finished.  The audit system checked for file capabilities on the stat
> >>> call, which resulted in an xattr upcall, which resulted in a deadlock
> >>> because the fuse userspace wouldn't answer until the mount finished.
> >>> The 'fix' was to stop mount(8) from calling stat on fuse mounts.
> >>>
> >>> The 'right' solution (I think) is going to be 2 parts.  First we need
> >>> to get more information in the superblock mounting.  I seem to recall
> >>> that the only information we had was that it was 'fuse.'
> 
> After looking at this for awhile it seems to me that fuse_get_sb needs
> to call security_sb_set_mnt_opts get its superblock security structure
> initialized especially for the case when I used the fs_use_xattrs in
> policy.

For most FS (everything but NFS referrals and submounts as I recall)
this is supposed to get called via the

vfs_kern_mount -> security_sb_kern_mount -> selinux_sb_kern_mount ->
superblock_doinit -> selinux_set_mnt_opts

call chain.  If fuse isn't calling security_sb_kern_mount I'd have to
think something is wrong...

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
