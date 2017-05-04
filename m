Message-ID: <1493918868.29203.4.camel@tycho.nsa.gov>
Subject: open permission is sometimes spelled recvfrom
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 Chris PeBenito <pebenito@ieee.org>, James Carter <jwcart2@tycho.nsa.gov>,
 Joshua Brindle <brindle@quarksecurity.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 04 May 2017 13:27:48 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Looking at adding a map permission, it occurred to me that it needs to
be defined for both file and socket classes since there is at least one
instance of a socket family that supports mmap() (AF_PACKET).  And in
general, the selinux_mmap_file() hook is reachable for any socket even
if the socket doesn't ultimately support mmap().  Alternatively, we
could just test to see if it is a socket and skip the check in that
case if we don't see it as being useful for sockets (since we don't
truly support relabeling sockets anyway).

This made me wonder about open permission, which is currently only
defined for files in the kernel (COMMON_FILE_PERMS rather than
COMMON_FILE_SOCK_PERMS).  And sure enough, construction of an
artificial test case that tries to open a socket via /proc/pid/fd will
generate a recvfrom avc denial because recvfrom and open happen to map
to the same permission bit in socket vs file classes.

Now, technically, open of a socket via /proc/pid/fd is not supported by
the kernel regardless and will ultimately return ENXIO.   But we hit
the permission check first and can thus produce these odd/misleading
denials.

Options:

- Move open to COMMON_FILE_SOCK_PERMS so that it is defined for socket
classes too.  Would also require defining it in all of the socket
classes in refpolicy.  Seems kind of pointless given that the kernel
doesn't support open() of sockets anyway, and will create compatibility
issues since existing policies already define the permission and the
policy capability. We'd need an entirely new capability for that
change.

- Test to see if we are dealing with a socket in the code and don't
bother checking FILE__OPEN in that case.  Seems more logical to me, and
avoids any compatibility headaches.

As a side bar, this also raises the question of when/if we can align
refpolicy's access vector definitions with the kernel.  There have been
a number of changes to the kernel's definitions (e.g. moving open and
execmod permission to common file, removing unused/deprecated
permission definitions) that haven't happened in refpolicy to date to
preserve compatibility with old kernels that predate dynamic class/perm
mapping (< v2.6.33 upstream), but at what point can we dispense with
that?  Looks like even RHEL6 has the dynamic class/permission mapping
support backported in its kernel these days even though it started from
2.6.32.

Would also be nice if we could align the class definitions for the
kernel classes, but some of the kernel changes may be too recent (e.g.
dropping of NETLINK_FIREWALL and NETLINK_IP6_FW didn't occur until v3.5
upstream and doesn't appear to be backported to RHEL6), and not all of
the userspace object managers are resilient to runtime changes to their
class values (primarily just dbusd and XSELinux at this point, I think;
seems like the rest have been migrated to selinux_check_access, e.g.
passwd and PAM, or looking up the class/permission strings each time -
nscd), which could be disturbed if we drop dead kernel classes or
rearrange the classes in refpolicy.
