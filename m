Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v19G2mI1011960
 for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2017 11:02:48 -0500
Received: by mail-wm0-f42.google.com with SMTP id r141so23896687wmg.1
 for <selinux@tycho.nsa.gov>; Thu, 09 Feb 2017 08:02:46 -0800 (PST)
From: Antonio Murdaca <amurdaca@redhat.com>
To: selinux@tycho.nsa.gov
Cc: gary.tierney@gmx.com, linux-kernel@vger.kernel.org, dwalsh@redhat.com,
 pmoore@redhat.com, vgoyal@redhat.com, cgroups@vger.kernel.org,
 Antonio Murdaca <runcom@redhat.com>
Subject: [PATCH] security: selinux: allow per-file labeling for cgroupfs
Date: Thu,  9 Feb 2017 17:02:42 +0100
Message-Id: <20170209160242.23405-1-amurdaca@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Antonio Murdaca <runcom@redhat.com>

This patch allows genfscon per-file labeling for cgroupfs. For instance,
this allows to label the "release_agent" file within each
cgroup mount and limit writes to it.

Signed-off-by: Antonio Murdaca <amurdaca@redhat.com>
---
 security/selinux/hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9a8f12f..5a3138e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -808,6 +808,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 
 	if (!strcmp(sb->s_type->name, "debugfs") ||
 	    !strcmp(sb->s_type->name, "sysfs") ||
+	    !strcmp(sb->s_type->name, "cgroup") ||
+	    !strcmp(sb->s_type->name, "cgroup2") ||
 	    !strcmp(sb->s_type->name, "pstore"))
 		sbsec->flags |= SE_SBGENFS;
 
-- 
2.9.3
