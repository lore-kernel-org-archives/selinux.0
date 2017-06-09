Message-ID: <1497028696.26846.9.camel@tycho.nsa.gov>
Subject: ANN: SELinux userspace 2.7-rc1 release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Fri, 09 Jun 2017 13:18:16 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A release candidate for the SELinux userspace is now available at:
https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

Below are some notes on this release for packagers and users of the
SELinux userspace.  A git shortlog will follow in a separate email.  If
you see (or encounter) other changes that you think are important to
call out for packagers and users in the final release announcement, let
us know.  Also, since we have removed the older manually maintained
ChangeLog files, let us know whether you would like to see a full
ChangeLog (generated via git log) and/or shortlog for the entire
release or by individual component added to the release (and if so,
whether this ought to go into the tar files themselves or can be
separate on the download page).

1) This will be the first release with the split up policycoreutils
(see https://www.mail-archive.com/selinux@tycho.nsa.gov/msg02914.html
and the rest of that thread).  If there are any final desired changes
to the structure, naming, etc, now is the last opportunity to get it
fixed before we make a final release with the new structure/naming. 
Fedora already packages many of these components separately, although
not always with the same organization and naming scheme.  Note that a
number of these components are not necessary for basic use of SELinux
and likely should not be installed by default, e.g. selinux-dbus,
selinux-gui,  mcstrans, restorecond, selinux-sandbox.

2) libsepol now has binary module support for ioctl xperms rules
(module version 18), making it possible to use allowxperm rules in
modularly built refpolicy-based policies. Previously, ioctl xperms
rules were only supported in monolithic policy and in CIL modules. 
This change means that refpolicy and/or policies derived from it can
begin to leverage ioctl whitelisting, which has already been leveraged
for some time in Android policies, which do not rely on binary modules.

3) This release introduces support for Infiniband object labeling,
including support for kernel policy version 31 and module version 19,
policy.conf and CIL language support, and semanage support.  It appears
that the corresponding kernel support will land in Linux v4.13.

4) This release introduces support for building policies with the
extended_socket_class and cgroup_seclabel policy capabilities enabled.
The extended_socket_class policy capability allows distinctions to be
made in policy among socket address families that were previously
mapped to the generic socket class (e.g. bluetooth, nfc, and many other
socket address families that previously did not have their own distinct
security class) as well as for SCTP and ICMP/ping sockets that were
previously mapped to the rawip_socket class.  This policy capability is
supported by Linux v4.11 and later. refpolicy master already includes
the class/permission definitions for this capability but does not yet
enable the capability by default (and further allow rules will be
necessary to allow access to the new socket classes; review all allow
rules on socket and rawip_socket and see whether they should be
duplicated for the new classes but do not blindly allow access to them
all).  AOSP master policy also includes the class/permission
definitions for this policy capability and enables the capability by
default, and will likewise need corresponding allow rules added when
kernels >= 4.11 are used. The cgroup_seclabel policy capability allows
userspace to set labels on cgroup/cgroup2 files, enabling fine-grained
labeling of cgroup files by userspace.  This policy capability is also
supported by Linux v4.11 and later.  This capability is not yet defined
in any policy.  Note that enabling this capability will break current
Android userspace/policy and requires introducing appropriate
file_contexts definitions for cgroup files (or a change to the Android
init program's handling of them) in order to avoid mislabeling them.

5) checkpolicy now supports for generating CIL or policy.conf from a
kernel binary policy.  Sample usage is checkpolicy -M -C -b policy.N -o
policy.cil and checkpolicy -M -F -b policy.N -o policy.conf.  There is
also now a secil2conf program that can generate policy.conf from CIL,
e.g. secil2conf -o policy.conf policy.cil.

6) Attribute generation and expansion has changed in several ways in
order to address kernel runtime performance issues that occur when
types have many attributes assigned to them while ensuring preservation
of attributes where desired.  Binary module to CIL conversion now
ensures that duplicate attributes are not generated for the same type
set. secilc now supports -G and -X options to force expansion of
automatically generated attributes (-G) and/or attributes that have
fewer than a specified number of types (-X number).  secilc will also
now more aggressively expand attributes based on whether they will
actually be used by the kernel, are needed for debugging denials by
audit2allow/why, or are needed for neverallow checking of binary
policies (in Android).  New statements are supported in policy.conf
(expandattribute) and in CIL (expandtypeattribute) to support
specifying in source policy that specific attributes should always be
expanded or never be expanded in order to override the default
behaviors in checkpolicy and secilc.

7) checkpolicy/checkmodule now treats it as an error if a type is
declared as an attribute or vice versa in a require block.  Such
mismatches between declarations and require statements are an error in
policy and should be corrected in policy; refpolicy master should
already be fixed.

8) A change to libsepol-internal data structures breaks the build of
setools4.  This is fixed by setools4 commit
743d2a0eaaae7d99302dd3099549ca7ad868eab on the master branch.  The
change was to align the libsepol structures with the kernel in order to
allow direct comparison of libsepol-generated policy files against
/sys/fs/selinux/policy after normalizing them through checkpolicy.

9) audit2why now understands type bounds failures and reports them as
such, although it does not yet provide detailed reporting.  Detailed
bounds violation reporting can be obtained already by enabling expand-
check=1 in semanage.conf or by running semodule_expand (without -a) at
policy validation time.

10) libsemanage now saves the linked policy and skips re-linking
whenever possible.  This significantly improves the performance and
memory overhead of semanage commands that do not affect policy modules
(setting booleans and adding, deleting, or modifying local context
mappings). Previously, libsemanage only skipped re-linking when setting
booleans as a special case, but this was found to have a bug that could
yield duplicate object context entries (e.g. portcon) in policy.  That
optimization was therefore reverted and replaced with this one, which
both fixes the bug and generalizes the optimization beyond just setting
booleans.  The change does bring an associated storage cost, primarily
storing an extra copy of the kernel policy file (if a concern, this
could be made optional but it seems well worth it). The first semanage
or setsebool -P command run with the new libsemanage will not
demonstrate any improvement due to needing to generate the linked
policy for the first time, but subsequent commands will leverage the
saved linked policy.
