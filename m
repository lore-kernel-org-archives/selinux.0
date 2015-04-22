Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3MMIg4I015828
 for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2015 18:18:42 -0400
Received: by obbeb7 with SMTP id eb7so260143obb.3
 for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2015 15:18:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABXk95Dd-Veu_U8v4Pavc8+6riX8gJG-BjBEMRo28K5t9KAH4A@mail.gmail.com>
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <CABXk95Dd-Veu_U8v4Pavc8+6riX8gJG-BjBEMRo28K5t9KAH4A@mail.gmail.com>
Date: Wed, 22 Apr 2015 15:18:40 -0700
Message-ID: <CABXk95CpnqSujh+QPWYc9h+UkyrjuR6Ou=UJ0Em1XWbAGNhvjA@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
From: Jeffrey Vander Stoep <jeffv@google.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Supporting policy compiler patch is now up on the SELinux mailing list.

http://marc.info/?l=selinux&m=142973617003169&w=2

Note this is for monolithic kernel policies. Support for modules and
CIL still needs to be added.



On Thu, Apr 9, 2015 at 4:03 PM, Jeffrey Vander Stoep <jeffv@google.com> wrote:
> Approximately 150000 ioctls are executed during the ~40 seconds of
> boot time. Adding policy such that all of these ioctls are run through
> the ioctl whitelisting code has no noticeable impact on boot time. See
> attached graph of boot time comparison.
>
> Measuring the impact of an individual call is a bit showed a 20-30 ns
> increase in the ioctl call time on a very fast ioctl (SIOCGIFHWADDR is
> basically a 5 byte memcpy). Benchmarking was done on a Nexus 9, 64-bit
> NVIDIA Tegra K1 Dual Denver @ 2.3GHz. See attached graph of individual
> ioctl call time comparison.
>
> On Thu, Apr 9, 2015 at 2:48 PM, Jeff Vander Stoep <jeffv@google.com> wrote:
>> ---- motivation ----
>> Ioctls provide many of the operations necessary for device control. The typical
>> driver supports a device specific set of operations accessible by the ioctl
>> system call and specified by the command argument. SELinux provides per
>> operation access control to many system operations e.g. chown, kill, setuid,
>> ipc_lock, etc. Ioclts on the other hand are granted on a per file descriptor
>> basis using the ioctl permission, meaning that the set of operations provided
>> by the driver are granted on an all-or-nothing basis. In some cases this may be
>> acceptable, but often the same driver provides a large and diverse set of
>> operations such as benign and necessary functionality as well as dangerous
>> capabilities, or access to system information that should be restricted.
>>
>> Example 1 - restrict access to privacy sensitive information:
>> Applications with the socket permission require the ioctl permission to perform
>> control operations. However access to this ioctl also provides the application
>> with access to information such as the MAC address, Wifi ESSID, layer two
>> encryption information etc that can be used to uniquely identify the user and
>> compromise privacy.
>>
>> Example 2 - reduce kernel attack surface by eliminating access to unnecessary
>> operations:
>> Of the 34 available operations provided by a graphics driver, only 11 are used
>> on the device under test. Media drivers are frequently under development and are
>> notorious for containing bugs. By limiting application access to the subset of
>> commands needed, many bugs can be made unreachable without sacrificing
>> functionality. Real world example, we recently discovered three bugs within a
>> driver that would be unreachable by restricting access to unused ioctl commands.
>>
>> ---- Design constraints ----
>> Policy: Support existing policy, targeted whitelisting. The ioctls commands used
>> on a system may not be completely known to a sysadmin/policywriter. It is not
>> reasonable to enforce that all needed commands be known in order to use this
>> feature in a targeted manner. Existing policy using the ioctl permission will
>> continue to work as-is. Policy targeting a specific source/target/class will
>> only be enforced on that particular source/target/class. E.g. continue to allow
>> init to access all ioctls provided by a driver, but only allow the browser to
>> access a subset.
>>
>> Performance: Many ioctl calls are performance sensitive, and some ioctls have a
>> large command set (e.g. sockets support hundreds of commands). Execution time on
>> a filtered ioctl should be similar to execution time on an unfiltered one and
>> not related to the number of commands being filtered. Performance numbers will
>> be included in a separate document.
>>
>> Command space: The ioctl command is a 32 bit number comprised of four fields,
>> number - sequence number of the command. 8 bits
>> type - magic number assigned to the driver. 8 bits
>> size - size of the user data involved. typically 14 bits (arch dependent)
>> direction - The direction of data transfer. typically 2 bits (arch dependent)
>> The command is uniquely identified by the type and number, size and direction
>> are considered to be arguments and are not considered for SELinux whitelisting.
>>
>> ---- Policy format ----
>> allow <source> <target>:<class> { 0x8910-0x8926 0x892A-0x8935 }
>> auditallow <source> <target>:<class> 0x892A
>>
>> ---- Architecture ----
>> policy: Ioctl operations include allow, auditallow and dontaudit permissions.
>>
>> binary policy/avtab: Like AVC permissions, ioctl operations permissions are
>> represented by set/cleared bits. Each ioctl operation avtab entry represents a
>> single ioctl command type (using “type” as defined above in the “command space”
>> section) and includes permissions for the 256 operations within that type. This
>> architecture was designed after observing the sets of operations used by each
>> source/target/class across several devices. Most significantly, a
>> source/target/class normally uses just one ioctl type and only rarely uses more
>> than one type. For example in a prototyping device, 90 source/target/class
>> sets use just 1 type, and 2 source/target/class sets use 2 types, no
>> source/target/class used more than 2 types. Including permissions for all 256
>> bits creates a deterministic lookup time within a type because the command being
>> checked is mapped directly to a permission. Additionally, very complex policies
>> within a type map to the same size as simple policies e.g. ioctl commands
>> often switch between get and set operations where a policy writer could
>> conceivably want to give an application the ability to access all the get
>> operations and not set operations i.e. a policy allowing every other ioctl
>> number within a type. Optimizing for complexity within types was done to 1) make
>> the solution general 2) make the solution fast for both complex simple policies
>> and 3) ioctls that have a small operation set (many use just one) very likely
>> need all operations allowed and thus would not use this feature but would
>> continue to rely on the all-or-nothing ioctl permission for that particular
>> ioctl.
>>
>> AVC: A pointer to an operations structure has been added to the avc_node such
>> that general avc_lookup also returns the allowed ioctl operations. The structure
>> flags the ioctl types that are allowed and only looks up the permissions within
>> that type from the avtab when they are first used. After the initial lookup of a
>> type it is added to a list of types that are allowed for the source/target/class
>> being retrieved. As mentioned earlier, this list is typically one item long, but
>> can be 2, 3, etc, if necessary. The list lookup is linear with the length of
>> the list so it might be a good idea to enforce a restriction on the number of
>> types allowed in the policy compiler (if there exists a good example of a
>> source/target/class that uses more than a handful of types, none of the
>> prototyping devices tested would benefit from this).
>>
>> ---- example policy ----
>> allow system_server ion_device:chr_file { 0x4901 0x4905-0x4906 };
>> allow keystore tee_device:chr_file { 0x9707-0x9708 0x970a 0x970f };
>> allow netmgrd netmgrd:udp_socket { 0x8913 0x8933 0x89f2-0x89f3 0x89f5
>>         0x89f8-0x89f9 };
>> allow surfaceflinger graphics_device:chr_file { 0x4600 0x4602 0x4611
>> 0x6d87-0x6d89 0x6da0 0x6da2 0x6da4 0x6da6 };
>> allow untrusted_app gpu_device:chr_file { 0x902 0x907 0x913 0x915 0x933-0x935
>>         0x938-0x939 0x93b 0x93d };
>> allow shell owntty_device:chr_file { 0x5401 0x5403 0x540f 0x5413 };
>> allow system_server alarm_device:chr_file { 0x6101 0x6122 0x6132 0x6134 };
>> allow mediaserver camera_device:chr_file { 0x5600 0x5602 0x5604-0x5605 0x5608
>> 0x561c 0x564a 0x564d 0x5659-0x565b 0x5660 0x7c00-0x7c01 };
>> allow domain binder_device:chr_file { 0x6201 0x6205 0x6207-0x6209 };
>> allow system_server input_device:chr_file { 0x4501-0x4503 0x4506-0x4509 0x4518
>> 0x451b 0x4521-0x4523 0x4525 0x4531 0x4535 0x456f-0x4570 0x4575-0x4576
>>         0x4579-0x457a 0x4591 0x45a0 };
>> allow mediaserver audio_device:chr_file { 0x4101 0x4103 0x4111 0x4113 0x4123
>>         0x4140 0x4150 0x5501 0x5510-0x5513 0x610f 0x6167 0x6169 0x6171 0x6173
>>         0x6175 0x617b-0x617c };
>> allow camera camera_device:chr_file { 0x5659-0x565b 0x56c0-0x56c8 0x56de 0x56e0
>>         0x7c00-0x7c01 };
>> allow platform_app gpu_device:chr_file { 0x902 0x907 0x913-0x915 0x917 0x921
>>         0x933-0x935 0x938-0x939 0x93b 0x93d };
>> allow surfaceflinger gpu_device:chr_file { 0x902 0x907 0x913 0x915 0x921
>>         0x933-0x935 0x938-0x939 0x93b 0x93d };
>> allow sensors sensors:socket { 0xc302 0xc304 };
>> allow system_server gpu_device:chr_file { 0x902 0x907 0x913-0x915 0x917 0x921
>>         0x933-0x935 0x938-0x939 0x93b 0x93d };
>> allow domain ashmem_device:chr_file { 0x7701 0x7703-0x7705 };
>> allow bootanim gpu_device:chr_file { 0x902 0x907 0x913-0x915 0x917 0x921
>>         0x933-0x935 0x938-0x939 0x93b 0x93d };
>>
>> Jeff Vander Stoep (2):
>>   security: lsm_audit: add ioctl specific auditing
>>   SELinux: per-command whitelisting of ioctls
>>
>>  include/linux/lsm_audit.h           |   7 +
>>  security/lsm_audit.c                |  15 ++
>>  security/selinux/avc.c              | 428 ++++++++++++++++++++++++++++++++++--
>>  security/selinux/hooks.c            |  40 +++-
>>  security/selinux/include/avc.h      |   5 +
>>  security/selinux/include/security.h |  34 ++-
>>  security/selinux/ss/avtab.c         |  91 ++++++--
>>  security/selinux/ss/avtab.h         |  25 ++-
>>  security/selinux/ss/conditional.c   |  32 ++-
>>  security/selinux/ss/conditional.h   |   6 +-
>>  security/selinux/ss/policydb.c      |   5 +
>>  security/selinux/ss/services.c      | 202 +++++++++++++++--
>>  security/selinux/ss/services.h      |   6 +
>>  13 files changed, 832 insertions(+), 64 deletions(-)
>>
>> --
>> 2.2.0.rc0.207.ga3a616c
>>
