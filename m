Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w25N0940005656
 for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2018 18:00:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 3zwFjh2zdbz25RCp
 for <selinux@tycho.nsa.gov>; Mon,  5 Mar 2018 23:00:08 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 3zwFjh2MM0z25RCm
 for <selinux@tycho.nsa.gov>; Mon,  5 Mar 2018 23:00:08 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 18E2F561291
 for <selinux@tycho.nsa.gov>; Mon,  5 Mar 2018 23:58:32 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Mon,  5 Mar 2018 23:58:20 +0100
Message-Id: <20180305225820.23610-3-nicolas.iooss@m4x.org>
In-Reply-To: <20180305225820.23610-1-nicolas.iooss@m4x.org>
References: <20180305225820.23610-1-nicolas.iooss@m4x.org>
Subject: [PATCH 3/3] libsemanage: silence clang static analyzer
 report
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

clang's static analyzer reports an out-of-bound array access in
semanage_user_roles() when num_roles is zero, with the following
statement:

    strcpy(roles,roles_arr[0]);

When num_roles is zero, roles_arr[0] is not uninitialized and roles is
the result of malloc(0) so this strcpy is dangerous. Make
semanage_user_roles() return an empty string instead.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/seusers_local.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
index 42c3a8b662c2..413ebdddeb34 100644
--- a/libsemanage/src/seusers_local.c
+++ b/libsemanage/src/seusers_local.c
@@ -35,12 +35,16 @@ static char *semanage_user_roles(semanage_handle_t * handle, const char *sename)
 				for (i = 0; i<num_roles; i++) {
 					size += (strlen(roles_arr[i]) + 1);
 				}
-				roles = malloc(size);
-				if (roles) {
-					strcpy(roles,roles_arr[0]);
-					for (i = 1; i<num_roles; i++) {
-						strcat(roles,",");
-						strcat(roles,roles_arr[i]);
+				if (num_roles == 0) {
+					roles = strdup("");
+				} else {
+					roles = malloc(size);
+					if (roles) {
+						strcpy(roles,roles_arr[0]);
+						for (i = 1; i<num_roles; i++) {
+							strcat(roles,",");
+							strcat(roles,roles_arr[i]);
+						}
 					}
 				}
 			}
-- 
2.16.0
