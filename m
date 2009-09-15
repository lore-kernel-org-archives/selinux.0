From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov, jbrindle@tresys.com, sds@tycho.nsa.gov
Cc: Caleb Case <ccase@tresys.com>
Subject: [PATCH] setfiles fails to relabel if selinux not enabled
Date: Tue, 15 Sep 2009 15:20:18 -0400
Message-Id: <1253042418-28141-1-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Setfiles now checks the capabilities on the mounted file systems for
'seclabel' (see setfiles/setfiles.c:723:exclude_non_seclabel_mounts) on
newer kernels (>=2.6.30 see setfiles.c:734). However the 'seclabel'
feature is not available if selinux is not enabled. The result is that
setfiles silently fails to relabel any filesystems.

The patch below removes the check for seclabel if selinux is disabled.

As an alternative maybe seclabel should be available even if selinux is
disabled? It seems that whether a fs supports security labels is
independent of selinux being enabled.
---
 policycoreutils/setfiles/setfiles.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 313767a..db2857f 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -750,6 +750,8 @@ static void exclude_non_seclabel_mounts()
 	/* Check to see if the kernel supports seclabel */
 	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
 		return;
+	if (is_selinux_enabled() <= 0)
+		return;
 
 	fp = fopen("/proc/mounts", "r");
 	if (!fp)
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
