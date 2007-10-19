Message-ID: <471907FA.7090601@tycho.nsa.gov>
Date: Fri, 19 Oct 2007 15:39:38 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: add "event" type to X contexts backend
References: <4717A396.6070409@tycho.nsa.gov>
In-Reply-To: <4717A396.6070409@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is a revised version of the patch that adds not one but two
backends, one for X event names and one for X "selections" which
are the clipboard objects used in cut & paste.

This is so the X Flask module can support labeling these objects
based on their names.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 include/selinux/label.h |    2 ++
 src/label_x.c           |    6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)


Index: libselinux/include/selinux/label.h
===================================================================
--- libselinux/include/selinux/label.h	(revision 2660)
+++ libselinux/include/selinux/label.h	(working copy)
@@ -111,6 +111,8 @@
 #define SELABEL_X_PROP		1
 #define SELABEL_X_EXT		2
 #define SELABEL_X_CLIENT	3
+#define SELABEL_X_EVENT		4
+#define SELABEL_X_SELN		5
 
 
 #ifdef __cplusplus
Index: libselinux/src/label_x.c
===================================================================
--- libselinux/src/label_x.c	(revision 2660)
+++ libselinux/src/label_x.c	(working copy)
@@ -65,9 +65,13 @@
 			data->spec_arr[data->nspec].type = SELABEL_X_EXT;
 		else if (!strcmp(type, "client"))
 			data->spec_arr[data->nspec].type = SELABEL_X_CLIENT;
+		else if (!strcmp(type, "event"))
+			data->spec_arr[data->nspec].type = SELABEL_X_EVENT;
+		else if (!strcmp(type, "selection"))
+			data->spec_arr[data->nspec].type = SELABEL_X_SELN;
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
