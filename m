Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w85K9Mpl026307
 for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2018 16:09:22 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5F8BA5647F2
 for <selinux@tycho.nsa.gov>; Wed,  5 Sep 2018 22:08:41 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Wed,  5 Sep 2018 22:08:16 +0200
Message-Id: <20180905200816.1533-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/1] libsemanage: use previous seuser when getting
 the previous name
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I missed this bug in commit 9ec0ea143ab5 ("libsemanage: use previous
seuser when getting the previous name").

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/seusers_local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
index 5fbb09e40b69..a79e2d3d230b 100644
--- a/libsemanage/src/seusers_local.c
+++ b/libsemanage/src/seusers_local.c
@@ -72,7 +72,7 @@ static int semanage_seuser_audit(semanage_handle_t * handle,
 	int rc = -1;
 	strcpy(msg, "login");
 	if (previous) {
-		name = semanage_seuser_get_name(seuser);
+		name = semanage_seuser_get_name(previous);
 		psename = semanage_seuser_get_sename(previous);
 		pmls = semanage_seuser_get_mlsrange(previous);
 		proles = semanage_user_roles(handle, psename);
-- 
2.18.0
