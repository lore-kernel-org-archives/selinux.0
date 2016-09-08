Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u88KVIH5001789
 for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2016 16:31:21 -0400
Received: by mail-pa0-f48.google.com with SMTP id to9so20578045pac.1
 for <selinux@tycho.nsa.gov>; Thu, 08 Sep 2016 13:31:19 -0700 (PDT)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jwcart2@tycho.nsa.gov, jeffv@google.com,
 dcashman <dcashman@android.com>
Subject: [PATCH 3/5] libsepol: cil: Replace sensitivityorder statement.
Date: Thu,  8 Sep 2016 13:30:50 -0700
Message-Id: <1473366652-23929-4-git-send-email-dcashman@android.com>
In-Reply-To: <1473366652-23929-3-git-send-email-dcashman@android.com>
References: <1473366652-23929-1-git-send-email-dcashman@android.com>
 <1473366652-23929-2-git-send-email-dcashman@android.com>
 <1473366652-23929-3-git-send-email-dcashman@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: dcashman <dcashman@android.com>

cil_gen_policy() prints a sensitivityorder{}; output statement when
generating its policy.conf file from CIL policy.  This omits the
sensitivity declarations, however, and should instead be represented as
a sid declaration block followed by a dominance statement.

Signed-off-by: Daniel Cashman <dcashman@android.com>
---
 libsepol/cil/src/cil_policy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index d8ef151..78b135e 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1301,11 +1301,14 @@ int cil_gen_policy(struct cil_db *db)
 	}
 
 	if (db->sensitivityorder->head != NULL) {
-		fprintf(file_arr[SENS], "sensitivityorder { ");
+		cil_list_for_each(item, db->sensitivityorder) {
+			fprintf(file_arr[SENS], "sensitivity %s;\n", ((struct cil_sens*)item->data)->datum.name);
+		}
+		fprintf(file_arr[SENS], "dominance { ");
 		cil_list_for_each(item, db->sensitivityorder) {
 			fprintf(file_arr[SENS], "%s ", ((struct cil_sens*)item->data)->datum.name);
 		}
-		fprintf(file_arr[SENS], "};\n");
+		fprintf(file_arr[SENS], "}\n");
 	}
 
 	extra_args.users = users;
-- 
2.8.0.rc3.226.g39d4020
