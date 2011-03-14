Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2ENWjEv005863
	for <selinux@tycho.nsa.gov>; Mon, 14 Mar 2011 19:32:45 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p2ENWi5a023365
	for <selinux@tycho.nsa.gov>; Mon, 14 Mar 2011 23:32:44 GMT
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: jmorris@namei.org
Cc: eparis@redhat.com, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] selinux: select correct default LSM_MMAP_MIN_ADDR on ARM.
Date: Mon, 14 Mar 2011 19:32:21 -0400
Message-Id: <1300145541-30742-1-git-send-email-paul.gortmaker@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The default for this is universally set to 64k, but the help says:

   For most ia64, ppc64 and x86 users with lots of address space
   a value of 65536 is reasonable and should cause no problems.
   On arm and other archs it should not be higher than 32768.

The text is right, in that we are seeing selinux-enabled ARM targets
that fail to launch /sbin/init because selinux blocks a memory map.
So select the right value if we know we are building ARM.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 security/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 95accd4..e0f08b5 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -167,6 +167,7 @@ config INTEL_TXT
 config LSM_MMAP_MIN_ADDR
 	int "Low address space for LSM to protect from user allocation"
 	depends on SECURITY && SECURITY_SELINUX
+	default 32768 if ARM
 	default 65536
 	help
 	  This is the portion of low virtual memory which should be protected
-- 
1.7.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
