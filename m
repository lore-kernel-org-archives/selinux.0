Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v12FN36J004206
 for <selinux@tycho.nsa.gov>; Thu, 2 Feb 2017 10:23:05 -0500
Received: by mail-wj0-f172.google.com with SMTP id uo9so3390039wjc.1
 for <selinux@tycho.nsa.gov>; Thu, 02 Feb 2017 07:23:03 -0800 (PST)
From: Antonio Murdaca <amurdaca@redhat.com>
To: selinux@tycho.nsa.gov
Cc: gary.tierney@gmx.com, linux-kernel@vger.kernel.org, dwalsh@redhat.com,
 pmoore@redhat.com, vgoyal@redhat.com, cgroups@vger.kernel.org
Subject: [PATCH v2] security: selinux: allow changing labels for cgroupfs
Date: Thu,  2 Feb 2017 16:22:57 +0100
Message-Id: <20170202152257.30220-1-runcom@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch allows changing labels for cgroup mounts. Previously, running
chcon on cgroupfs would throw an "Operation not supported". This patch
specifically whitelist cgroupfs.

The patch could also allow containers to write only to the systemd cgroup
for instance, while the other cgroups are kept with cgroup_t label.

Signed-off-by: Antonio Murdaca <runcom@redhat.com>
---
Changes in v2:
  - whitelist cgroup2 fs type

 security/selinux/hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3b955c6..2789f0a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -480,6 +480,8 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 		sbsec->behavior == SECURITY_FS_USE_NATIVE ||
 		/* Special handling. Genfs but also in-core setxattr handler */
 		!strcmp(sb->s_type->name, "sysfs") ||
+		!strcmp(sb->s_type->name, "cgroup") ||
+		!strcmp(sb->s_type->name, "cgroup2") ||
 		!strcmp(sb->s_type->name, "pstore") ||
 		!strcmp(sb->s_type->name, "debugfs") ||
 		!strcmp(sb->s_type->name, "tracefs") ||
-- 
2.9.3
