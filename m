From: william.c.roberts@intel.com
To: sds@tycho.nsa.gov, nnk@google.com, selinux@tycho.nsa.gov
Cc: Yongqin Liu <yongqin.liu@linaro.org>
Subject: [PATCH] quick selinux support for tracefs
Date: Tue,  6 Dec 2016 09:24:38 -0800
Message-Id: <1481045078-15000-2-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1481045078-15000-1-git-send-email-william.c.roberts@intel.com>
References: <1481045078-15000-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Yongqin Liu <yongqin.liu@linaro.org>

Here is just the quick fix for tracefs with selinux.
just add tracefs to the list of whitelisted filesystem
types in selinux_is_sblabel_mnt(), but the right fix would be to
generalize this logic as described in the last item on the todo list,
https://bitbucket.org/seandroid/wiki/wiki/ToDo

Change-Id: I2aa803ccffbcd2802a7287514da7648e6b364157
Signed-off-by: Yongqin Liu <yongqin.liu@linaro.org>
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
