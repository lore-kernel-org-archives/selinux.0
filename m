Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9LHk0vW016712
 for <selinux@tycho.nsa.gov>; Fri, 21 Oct 2016 13:46:00 -0400
To: SELinux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC] Split up policycoreutils
Message-ID: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
Date: Fri, 21 Oct 2016 13:47:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

policycoreutils started life as a small set of utilities that were
necessary or at least widely used in production on a SELinux system.
Over time though it has grown to include many optional components, and
even within a given subdirectory (e.g. sepolicy) there seem to be a
number of components that should be optional (e.g. the dbus service).
I'd like to propose that we move a number of components out of
policycoreutils into their own top-level subdirectory (possibly grouping
some of the related ones together).

Some possible components to move and the rationale for doing so include:

- gui: not required for operation.  Unsure if this is even used outside
of Fedora, or how widely it is used within Fedora compared to the
command line tools. Packaged separately by Fedora as part of
policycoreutils-gui.

- mcstrans: not required for operation outside of MLS environments (and
even there, only if using that label encoding functionality), not built
by default even upstream (omitted from policycoreutils/Makefile).
Packaged separately in Fedora as mcstrans.

- restorecond: not required for operation, adds dbus and glib
dependencies, largely obsoleted by name-based type transition support in
the kernel.  Packaged separately in Fedora as policycoreutils-restorecond.

- sandbox: not required for basic operation of SELinux.  Packaged
separately by Fedora as policycoreutils-sandbox.

- semodule_deps/expand/link: developer tools only, not required for
operation, unlike semodule.  Packaged separately by Fedora as part of
policycoreutils-devel.

- sepolicy/{org.selinux*,selinux_client.py,selinux_server.py}: D-BUS
service for managing SELinux, not required for basic operation, not
desirable in high security environments. Packaged separately by Fedora
as part of policycoreutils-gui.  Could perhaps be combined with the gui
above, although I think they are logically distinct.

We could of course go further, but those seem to be the most obvious
candidates.

Thoughts?
