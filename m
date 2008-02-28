Subject: Re: libselinux does not work properly in upstart/initrd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47C6F067.5050209@redhat.com>
References: <47C6F067.5050209@redhat.com>
Content-Type: multipart/mixed; boundary="=-9MQvhyQiR6aeQdZe+beS"
Date: Thu, 28 Feb 2008 13:25:31 -0500
Message-Id: <1204223131.31790.161.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-9MQvhyQiR6aeQdZe+beS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, 2008-02-28 at 12:33 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=434793
> 
> The way the upstart initrd works is to run nash with a builtin
> loadpolicy.  The problem is nash starts before the /sysmount files
> system is mounted, so libselinux does not have an /etc/selinux/config to
> read.  It defaults to targeted.  So when nash finally executes
> loadpolicy (selinux_init_load_policy) it has the wrong config.
> Switching to any other type of policy will fail and
> selinux_init_load_policy will look for targeted.
> 
> I changed this function to reload the config, to fix this problem.
> 
> I think I did all the hidden stuff correctly.  I don't think we want to
> expose these functions.

To make a function hidden, just mark it with hidden.
hidden_def and hidden_proto are about creating a private definition
within the library for intra-library calls that do not cause a
relocation, not about hiding the definition altogether.

Concerns about this patch:
- it isn't thread safe,
- it only "fixes" the load policy case, not any other libselinux
function call.

As an alternative, maybe we should revive Steve Grubb's lazy init patch
for libselinux?  That won't reload each time, but will defer the initial
reading until you first invoke a libselinux function.  The last version
of the patch that I saw is attached.

-- 
Stephen Smalley
National Security Agency

--=-9MQvhyQiR6aeQdZe+beS
Content-Disposition: attachment; filename=libselinux-2.0.7-lazy-config.patch
Content-Type: text/x-patch; name=libselinux-2.0.7-lazy-config.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -urp libselinux-2.0.7.orig/src/selinux_config.c libselinux-2.0.7/src/selinux_config.c
--- libselinux-2.0.7.orig/src/selinux_config.c	2007-03-17 21:09:48.000000000 -0400
+++ libselinux-2.0.7/src/selinux_config.c	2007-03-18 09:03:05.000000000 -0400
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <unistd.h>
+#include <pthread.h>
 #include "selinux_internal.h"
 #include "get_default_type_internal.h"
 
@@ -40,6 +41,24 @@
 #define SECURETTY_TYPES   18
 #define NEL               19
 
+/* Make pthread_once optional */
+#pragma weak pthread_once
+
+/* Part of one-time lazy init */
+static pthread_once_t once = PTHREAD_ONCE_INIT;
+static void init_selinux_config(void);
+
+/* Call handler iff the first call.  */
+#define __selinux_once(ONCE_CONTROL, INIT_FUNCTION)	\
+	do {						\
+		if (pthread_once != NULL)		\
+			pthread_once (&(ONCE_CONTROL), (INIT_FUNCTION));  \
+		else if ((ONCE_CONTROL) == PTHREAD_ONCE_INIT) {		  \
+			INIT_FUNCTION ();		\
+			(ONCE_CONTROL) = 2;		\
+		}					\
+	} while (0)
+
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
 #define L1(l) L2(l)
@@ -115,6 +134,7 @@ static char *selinux_policytype;
 
 int selinux_getpolicytype(char **type)
 {
+	__selinux_once(once, init_selinux_config);
 	if (!selinux_policytype)
 		return -1;
 	*type = strdup(selinux_policytype);
@@ -124,9 +144,7 @@ int selinux_getpolicytype(char **type)
 hidden_def(selinux_getpolicytype)
 
 static char *selinux_policyroot = NULL;
-static char *selinux_rootpath = NULL;
-
-static void init_selinux_config(void) __attribute__ ((constructor));
+static const char *selinux_rootpath = SELINUXDIR;
 
 static void init_selinux_config(void)
 {
@@ -139,7 +157,6 @@ static void init_selinux_config(void)
 	if (selinux_policyroot)
 		return;
 
-	selinux_rootpath = SELINUXDIR;
 	fp = fopen(SELINUXCONFIG, "r");
 	if (fp) {
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
@@ -224,6 +241,7 @@ static void fini_selinux_policyroot(void
 
 static const char *get_path(int idx)
 {
+	__selinux_once(once, init_selinux_config);
 	return file_paths[idx];
 }
 
@@ -236,6 +254,7 @@ hidden_def(selinux_default_type_path)
 
 const char *selinux_policy_root()
 {
+	__selinux_once(once, init_selinux_config);
 	return selinux_policyroot;
 }
 

--=-9MQvhyQiR6aeQdZe+beS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
