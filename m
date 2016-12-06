From: william.c.roberts@intel.com
To: sds@tycho.nsa.gov, nnk@google.com, paul@paul-moore.com,
 selinux@tycho.nsa.gov
Cc: Yongqin Liu <yongqin.liu@linaro.org>,
 William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2] selinux: add security in-core xattr support for tracefs
Date: Tue,  6 Dec 2016 10:19:30 -0800
Message-Id: <1481048370-19930-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Yongqin Liu <yongqin.liu@linaro.org>

Support setting the security.selinux xattr from userspace
for tracefs. This is required for restorecon/setcon
functionality.

Signed-off-by: Yongqin Liu <yongqin.liu@linaro.org>
Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 security/selinux/hooks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 09fd610..24bd84d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -491,6 +491,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 		!strcmp(sb->s_type->name, "sysfs") ||
 		!strcmp(sb->s_type->name, "pstore") ||
 		!strcmp(sb->s_type->name, "debugfs") ||
+		!strcmp(sb->s_type->name, "tracefs") ||
 		!strcmp(sb->s_type->name, "rootfs");
 }
 
-- 
2.7.4
