From: william.c.roberts@intel.com
To: sds@tycho.nsa.gov, paul@paul-moore.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
Subject: [PATCH] selinux: drop SECURITY_SELINUX_POLICYDB_VERSION_MAX
Date: Mon, 15 Aug 2016 12:42:12 -0700
Message-Id: <1471290132-26336-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Remove the SECURITY_SELINUX_POLICYDB_VERSION_MAX Kconfig option

Per: https://github.com/SELinuxProject/selinux/wiki/Kernel-Todo

This was only needed on Fedora 3 and 4 and just causes issues now,
so drop it.

The MAX and MIN should just be whatever the kernel can support.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 security/selinux/Kconfig            | 38 -------------------------------------
 security/selinux/include/security.h |  4 ----
 2 files changed, 42 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 8691e92..ea7e3ef 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -93,41 +93,3 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
 	  via /selinux/checkreqprot if authorized by policy.
 
 	  If you are unsure how to answer this question, answer 0.
-
-config SECURITY_SELINUX_POLICYDB_VERSION_MAX
-	bool "NSA SELinux maximum supported policy format version"
-	depends on SECURITY_SELINUX
-	default n
-	help
-	  This option enables the maximum policy format version supported
-	  by SELinux to be set to a particular value.  This value is reported
-	  to userspace via /selinux/policyvers and used at policy load time.
-	  It can be adjusted downward to support legacy userland (init) that
-	  does not correctly handle kernels that support newer policy versions.
-
-	  Examples:
-	  For the Fedora Core 3 or 4 Linux distributions, enable this option
-	  and set the value via the next option. For Fedora Core 5 and later,
-	  do not enable this option.
-
-	  If you are unsure how to answer this question, answer N.
-
-config SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
-	int "NSA SELinux maximum supported policy format version value"
-	depends on SECURITY_SELINUX_POLICYDB_VERSION_MAX
-	range 15 23
-	default 19
-	help
-	  This option sets the value for the maximum policy format version
-	  supported by SELinux.
-
-	  Examples:
-	  For Fedora Core 3, use 18.
-	  For Fedora Core 4, use 19.
-
-	  If you are unsure how to answer this question, look for the
-	  policy format version supported by your policy toolchain, by
-	  running 'checkpolicy -V'. Or look at what policy you have
-	  installed under /etc/selinux/$SELINUXTYPE/policy, where
-	  SELINUXTYPE is defined in your /etc/selinux/config.
-
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 38feb55..308a286 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -39,11 +39,7 @@
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
-#define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
-#else
 #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_XPERMS_IOCTL
-#endif
 
 /* Mask for just the mount related flags */
 #define SE_MNTMASK	0x0f
-- 
1.9.1
