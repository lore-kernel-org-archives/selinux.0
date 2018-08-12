Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7CKR6JK017836
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 16:27:06 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id AAED45646EF
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 22:25:56 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 12 Aug 2018 22:25:09 +0200
Message-Id: <20180812202522.3743-1-nicolas.iooss@m4x.org>
Subject: [PATCH v2 00/13] Fix some issues found by flake8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Here is the second revision of this patchset. The changes were:

* I removed the buggy code instead of commenting it, in python/sepolgen.
* I fixed a typo in the description of a patch.


Nicolas Iooss (13):
  libselinux: fix flake8 warnings in SWIG-generated code
  python/sepolgen: do not import twice the modules
  python/sepolgen: return NotImplemented instead of raising it
  python/sepolicy: drop unused CheckPolicyType
  python/sepolicy: use lowercase variable name
  python/sepolgen: fix refpolicy parsing of "permissive"
  python/sepolgen: silence linter warning about has_key
  python/sepolgen: remove buggy code
  python/sepolgen: use self when accessing members in FilesystemUse
  python/sepolicy: fix "procotol" misspelling
  python/sepolicy: use variables which exist in the gui.py
  python/sepolicy: do not import sepolicy.generate.DAEMON twice
  python/sepolicy: do not import types

 libselinux/src/selinuxswig_python.i        |  5 +++--
 python/sepolgen/src/sepolgen/interfaces.py |  7 +------
 python/sepolgen/src/sepolgen/refparser.py  |  4 ++--
 python/sepolgen/src/sepolgen/refpolicy.py  |  6 +++---
 python/sepolgen/src/sepolgen/util.py       |  6 +-----
 python/sepolicy/sepolicy.py                | 12 +-----------
 python/sepolicy/sepolicy/generate.py       |  1 -
 python/sepolicy/sepolicy/gui.py            | 12 ++++++------
 8 files changed, 17 insertions(+), 36 deletions(-)

-- 
2.18.0
