Message-ID: <47A8D586.7080202@tycho.nsa.gov>
Date: Tue, 05 Feb 2008 16:30:46 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: add "poly_property" type to X contexts backend
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a poly_property type to the X contexts backend, so that 
the X Flask module can be informed which properties to polyinstantiate.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 include/selinux/label.h |    1 +
 src/label_x.c           |    2 ++
 2 files changed, 3 insertions(+)


Index: libselinux/include/selinux/label.h
===================================================================
--- libselinux/include/selinux/label.h	(revision 2789)
+++ libselinux/include/selinux/label.h	(working copy)
@@ -113,6 +113,7 @@
 #define SELABEL_X_CLIENT	3
 #define SELABEL_X_EVENT		4
 #define SELABEL_X_SELN		5
+#define SELABEL_X_POLYPROP	6
 
 
 #ifdef __cplusplus
Index: libselinux/src/label_x.c
===================================================================
--- libselinux/src/label_x.c	(revision 2789)
+++ libselinux/src/label_x.c	(working copy)
@@ -69,6 +69,8 @@
 			data->spec_arr[data->nspec].type = SELABEL_X_EVENT;
 		else if (!strcmp(type, "selection"))
 			data->spec_arr[data->nspec].type = SELABEL_X_SELN;
+		else if (!strcmp(type, "poly_property"))
+			data->spec_arr[data->nspec].type = SELABEL_X_POLYPROP;
 		else {
 			selinux_log(SELINUX_WARNING,
 				    "%s:  line %d has invalid object type %s\n",

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
