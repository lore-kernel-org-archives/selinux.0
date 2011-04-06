Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p36KwW0B007343
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 16:58:32 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p36KwUN6020976
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 20:58:31 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p36KwUCX017076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 16:58:30 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p36KwTIF007291
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 16:58:30 -0400
Message-ID: <4D9CD3F5.9080002@redhat.com>
Date: Wed, 06 Apr 2011 16:58:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: This patch cleans up a couple of crashes caused by libselinux
Content-Type: multipart/mixed;
 boundary="------------040002070003040402040500"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040002070003040402040500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

If you fail to load_policy in the init or SELinux is disabled, you need
to free the selinux_mnt variable and clear the memory.

systemd was calling load_polcy on a DISABLED system then later on it
would call is_selinux_enabled() and get incorrect response, since
selinux_mnt still had valid data.

The second bug in libselinux, resolves around calling the
selinux_key_delete(destructor_key) if the selinux_key_create call had
never been called.  This was causing data to be freed in other
applications that loaded an unloaded the libselinux library but never
setup setrans or matchpathcon.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2c0/UACgkQrlYvE4MpobMP1QCfXAFD3pfWFLd1lylU/vjsZmpM
mcUAnA2l3/GKGC3hT8XB9E+2pTfpy+uj
=jpyr
-----END PGP SIGNATURE-----

--------------040002070003040402040500
Content-Type: text/plain;
 name="libselinux-memory.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-memory.patch"

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 0725b57..f110dcf 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -514,6 +515,9 @@ extern int selinux_check_securetty_context(const security_context_t tty_context)
    which performs the initial mount of selinuxfs. */
 void set_selinuxmnt(char *mnt);
 
+/* clear selinuxmnt variable and free allocated memory */
+void fini_selinuxmnt(void);
+
 /* Execute a helper for rpm in an appropriate security context. */
 extern int rpm_execcon(unsigned int verified,
 		       const char *filename,
diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 1dd9838..a948920 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -96,12 +96,14 @@ static void init_selinuxmnt(void)
 	return;
 }
 
-static void fini_selinuxmnt(void)
+void fini_selinuxmnt(void)
 {
 	free(selinux_mnt);
 	selinux_mnt = NULL;
 }
 
+hidden_def(fini_selinuxmnt)
+
 void set_selinuxmnt(char *mnt)
 {
 	selinux_mnt = strdup(mnt);
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 36ce029..83d2143 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -398,6 +398,7 @@ int selinux_init_load_policy(int *enforce)
 		if (rc == 0) {
 			/* Successfully disabled, so umount selinuxfs too. */
 			umount(SELINUXMNT);
+			fini_selinuxmnt();
 		}
 		/*
 		 * If we failed to disable, SELinux will still be 
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index f3e45af..da5cab9 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -17,6 +18,7 @@ static __thread int con_array_used;
 
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 static pthread_key_t destructor_key;
+static int destructor_key_initialized = 0;
 
 static int add_array_elt(char *con)
 {
@@ -292,12 +294,14 @@ static void matchpathcon_thread_destructor(void __attribute__((unused)) *ptr)
 
 void __attribute__((destructor)) matchpathcon_lib_destructor(void)
 {
-	__selinux_key_delete(destructor_key);
+	if (destructor_key_initialized)
+		__selinux_key_delete(destructor_key);
 }
 
 static void matchpathcon_init_once(void)
 {
-	__selinux_key_create(&destructor_key, matchpathcon_thread_destructor);
+	if (__selinux_key_create(&destructor_key, matchpathcon_thread_destructor) == 0)
+		destructor_key_initialized = 1;
 }
 
 int matchpathcon_init_prefix(const char *path, const char *subset)
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index fdddfaf..806e87c 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -3,6 +3,7 @@
 #include "dso.h"
 
 hidden_proto(selinux_mkload_policy)
+    hidden_proto(fini_selinuxmnt)
     hidden_proto(set_selinuxmnt)
     hidden_proto(security_disable)
     hidden_proto(security_policyvers)
@@ -114,10 +116,7 @@ extern int selinux_page_size hidden;
 
 /* Pthread key macros */
 #define __selinux_key_create(KEY, DESTRUCTOR)			\
-	do {							\
-		if (pthread_key_create != NULL)			\
-			pthread_key_create(KEY, DESTRUCTOR);	\
-	} while (0)
+	(pthread_key_create != NULL ? pthread_key_create(KEY, DESTRUCTOR) : -1)
 
 #define __selinux_key_delete(KEY)				\
 	do {							\
diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index 4bdbe08..e074142 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -35,6 +35,7 @@ static __thread security_context_t prev_r2c_raw = NULL;
 
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 static pthread_key_t destructor_key;
+static int destructor_key_initialized = 0;
 static __thread char destructor_initialized;
 
 /*
@@ -254,7 +255,8 @@ static void setrans_thread_destructor(void __attribute__((unused)) *unused)
 
 void __attribute__((destructor)) setrans_lib_destructor(void)
 {
-	__selinux_key_delete(destructor_key);
+	if (destructor_key_initialized)
+		__selinux_key_delete(destructor_key);
 }
 
 static inline void init_thread_destructor(void)
@@ -267,7 +269,9 @@ static inline void init_thread_destructor(void)
 
 static void init_context_translations(void)
 {
-	__selinux_key_create(&destructor_key, setrans_thread_destructor);
+	if (__selinux_key_create(&destructor_key, setrans_thread_destructor) == 0)
+		destructor_key_initialized = 1;
+
 	mls_enabled = is_selinux_mls_enabled();
 }
 

--------------040002070003040402040500
Content-Type: application/pgp-signature;
 name="libselinux-memory.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-memory.patch.sig"

iEYEABECAAYFAk2c0/UACgkQrlYvE4MpobNQUgCfQTuJoXT30e6y61+9Hqq5dVZZ7+kAnRE4
KI9Q8Pl4xrawojt/041/bD3j
--------------040002070003040402040500--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
