Message-ID: <432B2B68.5030006@redhat.com>
Date: Fri, 16 Sep 2005 16:30:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Doing testing with MCS looks like we get initial roles/levels
 by using fromcon.
References: <4329DF91.2060208@redhat.com>	 <1126873821.25919.20.camel@moss-spartans.epoch.ncsc.mil>	 <432AFFE4.3010001@redhat.com>	 <1126894521.27393.81.camel@moss-spartans.epoch.ncsc.mil>	 <432B1157.8070703@redhat.com>	 <1126896683.27393.100.camel@moss-spartans.epoch.ncsc.mil>	 <432B1BAC.9000800@redhat.com> <1126899285.27393.129.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126899285.27393.129.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------060705000505080404030004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060705000505080404030004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ok how about this patch for libselinux.

Includes STRIP_LEVEL for removing :s0* from matchpathcon if non MLS 
system.   This is needed for upgrading machines to MCS/MLS

Added selinux_getpolicytype(), even though not used yet by external 
apps, it could be used in the future.

Added  int get_ordered_context_list_with_level (const char *user,
                                        const char *level,
                                        security_context_t fromcon,
                                        security_context_t **list)

-- 



--------------060705000505080404030004
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.26/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2005-09-01 11:17:40.000000000 -0400
+++ libselinux-1.26/include/selinux/selinux.h	2005-09-16 14:16:26.000000000 -0400
@@ -304,6 +304,12 @@
 extern int selinux_getenforcemode(int *enforce);
 
 /*
+  selinux_getpolicytype reads the /etc/selinux/config file and determines 
+  whether the policy tyep for this machine, type must be freed.
+ */
+extern void selinux_getpolicytype(char **type);
+
+/*
   selinux_policy_root reads the /etc/selinux/config file and returns 
   the directory path under which the compiled policy file and context 
   configuration files exist.
diff --exclude-from=exclude -N -u -r nsalibselinux/src/get_context_list.c libselinux-1.26/src/get_context_list.c
--- nsalibselinux/src/get_context_list.c	2005-08-11 22:41:15.000000000 -0400
+++ libselinux-1.26/src/get_context_list.c	2005-09-16 16:22:03.000000000 -0400
@@ -288,6 +288,40 @@
 	return strcmp(c1->con, c2->con);
 }
 
+int get_ordered_context_list_with_level (const char *user, 
+					 const char *level, 
+					 security_context_t fromcon, 
+					 security_context_t **list)
+{
+    int rc;
+    int freefrom = 0;
+    context_t con;
+
+    if (!level) 
+	    return get_ordered_context_list (user, fromcon, list);
+
+    if (!fromcon) {
+	rc = getcon(&fromcon);
+	if (rc < 0)
+		return rc;
+	freefrom = 1;
+    }
+
+    con=context_new(fromcon);
+    if (con) {
+	    context_range_set(con, level);
+	    rc = get_ordered_context_list (user, context_str(con), list);
+	    context_free(con);
+    } 
+    else
+	    rc=-1;
+
+    if (freefrom) 
+	    freecon(fromcon);
+
+    return rc;
+}
+
 int get_ordered_context_list (const char *user, 
 			      security_context_t fromcon, 
 			      security_context_t **list)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchpathcon.c libselinux-1.26/src/matchpathcon.c
--- nsalibselinux/src/matchpathcon.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.26/src/matchpathcon.c	2005-09-16 15:54:01.000000000 -0400
@@ -12,6 +12,7 @@
 #include <regex.h>
 #include <stdarg.h>
 #include "policy.h"
+#include <selinux/context.h>
 
 static void 
 #ifdef __GNUC__
@@ -25,6 +26,19 @@
 	va_end(ap);
 }
 
+#define STRIP_LEVEL(CON)      \
+		if (! mls_enabled) { \
+			security_context_t newcon;	\
+			context_t con=context_new(CON); \
+			if (con) {			\
+			context_range_set(con,NULL);	\
+			newcon=strdup(context_str(con));\
+			context_free(con);		\
+			freecon(CON);			\
+			CON=newcon;			\
+			}				\
+		}
+
 static void (*myprintf)(const char *fmt, ...) = &default_printf;
 
 void set_matchpathcon_printf(void (*f)(const char *fmt, ...))
@@ -415,7 +429,7 @@
 	}
 	return;
 }
-static int process_line( const char *path, char *line_buf, int pass, unsigned lineno) {
+static int process_line( const char *path, char *line_buf, int pass, unsigned lineno, int mls_enabled) {
 	int items, len, regerr;
 	char *buf_p;
 	char *regex, *type, *context;
@@ -438,6 +452,7 @@
 	} else if (items == 2) {
 		/* The type field is optional. */
 		free(context);
+		STRIP_LEVEL(type)
 		context = type;
 		type = 0;
 	}
@@ -510,7 +525,7 @@
 		}
 		
 	skip_type:
-		
+		STRIP_LEVEL(context)
 		spec_arr[nspec].context = context;
 		
 		if (strcmp(context, "<<none>>")) {
@@ -557,6 +572,7 @@
 	unsigned int lineno, pass, i, j, maxnspec;
 	spec_t *spec_copy=NULL;
 	int status=-1;
+	int mls_enabled=is_selinux_mls_enabled();
 
 	/* Open the specification file. */
 	if (!path)
@@ -590,20 +606,20 @@
 		lineno = 0;
 		nspec = 0;
 		while (getline(&line_buf, &line_len, fp) > 0 && nspec < maxnspec) {
-			if (process_line(path, line_buf, pass, ++lineno) != 0)
+			if (process_line(path, line_buf, pass, ++lineno, mls_enabled) != 0)
 				goto finish;
 		}
 		lineno = 0;
 		if (homedirfp) 
 			while (getline(&line_buf, &line_len, homedirfp) > 0 && nspec < maxnspec) {
-				if (process_line(homedir_path, line_buf, pass, ++lineno) != 0)
+				if (process_line(homedir_path, line_buf, pass, ++lineno, mls_enabled) != 0)
 					goto finish;
 			}
 
 		lineno = 0;
 		if (localfp) 
 			while (getline(&line_buf, &line_len, localfp) > 0 && nspec < maxnspec) {
-				if (process_line(local_path, line_buf, pass, ++lineno) != 0)
+				if (process_line(local_path, line_buf, pass, ++lineno, mls_enabled) != 0)
 					goto finish;
 			}
 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-1.26/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2005-03-17 14:56:21.000000000 -0500
+++ libselinux-1.26/src/selinux_config.c	2005-09-16 14:16:26.000000000 -0400
@@ -85,6 +85,29 @@
 
 static int use_compat_file_path;
 
+void selinux_getpolicytype(char **rtype) {
+	char *type=SELINUXDEFAULT;
+	char buf[4097];
+	int i=0;
+	int len=sizeof(SELINUXTYPETAG)-1;
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
@@ -122,38 +145,24 @@
 
 static void init_selinux_policyroot(void)
 {
-  char *type=SELINUXDEFAULT;
-  int i=0, len=sizeof(SELINUXTYPETAG)-1, len2;
-  char buf[4097];
-  FILE *cfg;
+  char *type=NULL;
+  int i=0, len, len2;
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
+  selinux_getpolicytype(&type);
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

--------------060705000505080404030004--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
