From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: libGL.so.1
Date: Mon, 25 Oct 2010 07:45:30 +1100
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <201007182309.58829.russell@coker.com.au> <1279735507.20469.16.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1279735507.20469.16.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201010250745.30975.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Jul 2010, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > # ksmserver 
> > ksmserver: error while loading shared libraries: libGL.so.1: failed to
> > map  segment from shared object: Permission denied
> >
> > 
> >
> > It seems that problems with libGL.so.1 have been around for a while, are
> > these  solvable without a huge amount of coding?
> 
> Fedora has been carrying a patch to mesa to ensure that libGL.so isn't
> marked with an executable stack for a long time, and I think the patch
> has gone upstream in modern versions of mesa.
> 
> $ execstack -q /usr/lib64/libGL.so.1
> - /usr/lib64/libGL.so.1

xorg-x11-6.8.0-redhat-libGL-exec-shield-fixes.patch

I've been working on this one again.  Fedora has the above patch and the 
recent upstream Mesa as the following ./configure option:
--enable-selinux        Build SELinux-aware Mesa [default=disabled]

Building the SE Linux aware version doesn't seem to make any difference in my 
tests.  I still get the following failure:

# mplayer 
mplayer: error while loading shared libraries: libGL.so.1: failed to map 
segment from shared object: Permission denied
type=AVC msg=audit(1287952965.121:53): avc:  denied  { execmem } for  
pid=28415 comm="mplayer" scontext=unconfined_u:unconfined_r:unconfined_t:s0-
s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
tclass=process
type=SYSCALL msg=audit(1287952965.121:53): arch=40000003 syscall=192 
success=no exit=-13 a0=f7591000 a1=9000 a2=7 a3=812 items=0 ppid=1242 
pid=28415 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 
fsgid=0 tty=pts1 ses=4294967295 comm="mplayer" exe="/usr/bin/mplayer" 
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)

strace shows the following:

open("/usr/lib/libGL.so.1", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@6\1\0004\0\0\0"..., 
512) = 512
lseek(3, 365308, SEEK_SET)              = 365308
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\4\0\0\0\24\0\0\0", 32) 
= 32
fstat64(3, {st_mode=S_IFREG|0644, st_size=401496, ...}) = 0
mmap2(NULL, 410432, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 
0xf74db000
mmap2(0xf7535000, 36864, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|
MAP_FIXED|MAP_DENYWRITE, 3, 0x59) = -1 EACCES (Permission denied)
close(3)                                = 0
writev(2, [{"mplayer", 7}, {": ", 2}, {"error while loading shared libra"..., 
36}, {": ", 2}, {"libGL.so.1", 10}, {": ", 2}, {"failed to map segment from 
share"..., 40}, {": ", 2}, {"Permission denied", 17}, {"\n", 1}], 10mplayer: 
error while loading shared libraries: libGL.so.1: failed to map segment from 
shared object: Permission denied
) = 119
exit_group(127)

It seems that this happens during the process of loading shared objects as 
even ldd fails:

# ldd /usr/bin/mplayer 
/usr/bin/mplayer: error while loading shared libraries: libGL.so.1: failed to 
map segment from shared object: Permission denied

Any suggestions for how I could resolve this?  Apart from just granting 
execmem access to mplayer of course.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
