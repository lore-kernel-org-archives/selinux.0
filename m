Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2UGARUI002203
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2011 12:10:28 -0400
Received: from nm17-vm0.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p2UGAQXg011729
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2011 16:10:26 GMT
Message-ID: <299285.67235.qm@web87002.mail.ird.yahoo.com>
Date: Wed, 30 Mar 2011 17:10:05 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: =?utf-8?B?W1BBVENIIDEvMV0gbWFwcGluZyBmaXggZm9yIGludmFsaWQgY2xhc3MvcGVy?=
 =?utf-8?B?bXMgYWZ0ZXIgc2VsaW51eF9zZXRfbWFwcGluZyBjYWxs4oCP?=
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please find another libselinux patch. I've tested quite extensively with the compute_av and string functions with and without mapping and seems okay.  

The patch covers:
When selinux_set_mapping(3) is used to set the class and permissions allowed by an object manager, then an invalid class and/or permissions are selected (e.g. using security_class_to_string), then mapping.c in libselinux forces an assert. This patch removes the asserts and allows the functions to return a class/perm of 0 (unknown) with errno set to EINVAL. A minor patch to set EINVAL in security_av_perm_to_string_compat is also included. All the functions to convert perms & classes to strings and back should now return the correct errno with or without mapping enabled.


---
 libselinux/src/mapping.c   |   41 ++++++++++++++++++++++++++++-------------
 libselinux/src/stringrep.c |    4 +++-
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
index f9858ce..5bbb450 100644
--- a/libselinux/src/mapping.c
+++ b/libselinux/src/mapping.c
@@ -6,7 +6,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
-#include <assert.h>
 #include <selinux/selinux.h>
 #include <selinux/avc.h>
 #include "mapping.h"
@@ -103,8 +102,13 @@ unmap_class(security_class_t tclass)
 	if (tclass < current_mapping_size)
 		return current_mapping[tclass].value;
 
-	assert(current_mapping_size == 0);
-	return tclass;
+	/* If here no mapping set or the class requested is not valid. */
+	if (current_mapping_size != 0) {
+		errno = EINVAL;
+		return 0;
+	}
+	else
+		return tclass;
 }
 
 access_vector_t
@@ -116,16 +120,19 @@ unmap_perm(security_class_t tclass, access_vector_t tperm)
 
 		for (i=0; i<current_mapping[tclass].num_perms; i++)
 			if (tperm & (1<<i)) {
-				assert(current_mapping[tclass].perms[i]);
 				kperm |= current_mapping[tclass].perms[i];
 				tperm &= ~(1<<i);
 			}
-		assert(tperm == 0);
 		return kperm;
 	}
 
-	assert(current_mapping_size == 0);
-	return tperm;
+	/* If here no mapping set or the perm requested is not valid. */
+	if (current_mapping_size != 0) {
+		errno = EINVAL;
+		return 0;
+	}
+	else
+		return tperm;
 }
 
 /*
@@ -141,8 +148,13 @@ map_class(security_class_t kclass)
 		if (current_mapping[i].value == kclass)
 			return i;
 
-	assert(current_mapping_size == 0);
-	return kclass;
+/* If here no mapping set or the class requested is not valid. */
+	if (current_mapping_size != 0) {
+		errno = EINVAL;
+		return 0;
+	}
+	else	
+		return kclass;
 }
 
 access_vector_t
@@ -157,11 +169,14 @@ map_perm(security_class_t tclass, access_vector_t kperm)
 				tperm |= 1<<i;
 				kperm &= ~current_mapping[tclass].perms[i];
 			}
-		assert(kperm == 0);
-		return tperm;
-	}
 
-	assert(current_mapping_size == 0);
+		if (tperm == 0) {
+			errno = EINVAL;
+			return 0;
+		}
+		else
+			return tperm;
+	}
 	return kperm;
 }
 
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index b19bce7..f0167e7 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -401,8 +401,10 @@ static const char *security_av_perm_to_string_compat(security_class_t tclass,
 	access_vector_t common_base = 0;
 	unsigned int i;
 
-	if (!av)
+	if (!av) {
+		errno = EINVAL;
 		return NULL;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(av_inherit); i++) {
 		if (av_inherit[i].tclass == tclass) {
-- 
1.7.3.2



Richard



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
