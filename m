Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9MCujNw015692
 for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2014 08:56:45 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 0/2] Updates to Makefiles to fix bugs with LIBDIR/SHLIBDIR
Date: Wed, 22 Oct 2014 08:56:19 -0400
Message-ID: <1413982581-19099-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

These patches fix two installation issues. The first in libsemanage
where LIBDIR and SHLIBDIR do not resolve to the same location. The
second in libsepol and libselinux where SHLIBDIR is not ../../
relative to LIBDIR.

Steve Lawrence (2):
  libsemanage: install to LIBDIR instead of SHLIBDIR
  libselinux: libsepol: use ln --relative to create .so symlinks

 libselinux/src/Makefile  | 2 +-
 libsemanage/src/Makefile | 7 +++----
 libsepol/src/Makefile    | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

-- 
1.9.3
