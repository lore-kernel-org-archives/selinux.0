Subject: [patch] libselinux:  dlopen libsepol.so.1 rather than libsepol.so
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Tue, 20 Nov 2007 11:22:31 -0500
Message-Id: <1195575751.20910.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris noticed that libselinux was not downgrading the policy
image to the kernel's policy version on a F8 system (when building a
kernel with the version max option using the default of policy.19).  I
realized that this is most likely due to the fact that libselinux now
dlopen's libsepol, and at present, it dlopen's libsepol.so rather
libsepol.so.1.  This is similar to the problems encountered with procps
dlopen'ing libselinux.so - the .so file lives in /usr/lib and is only
installed by the -devel package, whereas the .so.1 file lives in /lib
and is installed by the main package, so a user may not have a
libsepol.so at all or it might not be mounted if /usr is a separate
partition at initial policy load.  So change it to dlopen libsepol.so.1
instead.

---

 libselinux/src/load_policy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Index: trunk/libselinux/src/load_policy.c
===================================================================
--- trunk/libselinux/src/load_policy.c	(revision 2687)
+++ trunk/libselinux/src/load_policy.c	(working copy)
@@ -71,7 +71,7 @@
 #ifdef SHARED
 	char *errormsg = NULL;
 	void *libsepolh = NULL;
-	libsepolh = dlopen("libsepol.so", RTLD_NOW);
+	libsepolh = dlopen("libsepol.so.1", RTLD_NOW);
 	if (libsepolh) {
 		usesepol = 1;
 		dlerror();

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
