Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3BMGutA025458
	for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2005 18:16:56 -0400 (EDT)
Received: from cunningham.myip.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3BMAmWk013137
	for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2005 22:10:49 GMT
Subject: Re: getfattr works, but getfilecon doesn't
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1113235573.22198.31.camel@moss-spartans.epoch.ncsc.mil>
References: <1112999252.3261.5.camel@desktop.cunningham.myip.net.au>
	 <1113235573.22198.31.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1113257683.3645.1039.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Date: Tue, 12 Apr 2005 08:14:43 +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen.

On Tue, 2005-04-12 at 02:06, Stephen Smalley wrote:
> On Sat, 2005-04-09 at 08:27 +1000, Nigel Cunningham wrote:
> > Thanks for the responses to my email the other day.
> 
> Hmmm...did you get a response?  I think that the ramfs security xattr
> patches weren't upstreamed because there wasn't a real demand for them
> at the time, unlike the tmpfs security xattr support.

No - no response :>. I seem to have found so far that I don't appear to
need the ramfs seucrity patch. Just to give you a little more info, I'm
seeking to cross-compile SELinux for our (Cyclades) Alterpath Console
Server. It's a ppc_8xx based machine. I cross compiled the extended
attribute tools, and they are working fine - I can read and write
attributes on the mounted system. This includes attributes added to the
files while the fs is mounted ext2 loopback when the image is being
built. It seems, then, that I don't need the updated patch (although I
can provided it if necessary).

> > I've made further progress, such that I now know that the labels are
> > properly stored and accessible through the getfattr command, but not
> > through getfilecon.
> > 
> > I added printks to the kernel, and see them activated in the case of
> > getfattr, but not for getfilecon. The return code that getfilecon
> > received back from its getxattr call is -1.
> 
> And what errno?  What does an strace should in terms of the actual
> arguments passed to getxattr(2) by getfattr vs. getfilecon?  Different
> sized buffers?

Here's the output. (I have a few extra printfs in there from before I
cross compiled strace).

I have seen, talking with Russell last night, that my policy install
wasn't working quite right. I'm wondering now whether these issues will
go away once I get the install right. It looks to me at the moment like
the getfilecon is just not giving a helpful error from things it does as
side-effects, rather than that the xattr call itself is failing.
(Indeed, it must be this because the xattr call isn't even made!)

[root@CAS selinux]# strace getfilecon /var
execve("/usr/sbin/getfilecon", ["getfilecon", "/var"], [/* 17 vars */]) = 0
uname({sys="Linux", node="CAS", ...})   = 0
brk(0)                                  = 0x10012000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or directory)
open("/lib/libselinux.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0>\4"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=90588, ...}) = 0
mmap(0xffca000, 154832, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xffca000
mprotect(0xffdf000, 68816, PROT_NONE)   = 0
mmap(0xffea000, 24576, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0x10000) = 0xffea000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\316"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1397660, ...}) = 0
mmap(0xfe64000, 1398004, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfe64000
mprotect(0xffa2000, 95476, PROT_NONE)   = 0
mmap(0xffa4000, 77824, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0x130000) = 0xffa4000
mmap(0xffb7000, 9460, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffb7000
close(3)                                = 0
brk(0)                                  = 0x10012000
brk(0x10013000)                         = 0x10013000
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(4, 64), ...}) = 0
ioctl(1, TCGETS or TCGETS, {B9600 opost isig icanon echo ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x30017000
write(1, "libselinux::selinux_policyroot\n", 31libselinux::selinux_policyroot
) = 31
access("/etc/selinux/", F_OK)           = 0
open("/etc/selinux/config", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x30018000
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x30018000, 4096)                = 0
write(1, "libselinux::init_selinuxmnt\n", 28libselinux::init_selinuxmnt
) = 28
open("/proc/mounts", O_RDONLY|O_LARGEFILE) = 3
brk(0x10014000)                         = 0x10014000
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x30018000
read(3, "rootfs / rootfs rw 0 0\n/dev/root"..., 1024) = 170
close(3)                                = 0
munmap(0x30018000, 4096)                = 0
write(1, "Given path=/var, XATTR_NAME_SELI"..., 102Given path=/var, XATTR_NAME_SELINUX=security.selinux, buf=0x100122e8, size=255, getxattr returned -1.
) = 102
write(2, "getfilecon:  getfilecon(/var) fa"..., 37getfilecon:  getfilecon(/var) failed
) = 37
munmap(0x30017000, 4096)                = 0
exit(2)                                 = ?
[root@CAS selinux]#

Thanks!

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
