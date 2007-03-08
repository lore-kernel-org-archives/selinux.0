Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28DUb1J001787
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 08:30:37 -0500
Received: from web51511.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l28DW4Ha021022
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 13:32:04 GMT
Date: Thu, 8 Mar 2007 05:31:19 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] Dropping compat support for /etc/security policy file paths
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1173358485.10467.4.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-998643964-1173360679=:8281"
Message-ID: <204313.8281.qm@web51511.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-998643964-1173360679=:8281
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

>> >Are any active distributions still using the old /etc/security/ location
>> >and layout for SELinux policy files?  If not, we could drop the compat
>> >file path support from libselinux on the trunk.
>> 
>> Here's a patch dropping support.
>
>+#define SECURITYCONFIG "/etc/sysconfig/selinux"
>
>I think we can drop this altogether, along with the use of it

Sure. New patch attached.

-Steve


 
____________________________________________________________________________________
Food fight? Enjoy some healthy debate 
in the Yahoo! Answers Food & Drink Q&A.
http://answers.yahoo.com/dir/?link=list&sid=396545367
--0-998643964-1173360679=:8281
Content-Type: text/x-patch; name="libselinux-2.0.4-compat.patch"
Content-Description: 566132708-libselinux-2.0.4-compat.patch
Content-Disposition: inline; filename="libselinux-2.0.4-compat.patch"

diff -urpN libselinux-2.0.4.orig/src/compat_file_path.h libselinux-2.0.4/src/compat_file_path.h
--- libselinux-2.0.4.orig/src/compat_file_path.h	2007-02-25 14:52:16.000000000 -0500
+++ libselinux-2.0.4/src/compat_file_path.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,12 +0,0 @@
-/* Compatibility file name suffixes.  */
-S_(BINPOLICY, SECURITYDIR "/selinux/policy")
-    S_(CONTEXTS_DIR, SECURITYDIR)
-    S_(FILE_CONTEXTS, SECURITYDIR "/selinux/file_contexts")
-    S_(HOMEDIR_CONTEXTS, SECURITYDIR "/homedir_template")
-    S_(DEFAULT_CONTEXTS, SECURITYDIR "/default_contexts")
-    S_(USER_CONTEXTS, SECURITYDIR "/default_contexts.user/")
-    S_(FAILSAFE_CONTEXT, SECURITYDIR "/failsafe_context")
-    S_(DEFAULT_TYPE, SECURITYDIR "/default_type")
-    S_(BOOLEANS, SECURITYDIR "/booleans")
-    S_(MEDIA_CONTEXTS, SECURITYDIR "/default_media")
-    S_(REMOVABLE_CONTEXT, SECURITYDIR "/removable_context")
diff -urpN libselinux-2.0.4.orig/src/selinux_config.c libselinux-2.0.4/src/selinux_config.c
--- libselinux-2.0.4.orig/src/selinux_config.c	2007-02-25 14:52:16.000000000 -0500
+++ libselinux-2.0.4/src/selinux_config.c	2007-03-08 08:23:50.000000000 -0500
@@ -65,44 +65,16 @@ static const uint16_t file_path_suffixes
 #undef S_
 };
 
-/* Old layout had fixed locations. */
-#define SECURITYCONFIG "/etc/sysconfig/selinux"
-#define SECURITYDIR "/etc/security"
-static const union compat_file_path_data {
-	struct {
-#define S_(n, s) char L1(__LINE__)[sizeof(s)];
-#include "compat_file_path.h"
-#undef S_
-	};
-	char str[0];
-} compat_file_path_data = {
-	{
-#define S_(n, s) s,
-#include "compat_file_path.h"
-#undef S_
-	}
-};
-static const uint16_t compat_file_path_idx[NEL] = {
-#define S_(n, s) [n] = offsetof(union compat_file_path_data, L1(__LINE__)),
-#include "compat_file_path.h"
-#undef S_
-};
-
 #undef L1
 #undef L2
 
-static int use_compat_file_path;
-
 int selinux_getenforcemode(int *enforce)
 {
 	int ret = -1;
 	FILE *cfg = fopen(SELINUXCONFIG, "r");
-	char *buf;
-	int len = sizeof(SELINUXTAG) - 1;
-	if (!cfg) {
-		cfg = fopen(SECURITYCONFIG, "r");
-	}
 	if (cfg) {
+		char *buf;
+		int len = sizeof(SELINUXTAG) - 1;
 		buf = malloc(selinux_page_size);
 		if (!buf) {
 			fclose(cfg);
@@ -167,12 +139,6 @@ static void init_selinux_config(void)
 
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
@@ -244,7 +210,6 @@ static void init_selinux_config(void)
 			     file_path_suffixes_idx[i])
 		    == -1)
 			return;
-	use_compat_file_path = 0;
 }
 
 static void fini_selinux_policyroot(void) __attribute__ ((destructor));
@@ -252,10 +217,6 @@ static void fini_selinux_policyroot(void
 static void fini_selinux_policyroot(void)
 {
 	int i;
-	if (use_compat_file_path) {
-		selinux_policyroot = NULL;
-		return;
-	}
 	free(selinux_policyroot);
 	selinux_policyroot = NULL;
 	for (i = 0; i < NEL; i++) {
@@ -268,10 +229,7 @@ static void fini_selinux_policyroot(void
 
 static const char *get_path(int idx)
 {
-	if (!use_compat_file_path)
-		return file_paths[idx];
-
-	return compat_file_path_data.str + compat_file_path_idx[idx];
+	return file_paths[idx];
 }
 
 const char *selinux_default_type_path()

--0-998643964-1173360679=:8281--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
