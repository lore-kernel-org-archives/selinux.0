Subject: Re: fuse and selinux don't seem to work well together
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Xavier Toth <txtoth@gmail.com>, Eric Paris <eparis@parisplace.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1280180148.23427.97.camel@localhost>
References: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
	 <1279909967.8180.43.camel@moss-terrapins.epoch.ncsc.mil>
	 <AANLkTiniFb1LjDJQRoc7zOVgD0FVXi=gBaxjusP36RZ3@mail.gmail.com>
	 <1279913697.32473.8.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTi=CwucVcfRWN5Uk5=5HbVZRtuwVC6zW_w=_UEyH@mail.gmail.com>
	 <AANLkTimNxi1bOPQU1jrC6H--sCdX4Cm0PuNJZa4hNkwv@mail.gmail.com>
	 <AANLkTik=NrTj2exhqJt012hYrRUmTy7kjZ6cRH+-OHR4@mail.gmail.com>
	 <1280180148.23427.97.camel@localhost>
Content-Type: text/plain
Date: Mon, 26 Jul 2010 18:29:31 -0400
Message-Id: <1280183371.2673.48.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-07-26 at 17:35 -0400, Eric Paris wrote:
> On Mon, 2010-07-26 at 16:15 -0500, Xavier Toth wrote:
> 
> > > Fuse can deal with xattrs but only AFTER the fuse userspace program
> > > believes the filesystem is mounted (and if the filesystem can handle
> > > it).  My original patches didn't work, because I was calling getxattr
> > > during the mount(2) syscall.  It gets even worse.  We had a 'bug' in
> > > which the mount(8) program would call stat (or something like that) on
> > > the root inode before it told the fuse userspace program the mount was
> > > finished.  The audit system checked for file capabilities on the stat
> > > call, which resulted in an xattr upcall, which resulted in a deadlock
> > > because the fuse userspace wouldn't answer until the mount finished.
> > > The 'fix' was to stop mount(8) from calling stat on fuse mounts.
> > 
> > So is this past tense, there was a bug in mount(8) that has been addressed?
> 
> That's correct.  mount(8) now has a --no-canonicalize option which fuse
> uses to make it not call stat before it completes to avoid the deadlock.
> 
> > > The 'right' solution (I think) is going to be 2 parts.  First we need
> > > to get more information in the superblock mounting.  I seem to recall
> > > that the only information we had was that it was 'fuse.'  Not that is
> > > was fuse mounting ntfs.
> > 
> > It appear that the superblock contains s_type->name and s_subtype
> > which should tell you that it is for example an fuse.ntfs mount.
> > 
> > > After that we need to fix the other bug you
> > > pointed out (and other bug I half worked on and you might be able to
> > > find the patch in the archives somewhere)
> > 
> > Sorry I'm not sure which bug you are referring to?
> > http://marc.info/?l=selinux&m=121379719014155&w=2 appears to be your
> > patch which I will look into applying.
> 
> I was thinkin of these:
> http://www.nsa.gov/research/selinux/list-archive/0805/26041.shtml
> 
> genfscon is not allowed in modules.  I stop looking when I realized that
> those don't really handle the mls portion of the label correctly...
> 
> 
> So sds wants to autodetect xattr support.  that sounds great, but I
> think is a large project that will require redesigning fuse.
> 
> I am suggesting a smaller interim solution that consists of 2 steps.
> 
> 1) get all the information about the name you need into the kernel in
> the right place.  aka s_type->name and s_subtype in the right hook.  I
> think David indicated that is going to take some kernel reworking to get
> s_subtype set at the appropriate time.
> 
> 2) add support to the policy to support filesystem labeling rules in
> modules.  I believe this is going to require the changes I was talking
> about in the above link.

If we go this route I think a new sub command for semanage would be a
good thing to have. This way you could change them on the fly if
necessary (although I'm not sure there is a use case for this). I think
it might be a good idea to bring the fuse guys back in on this
especially if we will be tinkering in their world.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
