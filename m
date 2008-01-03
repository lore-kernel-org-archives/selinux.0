Message-Id: <20080103184516.021126898@tresys.com>
References: <20080103184331.485176161@tresys.com>
Date: Thu, 03 Jan 2008 13:43:36 -0500
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Cc: method@madmethod.com, sds@tycho.nsa.gov
Subject: [patch 5/7] quiet libsepol uninitialized variable warnings
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix some gcc warnings about uninitialized variables.
For genusers.c, BADLINE() was being used inside an inner
loop that prevented it from working for those two cases.

---
 libsepol/src/genusers.c  |    7 +++++--
 libsepol/src/hierarchy.c |   11 ++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

Index: trunk/libsepol/src/genusers.c
===================================================================
--- trunk.orig/libsepol/src/genusers.c
+++ trunk/libsepol/src/genusers.c
@@ -117,17 +117,18 @@ static int load_users(struct policydb *p
 		} else
 			islist = 0;
 
+		oldc = 0;
 		do {
 			while (*p && isspace(*p))
 				p++;
 			if (!(*p))
-				BADLINE();
+				break;
 
 			q = p;
 			while (*p && *p != ';' && *p != '}' && !isspace(*p))
 				p++;
 			if (!(*p))
-				BADLINE();
+				break;
 			if (*p == '}')
 				islist = 0;
 			oldc = *p;
@@ -153,6 +154,8 @@ static int load_users(struct policydb *p
 					}
 			}
 		} while (islist);
+		if (oldc == 0)
+			BADLINE();
 
 		if (policydb->mls) {
 			context_struct_t context;
Index: trunk/libsepol/src/hierarchy.c
===================================================================
--- trunk.orig/libsepol/src/hierarchy.c
+++ trunk/libsepol/src/hierarchy.c
@@ -130,7 +130,7 @@ static int check_avtab_hierarchy_callbac
 	avtab_key_t key;
 	avtab_datum_t *avdatump;
 	hierarchy_args_t *a;
-	uint32_t av;
+	uint32_t av = 0;
 	type_datum_t *t = NULL, *t2 = NULL;
 
 	if (!(k->specified & AVTAB_ALLOWED)) {
@@ -164,8 +164,7 @@ static int check_avtab_hierarchy_callbac
 				return 0;
 			}
 			av = avdatump->data;
-		} else
-			av = 0;
+		}
 		if (a->opt_cond_list) {
 			/* if a conditional list is present search it before continuing */
 			avdatump = cond_av_list_search(&key, a->opt_cond_list);
@@ -202,8 +201,7 @@ static int check_avtab_hierarchy_callbac
 				return 0;
 			}
 			av = avdatump->data;
-		} else
-			av = 0;
+		}
 		if (a->opt_cond_list) {
 			/* if a conditional list is present search it before continuing */
 			avdatump = cond_av_list_search(&key, a->opt_cond_list);
@@ -228,8 +226,7 @@ static int check_avtab_hierarchy_callbac
 				return 0;
 			}
 			av = avdatump->data;
-		} else
-			av = 0;
+		}
 		if (a->opt_cond_list) {
 			/* if a conditional list is present search it before continuing */
 			avdatump = cond_av_list_search(&key, a->opt_cond_list);

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
