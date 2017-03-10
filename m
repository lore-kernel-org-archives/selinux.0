Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2AJn4FR024726
 for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2017 14:49:04 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3] libsepol and checkpolicy: Output CIL or policy.conf from
 kernel policy
Date: Fri, 10 Mar 2017 14:49:33 -0500
Message-Id: <1489175376-27336-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It would sometimes be helpful for debugging or verification purposes to be able to convert
a binary policy to a human-readable form.

This patchset adds libsepol functions that take a kernel policydb in and outputs either
a CIL or policy.conf text.

Checkpolicy is modified to generate CIL text from a binary policy if using the "-C" option
and to add the "-F" option to generate policy.conf text from a binary policy.

Where possible rules are sorted in alphabetical or numerical order to aid in debugging.

James Carter (3):
  libsepol: Add ability to convert binary policy to CIL
  libsepol: Add ability to convert binary policy to policy.conf file
  checkpolicy: Add options to convert binary policy to CIL or a
    policy.conf

 checkpolicy/checkpolicy.c               |   60 +-
 libsepol/include/sepol/kernel_to_cil.h  |    5 +
 libsepol/include/sepol/kernel_to_conf.h |    5 +
 libsepol/src/kernel_to_cil.c            | 3149 +++++++++++++++++++++++++++++++
 libsepol/src/kernel_to_common.c         |  681 +++++++
 libsepol/src/kernel_to_common.h         |  110 ++
 libsepol/src/kernel_to_conf.c           | 3014 +++++++++++++++++++++++++++++
 libsepol/src/libsepol.map.in            |    2 +
 8 files changed, 7008 insertions(+), 18 deletions(-)
 create mode 100644 libsepol/include/sepol/kernel_to_cil.h
 create mode 100644 libsepol/include/sepol/kernel_to_conf.h
 create mode 100644 libsepol/src/kernel_to_cil.c
 create mode 100644 libsepol/src/kernel_to_common.c
 create mode 100644 libsepol/src/kernel_to_common.h
 create mode 100644 libsepol/src/kernel_to_conf.c

-- 
2.7.4
