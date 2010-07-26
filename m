Subject: Re: fuse and selinux don't seem to work well together
From: Eric Paris <eparis@redhat.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley
 <sds@tycho.nsa.gov>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>,
        SELinux
 <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTik=NrTj2exhqJt012hYrRUmTy7kjZ6cRH+-OHR4@mail.gmail.com>
References: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
	 <1279909967.8180.43.camel@moss-terrapins.epoch.ncsc.mil>
	 <AANLkTiniFb1LjDJQRoc7zOVgD0FVXi=gBaxjusP36RZ3@mail.gmail.com>
	 <1279913697.32473.8.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTi=CwucVcfRWN5Uk5=5HbVZRtuwVC6zW_w=_UEyH@mail.gmail.com>
	 <AANLkTimNxi1bOPQU1jrC6H--sCdX4Cm0PuNJZa4hNkwv@mail.gmail.com>
	 <AANLkTik=NrTj2exhqJt012hYrRUmTy7kjZ6cRH+-OHR4@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Jul 2010 17:35:48 -0400
Message-ID: <1280180148.23427.97.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-07-26 at 16:15 -0500, Xavier Toth wrote:

> > Fuse can deal with xattrs but only AFTER the fuse userspace program
> > believes the filesystem is mounted (and if the filesystem can handle
> > it).  My original patches didn't work, because I was calling getxattr
> > during the mount(2) syscall.  It gets even worse.  We had a 'bug' in
> > which the mount(8) program would call stat (or something like that) on
> > the root inode before it told the fuse userspace program the mount was
> > finished.  The audit system checked for file capabilities on the stat
> > call, which resulted in an xattr upcall, which resulted in a deadlock
> > because the fuse userspace wouldn't answer until the mount finished.
> > The 'fix' was to stop mount(8) from calling stat on fuse mounts.
> 
> So is this past tense, there was a bug in mount(8) that has been addressed?

That's correct.  mount(8) now has a --no-canonicalize option which fuse
uses to make it not call stat before it completes to avoid the deadlock.

> > The 'right' solution (I think) is going to be 2 parts.  First we need
> > to get more information in the superblock mounting.  I seem to recall
> > that the only information we had was that it was 'fuse.'  Not that is
> > was fuse mounting ntfs.
> 
> It appear that the superblock contains s_type->name and s_subtype
> which should tell you that it is for example an fuse.ntfs mount.
> 
> > After that we need to fix the other bug you
> > pointed out (and other bug I half worked on and you might be able to
> > find the patch in the archives somewhere)
> 
> Sorry I'm not sure which bug you are referring to?
> http://marc.info/?l=selinux&m=121379719014155&w=2 appears to be your
> patch which I will look into applying.

I was thinkin of these:
http://www.nsa.gov/research/selinux/list-archive/0805/26041.shtml

genfscon is not allowed in modules.  I stop looking when I realized that
those don't really handle the mls portion of the label correctly...


So sds wants to autodetect xattr support.  that sounds great, but I
think is a large project that will require redesigning fuse.

I am suggesting a smaller interim solution that consists of 2 steps.

1) get all the information about the name you need into the kernel in
the right place.  aka s_type->name and s_subtype in the right hook.  I
think David indicated that is going to take some kernel reworking to get
s_subtype set at the appropriate time.

2) add support to the policy to support filesystem labeling rules in
modules.  I believe this is going to require the changes I was talking
about in the above link.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
