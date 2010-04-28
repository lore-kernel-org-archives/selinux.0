Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SG4KCW019944
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 12:04:20 -0400
Received: from atoll.udmvt.ru (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3SG3jOU018742
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 16:03:45 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id o3SG4FdK019551
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 20:04:17 +0400 (GMT-4)
	(envelope-from spg@udmvt.ru)
Date: Wed, 28 Apr 2010 20:04:13 +0400
From: selinux@udmvt.ru
To: selinux@tycho.nsa.gov
Subject: System console hangs on boot in enforced unless some permissions
	added (with 2.6.32-3).
Message-ID: <20100428160413.GN25652@ruber.office.udmvt.ru>
References: <20100228223834.GE3990@myhost.felk.cvut.cz> <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil> <20100301165602.GH3990@myhost.felk.cvut.cz> <1267463356.601.26.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1267463356.601.26.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 01, 2010 at 12:09:16PM -0500, Stephen Smalley wrote:
> On Mon, 2010-03-01 at 17:56 +0100, Michal Svoboda wrote:
> > Stephen Smalley wrote:
> > > On file creation, there is an associate check between the security
> > > context of the file and the security context of the containing
> > > filesystem.  
> > 
> > Is there anything I could read up to understand this mechanism?
> 
> The particular permission checks for operations were described in:
> http://www.nsa.gov/research/_files/selinux/papers/slinux-abs.shtml
> and
> http://www.nsa.gov/research/_files/selinux/papers/module-abs.shtml
> 
> There is also a wiki page with information on classes and permissions,
> http://www.selinuxproject.org/page/ObjectClassesPerms
> 
> > > In your particular case though the real issue is that you
> > > have an unlabeled filesystem type that needs a genfscon or fs_use rule
> > > added to your policy.   Look for a log message that says something along
> > > the lines of:
> > > SELinux:  initialized (dev ..., type ...), not configured for labeling
> > 
> > [    2.780406] SELinux: initialized (dev devtmpfs, type devtmpfs), not
> > configured for labeling
> > 
> > I think this is the new kernel-make dev filesystem that appears in .32
> > or so. So I need to recompile the base module to use transition SIDs,
> > like on normal tmpfs, right?
> 
> Yes.  Looks like Fedora policy has:
> fs_use_trans devtmpfs gen_context(system_u:object_r:tmpfs_t,s0);
Heh, and now the Debian/testing selinux-policy-default have the same.

But.
Is it only me unable to run Debian's 2.6.32-3 kernel with SELinux in enforced mode,
or is anyone else's system blocked by the devtmpfs compiled into the kernel? :)

Look, I have these strange messages in permissive mode:
	type=AVC msg=audit(1272355319.117:102): avc:  denied  { search } for  pid=1668 comm="getty" name="/" dev=devtmpfs ino=4 scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
	type=AVC msg=audit(1272355319.117:102): avc:  denied  { write } for  pid=1668 comm="getty" name="/" dev=devtmpfs ino=4 scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
	type=AVC msg=audit(1272355319.117:102): avc:  denied  { add_name } for  pid=1668 comm="getty" name="vcs2" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
	type=AVC msg=audit(1272355319.117:102): avc:  denied  { create } for  pid=1668 comm="getty" name="vcs2" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=chr_file
and I have a totally freezed console (while network services running, for ex. ssh),
unable to switch VTs and scroll them, not even numlock is switching.
And I know that getty does not run in kernel_t and never supposed to mknod anything.
And if I boot in single-user, that boots okay, but if I ever try to "echo > /dev/tty2",
I immediately have my console freezed in the same manner when in enforced mode,
but get the same AVCs in permissive, but with comm="bash", but hey, bash does not have
the code for creating a special file "vcs2", doesn't it?

Note in the AVCs: dev=devtmpfs, but I have no one in /proc/mounts,
also ino=4, but I scanned all filesystems (while in single-user mode,
just after receiving these messages), there is no inode=4 with tmpfs_t type.
So it was very hard to figure out, what is happening, I am not quite a
current kernel expert.

So, is it true, that someone (in debian?) turned the devtmpfs on in 2.6.32-3 and now
that filesystem exists even when not mounted, and even worse, it's operations
are executed on behalf of current process, but within the kernel_t domain?
And kernel_t should not create device nodes in tmpfs_t directories, right?
And finally, all that together just breaks the system bootup process in an
almost untraceable manner?

It seems, that being denied to search tmpfs_t and create nodes there,
the kernel just loses some locks locked (I believe), but then it looks like a kernel bug,
not a SELinux fault.

But, as you may guess, adding the rules
  allow kernel_t { tmpfs_t device_node }:{ chr_file blk_file lnk_file } create;
  allow kernel_t tmpfs_t:dir { search write add_name create };
allows the system to boot just fine. But is it a proper solution?

So, after all, now with my "fix" just everyone with mount privilege can do
 # mount -t devtmpfs blablabla-no-device-is-needed /mountpoint
to get directory full of device nodes with NO proper labelling?
Sometime in the past I had set up environments with "limited root"
so now I am concerned about that, there were mount privileges
(for /dev/pts and /proc as I recall).

Well, I'm afraid, that I am misunderstanding the situation,
so things are not so bad (but hey, it took me 3 days to make the system bootable),
so please, respond, anyone who have tried debian's 2.6.32-3 kernel
with selinux-policy-default/testing. I do personally use debian/testing
with selinux-policy-default 2:0.2.20091117-2.
Please, suggest any your solution or suggestion or just experience (positive or negative).

And does anyone have any suggestions for proper further reaction?
(I believe, that all caused by a bad code design quality or somewhat like that,
but perhaps some of you may argue pro or contra.)

Thanks for your time.

-- 
Alexey S.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
