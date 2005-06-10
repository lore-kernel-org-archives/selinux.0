Subject: Re: general selinux questions
From: antoine <antoine@nagafix.co.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 21:00:04 +0100
Message-Id: <1118433604.10190.353.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I'd guess that the pipe (fifo_file) is originally created by crond (thus
> labeled with its type) to capture output of the cron job, then inherited
> by your mycron script, and then inherited by ping as its stdout.  The
> domain_auto_trans() macro allows for such inheritance and use by the
> child domain from the parent domain, but in this case since you are
> going through multiple such transitions, you have to explicitly allow
> the channel (or interpose on it in your own script so that it is no
> longer a direct channel between ping and crond).
That makes sense.
I thought a simple bash redirect would work:
ping [whatever] >& tempfile
But it still complained about the fifo... So I worked around it by
executing ping within the mycron domain and giving that domain the
privileges needed.

> I'm not sure what is happening with respect to the /tmp file.  The
> example policy defines a crond_tmp_t for /tmp files created by crond
> itself and a system_crond_tmp_t for tmp files created by system cron
> jobs.  They certainly shouldn't be tmpfs_t.
> 
> In Fedora, using tmpfs for /tmp has been addressed by putting a
> restorecon /tmp into rc.sysinit and adding an allow tmpfile
> tmpfs_t:filesystem associate; rule to the policy.  
I use Gentoo, it does the same thing:
# grep tmpfs_t policy.conf
type tmpfs_t, file_type, sysadmfile, fs_type;
allow { tmpfs_t tmp_t } tmpfs_t:filesystem associate;
(..)

2) [..] Thanks for the pointers.

> > 3) A lot of my current services are chrooted, labelling files in the
> > chroot seems to be a little bit difficult: I would like to re-use the
> > same label used outside the chroot (ie: etc_t for chroot/(.*)/etc(/.*)*)
> > but when I do, setfiles complains: "Operation not permitted". (-d tells
> > you what you would have expected it to do, but not what went wrong) - I
> > want to find which rule makes this illegal.
> 
> I'm not sure what you mean.  setfiles -r will let you specify an
> alternate root path if you just want to apply the same types under the
> chroot, but it may be smarter to use different types so that you can
> completely prohibit access to the base system types by the daemon's
> domain in your policy.  What is the actual output of setfiles?
I was trying a mixed approach: not using -r and making the root of the
chroot not root_t but specific to the domain. So I had sprinkled some
(/chroot/[service]) in the .fc files.
It's ok now, except I've had to move a directory out of the way: I can't
delete it, even as root in non-enforcing mode... trace included at the
bottom of this email. In the process I noticed that the code tries to
access '/etc/selinux' which does not exist on Gentoo systems: the
settings are in /etc/security/selinux, and there is no file named config
in there anyway... 
To remove these files I guess I'll have to reboot onto another disk (or
cdrom), fsck, mount it and remove it from there...


4) [...]
MLS sounds good, I would quite like the ability to tweak things like
network permissions for the uml virtual machines which are currently set
at the bridge and iptables level.

> > 5) If one of my script needs to restart a service (like apache) what do
> > I need to do to make it run without authentication. (run_init requires
> > authentication - do I just allow a transition to initrc_t? I haven't
> > tested this yet)
> 
> Fedora has a direct_sysadm_daemon tunable that enables automatic domain
> transitions from sysadm_t to the daemon domains and automatic role
> transitions from sysadm_r to system_r and authorizes root for system_r
> (since there is no way to automatically transition user identities to
> system_u; we originally expected all user identity transitions to be
> explicit upon some action like authentication).
Any snippets of code I could re-use on Gentoo?
I looked at a FC3 system for direct_sysadm, but couldn't find it.

> > 6) Can someone explain in layman's terms what needs to be fixed to get
> > rid of warnings like:
> > "security:  context system_u:system_r:[domain_t] is invalid"
> > What is missing from my policy for [domain_t]? Assuming [domain_t] can
> > be entered from initrc_t or sysadm_t for example, and that I have
> > domain_auto_trans(initrc_t, [domain_bin_t], [domain_t]) +same for sysadm
> 
> The role has to be authorized for the domain, e.g.
> 	role system_r types domain_t;
> Likewise, the user has to be authorized for the role, but that likely
> isn't your issue.
Ok, that makes sense, that solved a lot of problems.


Thanks a lot, sorry about flooding the ML lately...
Antoine



# strace rm -fr /chroot/dns.old/etc/bind
execve("/usr/bin/rm", ["rm", "-fr", "/chroot/dns.old/etc/bind"], [/* 31
vars */]) = 0
uname({sys="Linux", node="anaconda", ...}) = 0
brk(0)                                  = 0x509000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x2aaaaaac0000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=30135, ...}) = 0
mmap(NULL, 30135, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2aaaaaac1000
close(3)                                = 0
open("/lib/libselinux.so.1", O_RDONLY)  = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0 .\0\0\0"...,
640) = 640
fstat(3, {st_mode=S_IFREG|0755, st_size=67928, ...}) = 0
mmap(NULL, 1115688, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x2aaaaabc1000
mprotect(0x2aaaaabd0000, 1054248, PROT_NONE) = 0
mmap(0x2aaaaacc1000, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0) = 0x2aaaaacc1000
mmap(0x2aaaaacd1000, 1576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x2aaaaacd1000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\316"...,
640) = 640
lseek(3, 624, SEEK_SET)                 = 624
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\4\0\0\0"..., 32)
= 32
fstat(3, {st_mode=S_IFREG|0755, st_size=1270528, ...}) = 0
mmap(NULL, 2250248, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x2aaaaacd2000
mprotect(0x2aaaaadee000, 1086984, PROT_NONE) = 0
mmap(0x2aaaaaed2000, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|
MAP_FIXED|MAP_DENYWRITE, 3, 0x100000) = 0x2aaaaaed2000
mmap(0x2aaaaaef3000, 17928, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x2aaaaaef3000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x2aaaaaef8000
mprotect(0x2aaaaaeed000, 12288, PROT_READ) = 0
munmap(0x2aaaaaac1000, 30135)           = 0
access("/etc/selinux/", F_OK)           = -1 ENOENT (No such file or
directory)
brk(0)                                  = 0x509000
brk(0x52a000)                           = 0x52a000
open("/proc/mounts", O_RDONLY)          = 3
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x2aaaaaac1000
read(3, "rootfs / rootfs rw 0 0\n/dev/root"..., 1024) = 473
close(3)                                = 0
munmap(0x2aaaaaac1000, 4096)            = 0
open("/dev/urandom", O_RDONLY)          = 3
read(3, "\31\304\362Ac*\366\23", 8)     = 8
close(3)                                = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon
echo ...}) = 0
unlink("/chroot/dns.old/etc/bind")      = -1 EACCES (Permission denied)
write(2, "rm: ", 4rm: )                     = 4
write(2, "cannot remove `/chroot/dns.old/e"..., 40cannot remove
`/chroot/dns.old/etc/bind') = 40
write(2, ": Permission denied", 19: Permission denied)     = 19
write(2, "\n", 1
)                       = 1
exit_group(1)                           = ?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
