Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4OJJpbO017121
 for <selinux@tycho.nsa.gov>; Thu, 24 May 2018 15:19:51 -0400
To: SELinux <selinux@tycho.nsa.gov>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
 <921a3a88-e10d-40dc-fde5-7ef12f775e32@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <efdfaa7a-5e47-f923-a109-4390b392ea84@tycho.nsa.gov>
Date: Thu, 24 May 2018 15:21:06 -0400
MIME-Version: 1.0
In-Reply-To: <921a3a88-e10d-40dc-fde5-7ef12f775e32@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: ANN: SELinux userspace release 20180524 / 2.8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The 20180524 / 2.8 release for the SELinux userspace is now available at:
https://github.com/SELinuxProject/selinux/wiki/Releases

A github release has also been created at:
https://github.com/SELinuxProject/selinux/releases/tag/20180524

In the future, we will likely stop hosting the releases on the wiki and
just have it link to the github releases.  We may also alter the versioning
and tagging scheme. For this release however, I have left these unchanged.

Below are some notes on this release for packagers and users of the
SELinux userspace.  git log and git shortlog output for all changes
since the 20170804 / 2.7 release are available from the release page. 

Thanks to all the contributors to this release!

RELEASE 20180524 (2.8)

User-visible changes:

* semanage fcontext -l now also lists home directory entries from
file_contexts.homedirs.

* semodule can now enable or disable multiple modules in the same
operation by specifying a list of modules after -e or -d, making them
consistent with the -i/u/r/E options.

* CIL now supports multiple declarations of types, attributes, and
(non-conflicting) object contexts (e.g. genfscon), enabled via the -m
or --multiple-decls option to secilc.

* libsemanage no longer deletes the tmp directory if there is an error
while committing the policy transaction, so that any temporary files
can be further inspected for debugging purposes (e.g. to examine a
particular line of the generated CIL module).  The tmp directory will
be deleted upon the next transaction, so no manual removal is needed.

* Support was added for SCTP portcon statements. The corresponding
kernel support was introduced in Linux 4.17, and is only active if the
extended_socket_class policy capability is enabled in the policy.  This
support is required to build the refpolicy master branch (and thus future
refpolicy releases).

* sepol_polcap_getnum/name() were exported as part of the shared libsepol
interface, initially for use by setools4.

* semodule_deps was removed since it has long been broken and is not useful
for CIL modules.

Packaging-relevant changes:

* When overriding PREFIX, BINDIR, SBINDIR, SHLIBDIR, LIBEXECDIR, etc.,
DESTDIR has to be removed from the definition. For example on Arch
Linux, SBINDIR="${pkgdir}/usr/bin" was changed to SBINDIR="/usr/bin".

* Defining variable LIBSEPOLA (to /usr/lib/libsepol.a, for example) is
no longer mandatory (thanks to the switch to "-l:libsepol.a" in
Makefiles).

* PYSITEDIR has been renamed PYTHONLIBDIR (and its definition changed).

* selinux-gui (i.e. system-config-selinux GUI application) is now
compatible with Python 3. Doing this required migrating away from
PyGTK to the supported PyGI library. This means that selinux-gui now
depends on python-gobject, Gtk+ 3 and selinux-python. It no longer
requires PyGtk or Python 2.
