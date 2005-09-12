Message-ID: <4325A695.8050802@redhat.com>
Date: Mon, 12 Sep 2005 12:02:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <SELinux@tycho.nsa.gov>
Subject: After talking to some people at Red Hat, they feal the translation
 library should be plugable
Content-Type: multipart/mixed;
 boundary="------------040305050800050905090107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040305050800050905090107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Also it should be based off policy.  So this patch to libselinux will 
use the policy type to find the translation library.  Also libsetrans 
will now be in /lib/selinux.

I have modified the libsetrans library to link libtargeted.so.0 and 
libstrict.so.0 to libsetrans.so.0.   MLS Policy would obviously install 
their own policy for MITRE Librarie or whatever.

Thoughts...

Next step to get MCS will be to change libselinux get_default_context to 
use pluggable module to get categories for a user.  Should we use same 
library?

Currenly MCS policy defaults all users to s0-s0:c0.c127, we need to 
allow admin to specify users categories.


Dan

-- 



--------------040305050800050905090107
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.25.7/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2005-09-01 11:17:40.000000000 -0400
+++ libselinux-1.25.7/include/selinux/selinux.h	2005-09-12 11:33:32.000000000 -0400
@@ -304,6 +304,12 @@
 extern int selinux_getenforcemode(int *enforce);
 
 /*
+  selinux_gettype reads the /etc/selinux/config file and determines 
+  whether the policy tyep for this machine, type must be freed.
+ */
+extern void selinux_gettype(char **type);
+
+/*
   selinux_policy_root reads the /etc/selinux/config file and returns 
   the directory path under which the compiled policy file and context 
   configuration files exist.
diff --exclude-from=exclude -N -u -r nsalibselinux/src/init.c libselinux-1.25.7/src/init.c
--- nsalibselinux/src/init.c	2005-09-01 13:21:11.000000000 -0400
+++ libselinux-1.25.7/src/init.c	2005-09-12 11:36:33.000000000 -0400
@@ -8,6 +8,7 @@
 #include <asm/page.h>
 #include <stdio.h>
 #include <dlfcn.h>
+#include <limits.h>
 
 #include "dso.h"
 #include "policy.h"
@@ -85,9 +86,14 @@
 static void init_translations(void)
 {
 #ifdef SHARED
+	char *path[PATH_MAX];
+	char *type=NULL;
 	int (*lib_trans_init)(void) = NULL;
-
-	translation_lib_handle = dlopen("libsetrans.so.0", RTLD_NOW);
+	selinux_gettype(&type);
+	if (!type) return;
+	snprintf(path, PATH_MAX-1, "/lib/selinux/lib%s.so.0", type);
+	free(type);
+	translation_lib_handle = dlopen(path, RTLD_NOW);
 	if (!translation_lib_handle)
 		return;
 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-1.25.7/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2005-03-17 14:56:21.000000000 -0500
+++ libselinux-1.25.7/src/selinux_config.c	2005-09-12 11:35:35.000000000 -0400
@@ -85,6 +85,28 @@
 
 static int use_compat_file_path;
 
+void selinux_gettype(char **rtype) {
+	char *type=SELINUXDEFAULT;
+	char buf[4097];
+	int len, i;
+	FILE *cfg = fopen(SELINUXCONFIG,"r");
+	if (cfg) {
+		while (fgets_unlocked(buf, 4096, cfg)) {
+			if (strncmp(buf,SELINUXTYPETAG,len)==0) {
+				type=buf+len;
+				break;
+			}
+		}
+		fclose(cfg);
+	}
+	i=strlen(type)-1;
+	while ((i>=0) && 
+	       (isspace(type[i]) || iscntrl(type[i]))) {
+		type[i]=0;
+		i--;
+	}
+	*rtype=strdup(type);
+}
 int selinux_getenforcemode(int *enforce) {
   int ret=-1;
   FILE *cfg = fopen(SELINUXCONFIG,"r");
@@ -122,38 +144,24 @@
 
 static void init_selinux_policyroot(void)
 {
-  char *type=SELINUXDEFAULT;
+  char *type=NULL;
   int i=0, len=sizeof(SELINUXTYPETAG)-1, len2;
-  char buf[4097];
-  FILE *cfg;
   if (selinux_policyroot) return;
   if (access(SELINUXDIR, F_OK) != 0) {
 	  selinux_policyroot = SECURITYDIR;
 	  use_compat_file_path = 1;
 	  return;
   }
-  cfg = fopen(SELINUXCONFIG,"r");
-  if (cfg) {
-    while (fgets_unlocked(buf, 4096, cfg)) {
-      if (strncmp(buf,SELINUXTYPETAG,len)==0) {
-	type=buf+len;
-	break;
-      }
-    }
-    fclose(cfg);
-  }
-  i=strlen(type)-1;
-  while ((i>=0) && 
-	 (isspace(type[i]) || iscntrl(type[i]))) {
-    type[i]=0;
-    i--;
-  }
+  selinux_gettype(&type);
+  if (!type) return;
   len=sizeof(SELINUXDIR) + strlen(type);
   selinux_policyroot=malloc(len);
-  if (!selinux_policyroot)
+  if (!selinux_policyroot) {
+	  free(type);
 	  return;
+  }
   snprintf(selinux_policyroot,len, "%s%s", SELINUXDIR, type);
-  
+  free(type);
   for (i = 0; i < NEL; i++) {
 	  len2 = len + strlen(file_path_suffixes_data.str
 			      + file_path_suffixes_idx[i])+1;

--------------040305050800050905090107--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
