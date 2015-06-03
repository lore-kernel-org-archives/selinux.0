Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t53Jf5QN020086
 for <selinux@tycho.nsa.gov>; Wed, 3 Jun 2015 15:41:05 -0400
Received: by iecwk5 with SMTP id wk5so20520172iec.1
 for <selinux@tycho.nsa.gov>; Wed, 03 Jun 2015 12:41:03 -0700 (PDT)
From: Jeff Vander Stoep <jeffv@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2 v2] selinux: extended permissions for ioctl commands
Date: Wed,  3 Jun 2015 12:40:59 -0700
Message-Id: <1433360459-16310-1-git-send-email-jeffv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-security-module@vger.kernel.org, james.l.morris@oracle.com,
 sds@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ioctls provide many of the operations necessary for device control. The typical
driver supports a device specific set of operations accessible by the ioctl
system call and specified by the command argument. SELinux provides per
operation access control to many system operations e.g. chown, kill, setuid,
ipc_lock, etc. Ioclts on the other hand are granted on a per file descriptor
basis using the ioctl permission, meaning that the set of operations provided
by the driver are granted on an all-or-nothing basis. In some cases this may be
acceptable, but often the same driver provides a large and diverse set of
operations such as benign and necessary functionality as well as dangerous
capabilities, or access to system information that should be restricted.

Example 1 - restrict access to privacy sensitive information:
Applications with the socket permission require the ioctl permission to perform
control operations. However access to this ioctl also provides the application
with access to information such as the MAC address, Wifi ESSID, layer two
encryption information etc that can be used to uniquely identify the user and
compromise privacy.

Example 2 - reduce kernel attack surface by eliminating access to unnecessary
operations:
Of the 34 available operations provided by a graphics driver, only 11 are used
on the device under test. Media drivers are frequently under development and are
notorious for containing bugs. By limiting application access to the subset of
commands needed, many bugs can be made unreachable without sacrificing
functionality. Real world example, we recently discovered three bugs within a
driver that would be unreachable by restricting access to unused ioctl commands.

---- Design constraints ----
Policy: Support existing policy, targeted whitelisting. The ioctls commands used
on a system may not be completely known to a sysadmin/policywriter. It is not
reasonable to enforce that all needed commands be known in order to use this
feature in a targeted manner. Existing policy using the ioctl permission will
continue to work as-is. Policy targeting a specific source/target/class will
only be enforced on that particular source/target/class. E.g. continue to allow
init to access all ioctls provided by a driver, but only allow the browser to
access a subset.

Performance: Many ioctl calls are performance sensitive, and some ioctls have a
large command set (e.g. sockets support hundreds of commands). Execution time on
a filtered ioctl should be similar to execution time on an unfiltered one and
not related to the number of commands being filtered. Performance numbers will
be included in a separate document.

Command space: The ioctl command is a 32 bit number comprised of four fields,
number - sequence number of the command. 8 bits
type - magic number assigned to the driver. 8 bits
size - size of the user data involved. typically 14 bits (arch dependent)
direction - The direction of data transfer. typically 2 bits (arch dependent)
The command is uniquely identified by the type and number, size and direction
are considered to be arguments and are not considered for SELinux whitelisting.

---- Policy format ----
allow <source> <target>:<class> { 0x8910-0x8926 0x892A-0x8935 }
auditallow <source> <target>:<class> 0x892A

---- Architecture ----
extended permissions framework: The 32 bits of permissions provided by the
current selinux implementation is inadequate for ioctl command whitelisting.
To support future extensions of selinux a generic extended permissions
subcomponent has been added that provides additional permissions in 256 bit
increments. Ioctl command whitelisting will be the first user of selinux
extended permissions.

policy: Ioctl operations include allow, auditallow and dontaudit permissions.
binary policy/avtab: Like AVC permissions, ioctl operations permissions are
represented by set/cleared bits. Each ioctl operation avtab entry represents a
single ioctl command type (using “type” as defined above in the “command space”
section) and includes permissions for the 256 operations within that type. This
architecture was designed after observing the sets of operations used by each
source/target/class across several devices. Most significantly, a
source/target/class normally uses just one ioctl type and only rarely uses more
than one type. For example in a prototyping device, 90 source/target/class
sets use just 1 type, and 2 source/target/class sets use 2 types, no
source/target/class used more than 2 types. Including permissions for all 256
bits creates a deterministic lookup time within a type because the command being
checked is mapped directly to a permission. Additionally, very complex policies
within a type map to the same size as simple policies e.g. ioctl commands
often switch between get and set operations where a policy writer could
conceivably want to give an application the ability to access all the get
operations and not set operations i.e. a policy allowing every other ioctl
number within a type. Optimizing for complexity within types was done to 1) make
the solution general 2) make the solution fast for both complex simple policies
and 3) ioctls that have a small operation set (many use just one) very likely
need all operations allowed and thus would not use this feature but would
continue to rely on the all-or-nothing ioctl permission for that particular
ioctl.

AVC: A pointer to an operations structure has been added to the avc_node such
that general avc_lookup also returns the allowed ioctl operations. The structure
flags the ioctl types that are allowed and only looks up the permissions within
that type from the avtab when they are first used. After the initial lookup of a
type it is added to a list of types that are allowed for the source/target/class
being retrieved. As mentioned earlier, this list is typically one item long, but
can be 2, 3, etc, if necessary. The list lookup is linear with the length of
the list so it might be a good idea to enforce a restriction on the number of
types allowed in the policy compiler (if there exists a good example of a
source/target/class that uses more than a handful of types, none of the
prototyping devices tested would benefit from this).

---- example policy ----
allowxperms mediaserver camera_device:chr_file ioctl camera_ioc;
allowxperms system_server ion_device:chr_file ioctl priv_ion_dev_ioc;
allowxperms keystore tee_device:chr_file ioctl priv_keystore_ioc;
allowxperms netmgrd netmgrd:udp_socket ioctl priv_socket_ioc;
allowxperms untrusted_app self:udp_socket ioctl unpriv_socket_ioc;
allowxperms surfaceflinger graphics_device:chr_file ioctl priv_graphics_ioc;
allowxperms untrusted_app gpu_device:chr_file ioctl unpriv_gpu_ioc;
allowxperms bootanim gpu_device:chr_file ioctl priv_gpu_ioc;
allowxperms shell owntty_device:chr_file ioctl tty_ioc;


Jeff Vander Stoep (2):
  security: lsm_audit: add ioctl specific auditing
  selinux: extended permissions for ioctls

 include/linux/lsm_audit.h           |   7 +
 security/lsm_audit.c                |  15 ++
 security/selinux/avc.c              | 415 ++++++++++++++++++++++++++++++++++--
 security/selinux/hooks.c            |  42 +++-
 security/selinux/include/avc.h      |   6 +
 security/selinux/include/security.h |  32 ++-
 security/selinux/ss/avtab.c         | 104 +++++++--
 security/selinux/ss/avtab.h         |  33 ++-
 security/selinux/ss/conditional.c   |  32 ++-
 security/selinux/ss/conditional.h   |   6 +-
 security/selinux/ss/policydb.c      |   5 +
 security/selinux/ss/services.c      | 213 ++++++++++++++++--
 security/selinux/ss/services.h      |   6 +
 13 files changed, 856 insertions(+), 60 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c
