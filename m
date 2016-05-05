Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u45C3Cu7013308
 for <selinux@tycho.nsa.gov>; Thu, 5 May 2016 08:03:13 -0400
Received: from iosakhe.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 2F35256482F
 for <selinux@tycho.nsa.gov>; Thu,  5 May 2016 14:03:04 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3] Update make clean instructions and .gitgnore files
Date: Thu,  5 May 2016 14:02:37 +0200
Message-Id: <1462449760-9072-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

While working on testing the selinux-userspace project on several
configurations (compiler, compiler flags, libc, Python version...) it is
quite convenient that "make clean" leaves the directory clean, both from
a git prespective ("git ls-files --ignored --others --exclude-standard")
and from a build point of view (all generated and cached files are
removed).

These patches update the relevant .gitignore and Makefile files to
achieve this.

Cheers,
Nicolas

Nicolas Iooss (3):
  Update .gitignore files
  sepolgen: remove additional files when cleaning
  libsepol: remove libsepol.map when cleaning

 libselinux/utils/.gitignore        | 5 +++++
 libsemanage/tests/.gitignore       | 1 +
 libsepol/src/Makefile              | 2 +-
 libsepol/tests/.gitignore          | 1 +
 libsepol/tests/policies/.gitignore | 3 +++
 sepolgen/src/sepolgen/Makefile     | 3 +--
 sepolgen/tests/.gitignore          | 4 ++++
 sepolgen/tests/Makefile            | 3 +++
 8 files changed, 19 insertions(+), 3 deletions(-)
 create mode 100644 libsemanage/tests/.gitignore
 create mode 100644 libsepol/tests/.gitignore
 create mode 100644 libsepol/tests/policies/.gitignore
 create mode 100644 sepolgen/tests/.gitignore

-- 
2.8.2
