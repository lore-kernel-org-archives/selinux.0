Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8LJYYuO003522
 for <selinux@tycho.nsa.gov>; Mon, 21 Sep 2015 15:34:38 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id E84BBAC858
 for <selinux@tycho.nsa.gov>; Mon, 21 Sep 2015 19:34:35 +0000 (UTC)
Subject: [RFC PATCH] selinux: change
 CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE default
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 21 Sep 2015 15:34:34 -0400
Message-ID: <20150921193434.11997.2963.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Change the SELinux checkreqprot default value to 0 so that SELinux
performs access control checking on the actual memory protections
used by the kernel and not those requested by the application.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index bca1b74..8691e92 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -78,7 +78,7 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
 	int "NSA SELinux checkreqprot default value"
 	depends on SECURITY_SELINUX
 	range 0 1
-	default 1
+	default 0
 	help
 	  This option sets the default value for the 'checkreqprot' flag
 	  that determines whether SELinux checks the protection requested
@@ -92,7 +92,7 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
 	  'checkreqprot=' boot parameter.  It may also be changed at runtime
 	  via /selinux/checkreqprot if authorized by policy.
 
-	  If you are unsure how to answer this question, answer 1.
+	  If you are unsure how to answer this question, answer 0.
 
 config SECURITY_SELINUX_POLICYDB_VERSION_MAX
 	bool "NSA SELinux maximum supported policy format version"
