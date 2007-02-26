Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QNK9fa027774
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 18:20:09 -0500
Received: from web51509.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QNLUH7014383
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 23:21:30 GMT
Date: Mon, 26 Feb 2007 15:21:29 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] Lazy config init in libselinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1172524723.19041.286.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-717305304-1172532089=:57299"
Message-ID: <533629.57299.qm@web51509.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-717305304-1172532089=:57299
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

>Not familiar with it - enlighten me.  How does it differ from a
>constructor?  How does it work?

Its a wrapper around pthread_once. pthread_once gurantees that something gets
executed only one time; IOW it can be used as an on-demand constructor.
libselinux does not need to link against pthreads, so that does not change.
Here's the tested patch.

I added the following audit rule "-w /etc/selinux/config -k selinux-config". Then
rebooted and run "ausearch --start recent -k selinux-config --raw | aureport
-executable --summary" to see which programs were accessing selinux config files.
You might have to adjust your start time instead of using "recent". But anyways
it does cut the use. The speedup varies with the work load. I think things that
are heavy in ls, cp, mv, mount, id, find, etc are likely to have the most
benefit.

-Steve


 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com
--0-717305304-1172532089=:57299
Content-Type: text/x-patch; name="libselinux-2.0.4-lazy-config.patch"
Content-Description: 2117138420-libselinux-2.0.4-lazy-config.patch
Content-Disposition: inline; filename="libselinux-2.0.4-lazy-config.patch"

diff -urp libselinux-2.0.4.orig/src/selinux_config.c libselinux-2.0.4/src/selinux_config.c
--- libselinux-2.0.4.orig/src/selinux_config.c	2007-02-25 14:52:16.000000000 -0500
+++ libselinux-2.0.4/src/selinux_config.c	2007-02-26 18:01:58.000000000 -0500
@@ -7,8 +7,10 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <unistd.h>
+#include <errno.h>
 #include "selinux_internal.h"
 #include "get_default_type_internal.h"
+#include <bits/libc-lock.h>
 
 #define SELINUXDIR "/etc/selinux/"
 #define SELINUXCONFIG SELINUXDIR "config"
@@ -93,6 +95,11 @@ static const uint16_t compat_file_path_i
 
 static int use_compat_file_path;
 
+/* Protect the configuration variables */
+__libc_once_define(static, once);
+static void init_selinux_config(void);
+
+
 int selinux_getenforcemode(int *enforce)
 {
 	int ret = -1;
@@ -144,6 +151,8 @@ static char *selinux_policytype;
 
 int selinux_getpolicytype(char **type)
 {
+	__libc_once(once, init_selinux_config);
+
 	if (!selinux_policytype)
 		return -1;
 	*type = strdup(selinux_policytype);
@@ -155,7 +164,6 @@ hidden_def(selinux_getpolicytype)
 static char *selinux_policyroot = NULL;
 static char *selinux_rootpath = NULL;
 
-static void init_selinux_config(void) __attribute__ ((constructor));
 
 static void init_selinux_config(void)
 {
@@ -167,12 +175,6 @@ static void init_selinux_config(void)
 
 	if (selinux_policyroot)
 		return;
-	if (access(SELINUXDIR, F_OK) != 0) {
-		selinux_policyroot = SECURITYDIR;
-		selinux_rootpath = SECURITYDIR;
-		use_compat_file_path = 1;
-		return;
-	}
 
 	selinux_rootpath = SELINUXDIR;
 	fp = fopen(SELINUXCONFIG, "r");
@@ -226,6 +228,11 @@ static void init_selinux_config(void)
 		}
 		free(line_buf);
 		fclose(fp);
+	} else if (errno == ENOENT && access(SECURITYDIR, F_OK) == 0) {
+		selinux_policyroot = SECURITYDIR;
+		selinux_rootpath = SECURITYDIR;
+		use_compat_file_path = 1;
+		return;
 	}
 
 	if (!type) {
@@ -268,6 +275,7 @@ static void fini_selinux_policyroot(void
 
 static const char *get_path(int idx)
 {
+	__libc_once(once, init_selinux_config);
 	if (!use_compat_file_path)
 		return file_paths[idx];
 
@@ -283,11 +291,13 @@ hidden_def(selinux_default_type_path)
 
 const char *selinux_policy_root()
 {
+	__libc_once(once, init_selinux_config);
 	return selinux_policyroot;
 }
 
 const char *selinux_path()
 {
+	__libc_once(once, init_selinux_config);
 	return selinux_rootpath;
 }
 

--0-717305304-1172532089=:57299--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
