Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7OBFQcs006868
 for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2018 07:15:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6EA9740216E8
 for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2018 11:15:20 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0ACBD2026D6D
 for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2018 11:15:19 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 24 Aug 2018 13:15:16 +0200
Message-Id: <20180824111516.16407-1-vmojzis@redhat.com>
Subject: [PATCH] libsemanage: Include user name in ROLE_REMOVE audit
 events
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use "previous" user name when no new user is available in
semanage_seuser_audit. Otherwise "id=0" is logged instead of
"acct=user_name" ("id=0" is hard coded value).

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1622045
---
 libsemanage/src/seusers_local.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
index 413ebddd..5fbb09e4 100644
--- a/libsemanage/src/seusers_local.c
+++ b/libsemanage/src/seusers_local.c
@@ -71,17 +71,18 @@ static int semanage_seuser_audit(semanage_handle_t * handle,
 	const char *sep = "-";
 	int rc = -1;
 	strcpy(msg, "login");
+	if (previous) {
+		name = semanage_seuser_get_name(seuser);
+		psename = semanage_seuser_get_sename(previous);
+		pmls = semanage_seuser_get_mlsrange(previous);
+		proles = semanage_user_roles(handle, psename);
+	}
 	if (seuser) {
 		name = semanage_seuser_get_name(seuser);
 		sename = semanage_seuser_get_sename(seuser);
 		mls = semanage_seuser_get_mlsrange(seuser);
 		roles = semanage_user_roles(handle, sename);
 	}
-	if (previous) {
-		psename = semanage_seuser_get_sename(previous);
-		pmls = semanage_seuser_get_mlsrange(previous);
-		proles = semanage_user_roles(handle, psename);
-	}
 	if (audit_type != AUDIT_ROLE_REMOVE) {
 		if (sename && (!psename || strcmp(psename, sename) != 0)) {
 			strcat(msg,sep);
-- 
2.14.3
