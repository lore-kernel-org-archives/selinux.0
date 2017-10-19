Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9JNnVDY018908
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 19:49:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 3yJ5Hs50dWz1wyKZ
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 23:49:29 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 3yJ5Hs3ZHdz1wyKW
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 23:49:29 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id b6so8302728pfh.7
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 16:49:27 -0700 (PDT)
From: Jaekyun Seok <jaekyun@google.com>
To: selinux@tycho.nsa.gov
Cc: Jaekyun Seok <jaekyun@google.com>
Date: Fri, 20 Oct 2017 08:49:15 +0900
Message-Id: <20171019234915.21820-1-jaekyun@google.com>
Subject: [PATCH] libselinux: android: support exact match for a property key
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Performs exact match if a property key of property contexts ends with '$'
instead of prefix match.

This will enable to define an exact rule which can avoid unexpected
context assignment.

Signed-off-by: Jaekyun Seok <jaekyun@google.com>
---
 libselinux/src/label_backends_android.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index cb8aae26..4611d396 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -258,8 +258,13 @@ static struct selabel_lookup_rec *property_lookup(struct selabel_handle *rec,
 	}
 
 	for (i = 0; i < data->nspec; i++) {
-		if (strncmp(spec_arr[i].property_key, key,
-			    strlen(spec_arr[i].property_key)) == 0) {
+		size_t property_key_len = strlen(spec_arr[i].property_key);
+		if (spec_arr[i].property_key[property_key_len - 1] == '$' &&
+		    strlen(key) == property_key_len - 1 &&
+		    strncmp(spec_arr[i].property_key, key, property_key_len - 1) == 0) {
+			break;
+		}
+		if (strncmp(spec_arr[i].property_key, key, property_key_len) == 0) {
 			break;
 		}
 		if (strncmp(spec_arr[i].property_key, "*", 1) == 0)
-- 
2.15.0.rc0.271.g36b669edcc-goog
