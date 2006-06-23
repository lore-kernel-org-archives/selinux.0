Subject: [PATCH 1/10] setfiles audit fix
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:51:59 -0400
Message-Id: <1151074320.4011.68.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch needs to be applied on trunk to allow setfiles to be built
without libaudit being installed.

diff -pruN -x .svn selinux.old/policycoreutils/setfiles/setfiles.c optionals-in-base-take2/policycoreutils/setfiles/setfiles.c
--- selinux.old/policycoreutils/setfiles/setfiles.c	2006-06-22 21:26:36.000000000 -0400
+++ optionals-in-base-take2/policycoreutils/setfiles/setfiles.c	2006-06-22 21:29:15.000000000 -0400
@@ -450,9 +450,13 @@ static int pre_stat(const char *file_unu
   return 0;
 }
 
+#ifndef USE_AUDIT
+static void maybe_audit_mass_relabel(int done_root __attribute__ ((unused)),
+		int err __attribute__ ((unused)))
+{
+#else
 static void maybe_audit_mass_relabel(int done_root, int errs)
 {
-#ifdef USE_AUDIT
   int audit_fd = -1;
   int rc = 0;
   

   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
