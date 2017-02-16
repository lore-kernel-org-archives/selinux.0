From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 0/2] selinux-testsuite: fixes for RHEL7.3
Date: Thu, 16 Feb 2017 13:50:03 -0500
Message-Id: <1487271005-3728-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A couple of testsuite fixes for RHEL7.3.

Stephen Smalley (2):
  selinux-testsuite:  exclude netlink_socket tests from RHEL7
  selinux-testsuite: fix nnp test for RHEL7

 tests/Makefile      | 4 ++++
 tests/nnp/execnnp.c | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.7.4
