Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KGaErL004147
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 12:36:14 -0400
Received: by mail-pg0-f44.google.com with SMTP id e187so12514402pgc.1
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 09:35:58 -0700 (PDT)
From: Jeff Vander Stoep <jeffv@google.com>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, sds@tycho.nsa.gov,
 Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH] selinux: enable genfscon labeling for tracefs
Date: Tue, 20 Jun 2017 09:35:33 -0700
Message-Id: <20170620163533.2558-1-jeffv@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In kernel version 4.1, tracefs was separated from debugfs into its
own filesystem. Prior to this split, files in
/sys/kernel/debug/tracing could be labeled during filesystem
creation using genfscon or later from userspace using setxattr. This
change re-enables support for genfscon labeling.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 security/selinux/hooks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 820c16e36af8..33fd061305c4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -813,6 +813,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		sbsec->flags |= SE_SBPROC | SE_SBGENFS;
 
 	if (!strcmp(sb->s_type->name, "debugfs") ||
+	    !strcmp(sb->s_type->name, "tracefs") ||
 	    !strcmp(sb->s_type->name, "sysfs") ||
 	    !strcmp(sb->s_type->name, "pstore"))
 		sbsec->flags |= SE_SBGENFS;
-- 
2.13.1.518.g3df882009-goog
