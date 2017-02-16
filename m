From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/2] selinux-testsuite: exclude netlink_socket tests from RHEL7
Date: Thu, 16 Feb 2017 13:50:04 -0500
Message-Id: <1487271005-3728-2-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1487271005-3728-1-git-send-email-sds@tycho.nsa.gov>
References: <1487271005-3728-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

RHEL7.3 updated its policy to define the new netlink socket classes,
thereby enabling execution of the netlink_socket tests, but its
kernel does not include the corresponding kernel patch implementing
them.  Disable these tests on RHEL7.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/Makefile b/tests/Makefile
index 1311234..11008a9 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -40,6 +40,10 @@ ifeq ($(DISTRO),RHEL6)
     SUBDIRS:=$(filter-out nnp overlay, $(SUBDIRS))
 endif
 
+ifeq ($(DISTRO),RHEL7)
+    SUBDIRS:=$(filter-out netlink_socket, $(SUBDIRS))
+endif
+
 .PHONY: all test clean
 
 all:
-- 
2.7.4
