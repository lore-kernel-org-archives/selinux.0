Subject: Re: fuse and selinux don't seem to work well together
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTik=NrTj2exhqJt012hYrRUmTy7kjZ6cRH+-OHR4@mail.gmail.com>
References: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
	 <1279909967.8180.43.camel@moss-terrapins.epoch.ncsc.mil>
	 <AANLkTiniFb1LjDJQRoc7zOVgD0FVXi=gBaxjusP36RZ3@mail.gmail.com>
	 <1279913697.32473.8.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTi=CwucVcfRWN5Uk5=5HbVZRtuwVC6zW_w=_UEyH@mail.gmail.com>
	 <AANLkTimNxi1bOPQU1jrC6H--sCdX4Cm0PuNJZa4hNkwv@mail.gmail.com>
	 <AANLkTik=NrTj2exhqJt012hYrRUmTy7kjZ6cRH+-OHR4@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 26 Jul 2010 17:10:03 -0400
Message-Id: <1280178603.2673.37.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-07-26 at 16:15 -0500, Xavier Toth wrote:
> Pursuant to Steve's wishes to not require policy changes for new fuse
> filesystems that support xattrs:
> 
<Snip>
> >
> > The 'right' solution (I think) is going to be 2 parts.  First we need
> > to get more information in the superblock mounting.  I seem to recall
> > that the only information we had was that it was 'fuse.'  Not that is
> > was fuse mounting ntfs.
> 
> It appear that the superblock contains s_type->name and s_subtype
> which should tell you that it is for example an fuse.ntfs mount.

The is true but as my earlier email mentioned s_subtype isn't set when
we need it to be. This is set after the vfs_do_kern_mnt call (or whateve
it was called). get_fs_type will grab fuse from fuse.ntfs and
get_fs_subtype will grab the ntfs portion of the fstype.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
