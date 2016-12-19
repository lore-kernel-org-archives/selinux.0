Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBJD5Kaa020787
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 08:05:20 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 31B31564788
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 14:04:39 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/7] Remove ustr library dependency
Date: Mon, 19 Dec 2016 14:03:57 +0100
Message-Id: <20161219130404.11496-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

ustr library uses old (pre-C99) "extern inline" semantic. This makes it
incompatible with recent versions of gcc and clang, which default to
C99 standard. Distributions have shipped patched versions of this
library to fix issues [1] but there is no upstream solution to make ustr
compatible with C99 standard. Moreover the git tree of ustr
(http://www.and.org/ustr/ustr.git) has not been updated since 2008 and
the developer of this project did not reply to emails.

This patchset aims at removing ustr from SELinux userland libraries and
tools. The library is currenlty only used by genhomedircon functions in
libsemanage. Here is how the patches are organised:

* patches 1 and 2 make libsemanage test infrastructure work properly,
* patch 3 expands some test cases in order to better check the
  modifications of the next patch,
* patch 4 reimplements functions in libsemanage/src/utilities.c without
  ustr,
* patches 5 and 6 remove ustr from libsemanage/src/genhomedircon.c (I
  introduced a new function, semanage_str_replace(), to replace
  ustr_replace_cstr()),
* patch 7 removes references to ustr in Makefile, README and pkg-config
  files.

Thanks,
Nicolas

[1] for example Gentoo package uses this patch:
https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-libs/ustr/files/ustr-1.0.4-gcc_5-check.patch?id=7dea6f8820f36bf389e6315044bea7507553bed0

Nicolas Iooss (7):
  libsemanage/tests: make "make test" fail when a CUnit test fails
  libsemanage/tests: make tests standalone
  libsemanage/tests: test more cases of semanage_split*()
  libsemanage: simplify string utilities functions
  libsemanage: add semanage_str_replace() utility function
  libsemanage: genhomedircon: drop ustr dependency
  libsemanage: remove ustr library from Makefiles and pkg-config

 README                                |   2 +-
 libsemanage/src/Makefile              |   2 +-
 libsemanage/src/genhomedircon.c       | 137 ++++++++++++++++------------------
 libsemanage/src/libsemanage.pc.in     |   2 +-
 libsemanage/src/utilities.c           | 119 +++++++++++++++++------------
 libsemanage/src/utilities.h           |  10 +++
 libsemanage/tests/Makefile            |  14 ++--
 libsemanage/tests/libsemanage-tests.c |   9 ++-
 libsemanage/tests/test_utilities.c    |  85 ++++++++++++++++-----
 9 files changed, 232 insertions(+), 148 deletions(-)

-- 
2.11.0
