Subject: 2.6.0-test3
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: SELinux <SELinux@tycho.nsa.gov>, russel@cooker.com.au
Content-Type: text/plain; charset=ISO-8859-2
Date: 21 Aug 2003 14:29:00 +0200
Message-Id: <1061468940.1665.16.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

I have a 2.6.0-test3 kernel.
It seems that I have compiled in selinux, and it initializes at boot,
but I cannot use it. What did I done wrong?

The kernel configuration:
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
# CONFIG_SECURITY_SELINUX_MLS is not set

Relevant messages in dmesg:
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security
failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized

The strace of running avc_toggle:
execve("/sbin/avc_toggle", ["avc_toggle"], [/* 20 vars */]) = 0
uname({sys="Linux", node="test42", ...}) = 0
brk(0)                                  = 0x804a000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=6096, ...}) = 0
old_mmap(NULL, 6096, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40012000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\275Z\1\0004\0\0\0\20\320"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1104040, ...}) = 0
old_mmap(NULL, 1113796, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x40014000
mprotect(0x4011c000, 32452, PROT_NONE)  = 0
old_mmap(0x4011c000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x107000) = 0x4011c000
old_mmap(0x40122000, 7876, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40122000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40124000
munmap(0x40012000, 6096)                = 0
security(0xf97cff8c, 0xb, 0, 0x400098bc, 0xbffffb54) = -1 ENOSYS
(Function not implemented)
dup(2)                                  = 3
fcntl64(3, F_GETFL)                     = 0x8002 (flags
O_RDWR|O_LARGEFILE)
brk(0)                                  = 0x804a000
brk(0x804b000)                          = 0x804b000
brk(0)                                  = 0x804b000
fstat64(3, {st_mode=S_IFCHR|0666, st_rdev=makedev(4, 2), ...}) = 0
ioctl(3, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40012000
_llseek(3, 0, 0xbffff920, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(3, "avc_toggle: Function not implemented\n", 37) = 37
close(3)                                = 0
munmap(0x40012000, 4096)                = 0
exit_group(0)                           = ?

Package: selinux
Priority: optional
Section: admin
Installed-Size: 5390
Maintainer: Russell Coker <russell@coker.com.au>
Architecture: i386
Source: selinux-small
Version: 2003071106-1
Provides: flask
Depends: libc6 (>= 2.3.1-1), libpam0g (>= 0.76), expect (>= 5.38.0-3)
Recommends: selinux-policy
Conflicts: flask, devfsd (<< 1.3.25-6)
Filename: pool/main/s/selinux-small/selinux_2003071106-1_i386.deb
Size: 2155622
MD5sum: 4048f92a0f22b77cc06236d0e6f49235
Description: Management utilities for NSA Security Enhanced Linux
 SE Linux is a system for adding Mandatory Access Control to Linux.  It
uses
 Domain Type control as well as Role Based control.  This package
provides
 all the base utilities for controlling it.



-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
