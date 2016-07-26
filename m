Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6QGrjP5030739
 for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2016 12:53:46 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol/cil: Ignore object_r in userrole mappings when
 creating policy binary
Date: Tue, 26 Jul 2016 12:53:08 -0400
Message-ID: <1469551988-23131-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 77779d2ca, which added support for userattributes in CIL,
accidentally removed code that ignored object_r when adding userrole
mappings to the policydb. This meant that running commands like
`semanage user -l` would incorrectly show object_r. This patch adds that
code back in. Note that CIL requires that these mappings exist to
properly validate file contexts, so pp2cil's behavior of creating these
mappings is not modified.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/cil/src/cil_binary.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 5d03127..46fea4b 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -754,6 +754,12 @@ int cil_userrole_to_policydb(policydb_t *pdb, const struct cil_db *db, struct ci
 				goto exit;
 			}
 
+			if (sepol_role->s.value == 1) {
+				// role is object_r, ignore it since it is implicitly associated
+				// with all users
+				continue;
+			}
+
 			if (ebitmap_set_bit(&sepol_user->roles.roles, sepol_role->s.value - 1, 1)) {
 				cil_log(CIL_INFO, "Failed to set role bit for user\n");
 				rc = SEPOL_ERR;
-- 
2.5.5
