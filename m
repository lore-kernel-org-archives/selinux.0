Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QJ7Zgh016818
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 14:07:35 -0500
Received: from web51509.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QJ8vPM000347
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 19:08:57 GMT
Date: Mon, 26 Feb 2007 11:08:56 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: [PATCH] Lazy config init in libselinux
To: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-835192081-1172516936=:57110"
Message-ID: <824347.57110.qm@web51509.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-835192081-1172516936=:57110
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

After running strace a number of times in the other performance patch, I realized
that we are reading a config file in a lot of cases where we don't even use the
results. Example, "ls" opens, reads, and parses /etc/selinux/config and it
doesn't care unless you pass the -Z flag. So...this patch does 2 things. It does
a lazy read of the config file and it moves the check for /etc/security to be a
second class citizen instead of something checked for first. This patch should
make shell scripts run faster.

Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>




 
____________________________________________________________________________________
Bored stiff? Loosen up... 
Download and play hundreds of games for free on Yahoo! Games.
http://games.yahoo.com/games/front
--0-835192081-1172516936=:57110
Content-Type: text/x-patch; name="libselinux-2.0.4-lazy-config.patch"
Content-Description: 2117138420-libselinux-2.0.4-lazy-config.patch
Content-Disposition: inline; filename="libselinux-2.0.4-lazy-config.patch"

diff -urp libselinux-2.0.4.orig/src/selinux_config.c libselinux-2.0.4/src/selinux_config.c
--- libselinux-2.0.4.orig/src/selinux_config.c	2007-02-25 14:52:16.000000000 -0500
+++ libselinux-2.0.4/src/selinux_config.c	2007-02-26 13:32:04.000000000 -0500
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <unistd.h>
+#include <errno.h>
 #include "selinux_internal.h"
 #include "get_default_type_internal.h"
 
@@ -92,6 +93,9 @@ static const uint16_t compat_file_path_i
 #undef L2
 
 static int use_compat_file_path;
+static int init_selinux_config_done;
+static int init_selinux_config(void);
+
 
 int selinux_getenforcemode(int *enforce)
 {
@@ -144,6 +148,10 @@ static char *selinux_policytype;
 
 int selinux_getpolicytype(char **type)
 {
+	if (!init_selinux_config_done) {
+		if (init_selinux_config() < 0)
+			return -1;
+	}
 	if (!selinux_policytype)
 		return -1;
 	*type = strdup(selinux_policytype);
@@ -155,9 +163,8 @@ hidden_def(selinux_getpolicytype)
 static char *selinux_policyroot = NULL;
 static char *selinux_rootpath = NULL;
 
-static void init_selinux_config(void) __attribute__ ((constructor));
 
-static void init_selinux_config(void)
+static int init_selinux_config(void)
 {
 	int i, *intptr;
 	size_t line_len;
@@ -166,13 +173,7 @@ static void init_selinux_config(void)
 	FILE *fp;
 
 	if (selinux_policyroot)
-		return;
-	if (access(SELINUXDIR, F_OK) != 0) {
-		selinux_policyroot = SECURITYDIR;
-		selinux_rootpath = SECURITYDIR;
-		use_compat_file_path = 1;
-		return;
-	}
+		return 0;
 
 	selinux_rootpath = SELINUXDIR;
 	fp = fopen(SELINUXCONFIG, "r");
@@ -192,7 +193,7 @@ static void init_selinux_config(void)
 				selinux_policytype = type =
 				    strdup(buf_p + sizeof(SELINUXTYPETAG) - 1);
 				if (!type)
-					return;
+					return -1;
 				end = type + strlen(type) - 1;
 				while ((end > type) &&
 				       (isspace(*end) || iscntrl(*end))) {
@@ -226,16 +227,22 @@ static void init_selinux_config(void)
 		}
 		free(line_buf);
 		fclose(fp);
+	} else if (errno == ENOENT && access(SECURITYDIR, F_OK) == 0) {
+		selinux_policyroot = SECURITYDIR;
+		selinux_rootpath = SECURITYDIR;
+		use_compat_file_path = 1;
+		init_selinux_config_done = 1;
+		return 0;
 	}
 
 	if (!type) {
 		selinux_policytype = type = strdup(SELINUXDEFAULT);
 		if (!type)
-			return;
+			return -1;
 	}
 
 	if (asprintf(&selinux_policyroot, "%s%s", SELINUXDIR, type) == -1)
-		return;
+		return -1;
 
 	for (i = 0; i < NEL; i++)
 		if (asprintf(&file_paths[i], "%s%s",
@@ -243,8 +250,10 @@ static void init_selinux_config(void)
 			     file_path_suffixes_data.str +
 			     file_path_suffixes_idx[i])
 		    == -1)
-			return;
+			return -1;
 	use_compat_file_path = 0;
+	init_selinux_config_done = 1;
+	return 0;
 }
 
 static void fini_selinux_policyroot(void) __attribute__ ((destructor));
@@ -268,6 +277,10 @@ static void fini_selinux_policyroot(void
 
 static const char *get_path(int idx)
 {
+	if (!init_selinux_config_done) {
+		if (init_selinux_config() < 0)
+			return NULL;
+	}
 	if (!use_compat_file_path)
 		return file_paths[idx];
 
@@ -283,11 +296,19 @@ hidden_def(selinux_default_type_path)
 
 const char *selinux_policy_root()
 {
+	if (!init_selinux_config_done) {
+		if (init_selinux_config() < 0)
+			return NULL;
+	}
 	return selinux_policyroot;
 }
 
 const char *selinux_path()
 {
+	if (!init_selinux_config_done) {
+		if (init_selinux_config() < 0)
+			return NULL;
+	}
 	return selinux_rootpath;
 }
 

--0-835192081-1172516936=:57110--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
