From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: sepol_av_to_string: clear static buffer
Date: Tue, 29 Nov 2016 11:22:45 -0500
Message-Id: <1480436565-30641-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

chenxiaolong reported this via
https://github.com/SELinuxProject/selinux/issues/23

A nicer fix would be to rework the interface to be more
like security_av_string() in libselinux, but that requires
updating all callers.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index ff8f7f2..b00251c 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -89,6 +89,7 @@ char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
 	int rc;
 	int avlen = 0, len;
 
+	memset(avbuf, 0, sizeof avbuf);
 	cladatum = policydbp->class_val_to_struct[tclass - 1];
 	p = avbuf;
 	for (i = 0; i < cladatum->permissions.nprim; i++) {
-- 
2.7.4
