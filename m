Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2JEkabG025266
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 10:46:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID08.oob.disa.mil (Postfix) with SMTP id 404f5g0v32z3TWMt
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 14:46:31 +0000 (UTC)
Received: from USFB19PA02.eesmg.mil (unknown [192.168.16.9])
 by USFBF3ID08.oob.disa.mil (Postfix) with ESMTP id 404f5g0FMPz3TWMr
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 14:46:31 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 83E6BE44B5
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 14:46:28 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2595C10B2B27
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 14:46:28 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 19 Mar 2018 15:46:15 +0100
Message-Id: <20180319144615.4843-1-vmojzis@redhat.com>
In-Reply-To: <20180317072616.GA4209@workstation>
References: <20180317072616.GA4209@workstation>
Subject: [PATCH] libsemanage/direct_api.c: Fix iterating over array
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix sizeof calculation in array iteration introduced by commit
6bb8282c4cf66e93daa9684dbe9c75bb6b1e09a7
"libsemanage: replace access() checks to make setuid programs work"

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/direct_api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 439122df..e7ec952f 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -60,6 +60,7 @@
 
 #define PIPE_READ 0
 #define PIPE_WRITE 1
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 static void semanage_direct_destroy(semanage_handle_t * sh);
 static int semanage_direct_disconnect(semanage_handle_t * sh);
@@ -1332,7 +1333,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 					   SEMANAGE_SEUSERS_LINKED,
 					   SEMANAGE_USERS_EXTRA_LINKED};
 
-		for (i = 0; i < (int) sizeof(files); i++) {
+		for (i = 0; i < (int) ARRAY_SIZE(files); i++) {
 			path = semanage_path(SEMANAGE_TMP, files[i]);
 			if (stat(path, &sb) != 0) {
 				if (errno != ENOENT) {
-- 
2.14.3
