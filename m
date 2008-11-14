Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAEMQlKE016965
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2008 17:26:47 -0500
Message-ID: <491DFB26.5050703@tycho.nsa.gov>
Date: Fri, 14 Nov 2008 17:26:46 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Ted X Toth <txtoth@gmail.com>
Subject: [PATCH] libselinux: allow shell-style wildcarding in X names
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch replaces the exact strcmp/single fixed wildcard in the X
contexts code with a call to fnmatch(3) which will allow shell-style
matching constructions (*, ?, and []) in the x_contexts file, such as:

property XT_SELECTION* system_u:object_r:clipboard_xproperty_t:s0

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 label_x.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index 6a190f5..a9bfaa5 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -11,6 +11,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <limits.h>
+#include <fnmatch.h>
 #include "callbacks.h"
 #include "label_internal.h"
 
@@ -199,9 +200,7 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 	for (i = 0; i < data->nspec; i++) {
 		if (spec_arr[i].type != type)
 			continue;
-		if (!strncmp(spec_arr[i].key, "*", 2))
-			break;
-		if (!strncmp(spec_arr[i].key, key, strlen(key) + 1))
+		if (!fnmatch(spec_arr[i].key, key, 0))
 			break;
 	}
 



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
