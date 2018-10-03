Received: from goalie.tycho.ncsc.mil (goalie.tycho.ncsc.mil [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w93FqmcP001412
 for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2018 11:52:48 -0400
Received: by mail-qk1-f195.google.com with SMTP id m8-v6so3727508qka.12
 for <selinux@tycho.nsa.gov>; Wed, 03 Oct 2018 08:52:40 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov
Date: Wed, 03 Oct 2018 11:52:34 -0400
Message-ID: <153858195445.31764.1907601375378542109.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] selinux-testsuite: update the dependencies in
 README.md
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The overlayfs tests require setfattr and getfattr which are part of
the attr package in Fedora.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 README.md |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 2c871d3..cf90ef6 100644
--- a/README.md
+++ b/README.md
@@ -50,6 +50,7 @@ similar dependencies):
 * netlabel\_tools _(to load NetLabel configuration during `inet_socket` tests)_
 * iptables _(to load the `iptables SECMARK` rules during `inet_socket` tests)_
 * lksctp-tools-devel _(to build the SCTP test programs)_
+* attr _(tools used by the overlayfs tests)_
 
 On a modern Fedora system you can install these dependencies with the
 following command:
@@ -63,7 +64,8 @@ following command:
 		net-tools \
 		netlabel_tools \
 		iptables \
-		lksctp-tools-devel
+		lksctp-tools-devel \
+		attr
 
 The testsuite requires a pre-existing base policy configuration of SELinux,
 using either the old example policy or the reference policy as the baseline.
