From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: Update README
Date: Tue, 12 Apr 2016 15:10:29 -0400
Message-Id: <1460488229-16231-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Update the package dependencies for the selinux testsuite
and note that expand-check must be set to 0 for the test policy
to build.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 README | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 1b38948..ba6c2c6 100644
--- a/README
+++ b/README
@@ -51,6 +51,7 @@ The testsuite has the following userspace dependencies on Fedora
 or RHEL beyond a minimal install:
 perl-Test # test harness used by the testsuite
 perl-Test-Harness # test harness used by the testsuite
+perl-Test-Simple # for Test::More
 selinux-policy-devel # to build the test policy
 gcc # to build the test programs
 libselinux-devel # to build some of the test programs
@@ -58,7 +59,7 @@ net-tools # for ifconfig, used by capable_net/test
 netlabel_tools # to load NetLabel configuration during inet_socket tests
 iptables # to load iptables SECMARK rules during inet_socket tests
 
-yum install perl-Test perl-Test-Harness selinux-policy-devel gcc libselinux-devel net-tools netlabel_tools iptables
+yum install perl-Test perl-Test-Harness perl-Test-Simple selinux-policy-devel gcc libselinux-devel net-tools netlabel_tools iptables
 
 The testsuite requires a pre-existing base policy configuration of
 SELinux, using either the old example policy or the reference policy
@@ -88,6 +89,9 @@ Check whether the SELinux kernel is in enforcing mode by running
 'getenforce'.  If it is in permissive mode, toggle it into enforcing
 mode by running 'setenforce 1'.
 
+Ensure that expand-check = 0 in /etc/selinux/semanage.conf; if not,
+edit it accordingly.
+
 To run the test suite, you can just do a 'make test' from the top-level
 directory or you can follow these broken-out steps:
 
-- 
2.5.5
