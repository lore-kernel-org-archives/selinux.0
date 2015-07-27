Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6RDLPQD005762
 for <selinux@tycho.nsa.gov>; Mon, 27 Jul 2015 09:21:25 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH 0/2] Generalize tokenizer and remove sscanf calls from libsepol
Date: Mon, 27 Jul 2015 09:21:01 -0400
Message-ID: <1438003263-65455-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Libsepol uses %ms in sscanf, which certain platforms do not support. Since
Richard Haines already added support for this in libselinux we modified and
added the new tokenize() function to libsepol and libselinux.

Modifications were necessary to preserve existing libsepol functionality such as
splitting on non-whitespace delimiters and not squashing consecutive delimiters.

Yuli Khodorkovskiy (2):
  libselinux: generalize read_spec_entries for any delimiter
  libsepol: Replace sscanf in module_to_cil

 libselinux/src/label_android_property.c |  11 ++-
 libselinux/src/label_file.h             |  10 ++-
 libselinux/src/label_internal.h         |   7 +-
 libselinux/src/label_support.c          | 129 +++++++++++++++++++-------------
 libsepol/include/sepol/policydb/util.h  |   6 ++
 libsepol/src/module_to_cil.c            |  61 ++++++++++++---
 libsepol/src/util.c                     | 102 +++++++++++++++++++++++++
 7 files changed, 255 insertions(+), 71 deletions(-)

-- 
1.9.3
