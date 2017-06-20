Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KE7Vh8007848
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 10:07:33 -0400
From: Patrick Steinhardt <ps@pks.im>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3] Portability improvements
Date: Tue, 20 Jun 2017 16:07:00 +0200
Message-Id: <cover.1497967444.git.ps@pks.im>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

This is a small batch of portability fixes. It removes calls to
the non-portable getpwent_r function, problems with hardened
toolchains defining FORTIFY_SOURCE and removes usage of
__BEGIN_DECLS. These patches are all aiming for compatibility
with musl on hardened Gentoo.

While I guess that the first two commits of removing
__BEGIN_DECLS and the patch for FORTIFY_SOURCE are
uncontroversial, I can imagine the removal of getpwent_r being a
bit more so due to the alternative being non-reentrant. But to
the best of my knowledge the code in question is not called in a
threaded context, so I actually doubt it matters much. Given that
I'm new to this code base I could very likely be wrong, though.

Patrick


Patrick Steinhardt (3):
  libsepol: replace non-standard use of __BEGIN_DECLS
  libselinux: fix error when FORTIFY_SOURCE is already set
  genhomedircon: avoid use of non-standard `getpwent_r`

 libselinux/src/Makefile                   |  3 ++-
 libselinux/utils/Makefile                 |  3 ++-
 libsemanage/src/genhomedircon.c           | 22 +++++-----------------
 libsepol/include/sepol/ibendport_record.h | 10 +++++++---
 libsepol/include/sepol/ibendports.h       | 11 ++++++++---
 libsepol/include/sepol/ibpkey_record.h    | 11 ++++++++---
 libsepol/include/sepol/ibpkeys.h          | 12 +++++++++---
 7 files changed, 41 insertions(+), 31 deletions(-)

-- 
2.13.1
