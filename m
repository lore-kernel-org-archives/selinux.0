Message-ID: <41E2FEF4.5070604@redhat.com>
Date: Mon, 10 Jan 2005 17:17:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Added is_context_configurable function
Content-Type: multipart/mixed;
 boundary="------------070905030200060904080405"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070905030200060904080405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch defines two functions.

is_context_configurable(scontext) 
This returns if if the context is in the 
/etc/selinux/*/contexts/configurable_contexts file.
0 If not and -1 on error.

Internally this calls get_configurable_context_list which returns a 
contextarray of the contexts of that file.

I have also patched the policy makefile to populate that file, but 
looking for all contexts marked as configurable.

Now I would like to use this function in restorecon/setfiles, so that by 
default they will leave configurable contexts alone.

Dan

is_context_configurable(3) SELinux API 
documentationis_context_configurable(3)



NAME
       is_context_configurable  - check whether context is configurable 
by the
       administrator.

SYNOPSIS
       #include <selinux/selinux.h>

       int is_context_configurable(security_context_t scon);


DESCRIPTION
       is_context_configurable
       This function checks  whether  scon  is  in  the  
/etc/selinux/SELINUX-
       TYPE/context/configurable_contexts  file.  A 
configurable_contexts is a
       file contexts that administrators set on the  file  system  
usually  to
       allow  certain  domains  to share the file content. restorecon 
and set-
       files by default leave these context in place.



RETURN VALUE
       returns 1 if security context is  configurable  or  0  if  it  
is  not.
       returns -1 on error


FILE
       /etc/selinux/SELINUXTYPE/context/configurable_contexts




dwalsh@redhat.com               10 January 2005     
is_context_configurable(3)


--------------070905030200060904080405
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.20.1/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2004-12-03 14:40:05.000000000 -0500
+++ libselinux-1.20.1/include/selinux/selinux.h	2005-01-10 17:12:13.775893740 -0500
@@ -226,6 +226,7 @@
 extern const char *selinux_media_context_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_booleans_path(void);
+extern const char *selinux_configurable_contexts_path(void);
 
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
@@ -242,6 +243,10 @@
 		       const char *filename, 
 		       char *const argv[], char *const envp[]);
 
+/* Returns whether a file context is configurable, and should not 
+   be relabeled . */
+extern int is_context_configurable (security_context_t scontext);
+
 #ifdef __cplusplus
 }
 #endif
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/is_context_configurable.3 libselinux-1.20.1/man/man3/is_context_configurable.3
--- nsalibselinux/man/man3/is_context_configurable.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.20.1/man/man3/is_context_configurable.3	2005-01-10 17:12:39.279014613 -0500
@@ -0,0 +1,22 @@
+.TH "is_context_configurable" "3" "10 January 2005" "dwalsh@redhat.com" "SELinux API documentation"
+.SH "NAME"
+is_context_configurable \- check whether context is configurable by the administrator.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.B int is_context_configurable(security_context_t scon);
+
+.SH "DESCRIPTION"
+.B is_context_configurable
+.br
+This function checks whether scon is in the /etc/selinux/SELINUXTYPE/context/configurable_contexts file.  A configurable_contexts is a file contexts that
+administrators set on the file system usually to allow certain domains to share the file content. restorecon and setfiles by default leave these context in place.
+
+ 
+.SH "RETURN VALUE"
+returns 1 if security context is configurable or 0 if it is not. 
+returns -1 on error
+
+.SH "FILE"
+/etc/selinux/SELINUXTYPE/context/configurable_contexts
+
diff --exclude-from=exclude -N -u -r nsalibselinux/src/file_path_suffixes.h libselinux-1.20.1/src/file_path_suffixes.h
--- nsalibselinux/src/file_path_suffixes.h	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.20.1/src/file_path_suffixes.h	2005-01-10 17:12:13.776893627 -0500
@@ -9,3 +9,4 @@
 S_(BOOLEANS, "/booleans")
 S_(MEDIA_CONTEXTS, "/contexts/files/media")
 S_(REMOVABLE_CONTEXT, "/contexts/removable_context")
+S_(CONFIGURABLE_CONTEXTS, "/contexts/configurable_contexts")
diff --exclude-from=exclude -N -u -r nsalibselinux/src/is_configurable_context.c libselinux-1.20.1/src/is_configurable_context.c
--- nsalibselinux/src/is_configurable_context.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.20.1/src/is_configurable_context.c	2005-01-10 17:12:13.777893514 -0500
@@ -0,0 +1,61 @@
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include <pwd.h>
+#include <selinux/selinux.h>
+
+static int get_configurable_context_list (security_context_t **retlist)
+{
+	FILE *fp;
+	char buf[4097];
+	int ctr=0, i;
+	security_context_t *list=NULL;
+
+	fp = fopen(selinux_configurable_contexts_path(), "r");
+	if (!fp)
+		return -1;
+
+	while (fgets_unlocked(buf, 4096, fp)) {
+		ctr++;
+	}
+	rewind(fp);
+	if (ctr) {
+		list=(security_context_t *) calloc(sizeof(security_context_t *), ctr+1);
+		if (list) {
+		  i=0;
+		  while (fgets_unlocked(buf, 4096, fp)) {
+		    buf[strlen(buf)-1]=0;
+		    list[i++]=(security_context_t) strdup(buf);
+		    if (i>ctr) { 
+		      /* Should never happen */
+		      free(list);
+		      list=NULL;
+		      break;
+		    }
+		  }
+		}
+	}
+	fclose(fp);
+	if (!list)
+		return -1;
+	*retlist=list;
+	return 0;
+}
+
+static security_context_t *configurable_list=NULL;
+
+int is_context_configurable (security_context_t scontext) {
+  int i;
+  if (! configurable_list) {
+    if (get_configurable_context_list(&configurable_list)!=0) 
+      return -1;
+  }
+  
+  for (i = 0; configurable_list[i]; i++) {
+    if (strcmp(configurable_list[i],scontext) == 0) return 1;
+  }
+  return 0;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-1.20.1/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.20.1/src/selinux_config.c	2005-01-10 17:12:13.779893288 -0500
@@ -26,7 +26,8 @@
 #define BOOLEANS          7
 #define MEDIA_CONTEXTS    8
 #define REMOVABLE_CONTEXT 9
-#define NEL               10
+#define CONFIGURABLE_CONTEXTS    10
+#define NEL               11
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -211,6 +212,10 @@
   return get_path(MEDIA_CONTEXTS);
 }
 
+const char *selinux_configurable_contexts_path() {
+  return get_path(CONFIGURABLE_CONTEXTS);
+}
+
 const char *selinux_contexts_path() {
   return get_path(CONTEXTS_DIR);
 }

--------------070905030200060904080405
Content-Type: text/plain;
 name="configurable_contexts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="configurable_contexts"

httpd_sys_content_t
httpd_sys_script_exec_t
httpd_sys_script_ro_t
httpd_sys_script_rw_t
httpd_sys_script_ra_t
ftpd_anon_t
samba_share_t

--------------070905030200060904080405--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
