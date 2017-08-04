Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v74IqUfv004312
 for <selinux@tycho.nsa.gov>; Fri, 4 Aug 2017 14:52:30 -0400
Message-ID: <1501873040.23158.3.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Fri, 04 Aug 2017 14:57:20 -0400
In-Reply-To: <1497028696.26846.9.camel@tycho.nsa.gov>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: ANN: SELinux userspace release 20170804 / 2.7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The 20170804 / 2.7 release for the SELinux userspace release is now
available from:
https://github.com/SELinuxProject/selinux/wiki/Releases

Below are some notes on this release for packagers and users of the
SELinux userspace.  git log and git shortlog output for all changes
since the 20161014 / 2.6 release are linked from the release page. 
Thanks to all the contributors to this release!

If you notice corrections or additional items that should be added to
the release notes (below and also linked from the releases page), reply
to this message with your suggested changes/additions and we'll add
them to the one linked from the releases page too.

* This is the first release with the split up policycoreutils (see
https://www.mail-archive.com/selinux@tycho.nsa.gov/msg02914.html and
the rest of that thread). Fedora already packages many of these
components separately, although not always with the same organization
and naming scheme.  Note that a number of these components are not
necessary for basic use of SELinux and likely should not be installed
by default, e.g. selinux-dbus, selinux-gui, mcstrans, restorecond,
selinux-sandbox.

* libsepol now has binary module support for ioctl xperms rules
(module version 18), making it possible to use allowxperm rules in
modularly built refpolicy-based policies. Previously, ioctl xperms
rules were only supported in monolithic policy and in CIL modules. 
This change means that refpolicy and/or policies derived from it can
begin to leverage ioctl whitelisting, which has already been leveraged
for some time in Android policies, which do not rely on binary modules.

* This release introduces support for Infiniband object labeling,
including support for kernel policy version 31 and module version 19,
policy.conf and CIL language support, and semanage support.  The
corresponding kernel support was introduced in Linux v4.13.

* This release introduces support for building policies with the
extended_socket_class, cgroup_seclabel, and nnp_nosuid_transition
policy
capabilities enabled:

** The extended_socket_class policy capability allows distinctions to
be made in policy among socket address families that were previously
mapped to the generic socket class (e.g. bluetooth, nfc, and many
other socket address families that previously did not have their own
distinct security class) as well as for SCTP and ICMP/ping sockets
that were previously mapped to the rawip_socket class.  This policy
capability is supported by Linux v4.11 and later. Enabling this
capability
in policy requires reviewing existing rules on socket and rawip_socket
classes to determine whether they should be duplicated for the new
classes.

** The cgroup_seclabel policy capability allows userspace to set
labels on cgroup/cgroup2 files, enabling fine-grained labeling of
cgroup files by userspace.  This policy capability is also supported
by Linux v4.11 and later. Note that enabling this capability will
break current Android userspace/policy and requires introducing
appropriate file_contexts definitions for cgroup files (or a change to
the Android init program's handling of them) in order to avoid
mislabeling them.

** The nnp_nosuid_transition policy capability enables SELinux domain
transitions to occur under no_new_privs (NNP) or on nosuid mounts if
the corresponding permission (nnp_transition for NNP,
nosuid_transition for nosuid; both in the newly defined process2
security class / access vector) is allowed between the old and new
contexts.  This change was motivated by the increasing use of NNP by
systemd for confining system services and the desire to be able to
leverage NNP/nosuid-provided protections in combination with SELinux
rather than having to make undesirable tradeoffs in security. With
this policy capability enabled and the corresponding permissions
allowed where required, it should be possible to use upstream systemd
unit files without modification on SELinux-enabled systems.
NB: Allowing nnp_transition between two contexts opens up the
potential for the old context to subvert the new context by
installing seccomp filters before the execve.  Allowing
nosuid_transition between two contexts opens up the potential for
a context transition to occur on a file from an untrusted
filesystem (e.g. removable media or remote filesystem).  Use with
care.

* checkpolicy now supports generating CIL or policy.conf from a
kernel binary policy.  Sample usage is checkpolicy -M -C -b policy.N -o
policy.cil and checkpolicy -M -F -b policy.N -o policy.conf.  There is
also now a secil2conf program that can generate policy.conf from CIL,
e.g. secil2conf -o policy.conf policy.cil.

* Attribute generation and expansion has changed in several ways in
order to address kernel runtime performance issues that occur when
types have many attributes assigned to them while ensuring preservation
of attributes where desired.  Binary module to CIL conversion now
ensures that duplicate attributes are not generated for the same type
set. secilc now supports -G and -X options to force expansion of
automatically generated attributes (-G) and/or attributes that have
fewer than a specified number of types (-X number).  secilc will also
now more aggressively expand attributes based on whether they will
actually be used by the kernel, are needed for debugging denials by
audit2allow/why, or are needed for neverallow checking of binary
policies (in Android).  New statements are supported in policy.conf
(expandattribute) and in CIL (expandtypeattribute) to support
specifying in source policy that specific attributes should always be
expanded or never be expanded in order to override the default
behaviors in checkpolicy and secilc.

* checkpolicy/checkmodule now treats it as an error if a type is
declared as an attribute or vice versa in a require block.  Such
mismatches between declarations and require statements are an error in
policy and should be corrected in policy; refpolicy master should
already be fixed.

* A change to libsepol-internal data structures breaks the build of
setools4.  This is fixed by setools4 commit
743d2a0eaaae7d99302dd3099549ca7ad868eab on the master branch.  The
change was to align the libsepol structures with the kernel in order to
allow direct comparison of libsepol-generated policy files against
/sys/fs/selinux/policy after normalizing them through checkpolicy.

* audit2why now understands type bounds failures and reports them as
such, although it does not yet provide detailed reporting.  Detailed
bounds violation reporting can be obtained already by enabling expand-
check=1 in semanage.conf or by running semodule_expand (without -a) at
policy validation time.

* libsemanage now saves the linked policy and skips re-linking
whenever possible.  This significantly improves the performance and
memory overhead of semanage commands that do not affect policy modules
(setting booleans and adding, deleting, or modifying local context
mappings). Previously, libsemanage only skipped re-linking when setting
booleans as a special case, but this was found to have a bug that could
yield duplicate object context entries (e.g. portcon) in policy.  That
optimization was therefore reverted and replaced with this one, which
both fixes the bug and generalizes the optimization beyond just setting
booleans.  The change does bring an associated storage cost, primarily
storing an extra copy of the kernel policy file (if a concern, this
could be made optional but it seems well worth it). The first semanage
or setsebool -P command run with the new libsemanage will not
demonstrate any improvement due to needing to generate the linked
policy for the first time, but subsequent commands will leverage the
saved linked policy.

* libsemanage no longer depends on ustr.

* libselinux/utils Makefile now uses SBINDIR instead of USRBINDIR.

* mcstrans/utils Makefile now uses SBINDIR instead of BINDIR.

* Some packages (libselinux, checkpolicy, selinux-python,
semodule-utils and mcstrans) require LIBSEPOLA to be set to the
absolute path to libsepol.a when building with DESTDIR set.

* policycoreutils make install no longer creates a symlink from
/usr/sbin/load_policy to /sbin/load_policy.
