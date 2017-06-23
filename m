Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5NH2poh007008
 for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2017 13:02:51 -0400
Message-ID: <1498237648.2063.4.camel@tycho.nsa.gov>
Subject: ANN: SELinux userspace 2.7-rc3 release candidate
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Fri, 23 Jun 2017 13:07:28 -0400
In-Reply-To: <1497028696.26846.9.camel@tycho.nsa.gov>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A third release candidate for the SELinux userspace is now available
at:
https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

Changes from the -rc2 release:

Jason Zaman (2):
      libselinux utils: override LD{FLAGS, LIBS} for libselinux.so in
Makefile
      Makefiles: override *FLAGS and *LIBS

Nicolas Iooss (3):
      libsemanage/tests: fix linking
      gui: do not create /etc
      python/sepolicy: remove definition of SYSCONFDIR

Patrick Steinhardt (3):
      libsepol: replace non-standard use of __BEGIN_DECLS
      libselinux: avoid redefining _FORTIFY_SOURCE
      genhomedircon: avoid use of non-standard `getpwent_r`

Petr Lautrbach (1):
      mcstrans: Allow overriding libsepol.a location during build

Stephen Smalley (2):
      Fix BINDIR/SBINDIR/... variables in Makefiles
      Update VERSION files for 2.7-rc3 release.
