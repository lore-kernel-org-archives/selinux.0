Message-ID: <4717A396.6070409@tycho.nsa.gov>
Date: Thu, 18 Oct 2007 14:19:02 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: add "event" type to X contexts backend
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds an event type to the X contexts backend, so that
X Flask module can support labeling events based on their protocol
name.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 include/selinux/label.h |    1 +
 src/label_x.c           |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)


Index: libselinux/include/selinux/label.h
===================================================================
--- libselinux/include/selinux/label.h	(revision 2660)
+++ libselinux/include/selinux/label.h	(working copy)
@@ -111,6 +111,7 @@
 #define SELABEL_X_PROP		1
 #define SELABEL_X_EXT		2
 #define SELABEL_X_CLIENT	3
+#define SELABEL_X_EVENT		4
 
 
 #ifdef __cplusplus
Index: libselinux/src/label_x.c
===================================================================
--- libselinux/src/label_x.c	(revision 2660)
+++ libselinux/src/label_x.c	(working copy)
@@ -65,9 +65,11 @@
 			data->spec_arr[data->nspec].type = SELABEL_X_EXT;
 		else if (!strcmp(type, "client"))
 			data->spec_arr[data->nspec].type = SELABEL_X_CLIENT;
+		else if (!strcmp(type, "event"))
+			data->spec_arr[data->nspec].type = SELABEL_X_EVENT;
 		else {
 			selinux_log(SELINUX_WARNING,
-				    "%s:  line %d has invalid file type %s\n",
+				    "%s:  line %d has invalid object type %s\n",
 				    path, lineno, type);
 			return 0;
 		}


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
