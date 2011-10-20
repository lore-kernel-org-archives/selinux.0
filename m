Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9KD9pXR002432
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2011 09:09:51 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p9KD9or6024164
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2011 13:09:50 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p9KD9nwC007451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2011 09:09:50 -0400
Received: from [10.11.9.204] (vpn-9-204.rdu.redhat.com [10.11.9.204])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p9KD9nlR012081
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2011 09:09:49 -0400
Message-ID: <4EA01D9D.8050804@redhat.com>
Date: Thu, 20 Oct 2011 09:09:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: passwd, chfn and chsh not reporting AVC's
Content-Type: multipart/mixed;
 boundary="------------040606090503050402060807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040606090503050402060807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

In reviewing some bugs on these packages we realize we want to update
them to use the latest tool chain.  In order to make this easier, we
want to add a new function called selinux_check_access to libselinux.

Please review patch.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6gHZ0ACgkQrlYvE4MpobMzlQCbB0RPLKCAANvc91KRTXn1MPh+
umcAoL5mtYorhaXwDHYj5gcu+YhVzoB4
=DmU9
-----END PGP SIGNATURE-----

--------------040606090503050402060807
Content-Type: text/plain;
 name="libselinux-checkaccess.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-checkaccess.patch"

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index d29b0c1..792e68e 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -500,6 +500,25 @@ extern const char *selinux_colors_path(void);
 extern const char *selinux_netfilter_context_path(void);
 extern const char *selinux_path(void);
 
+/**
+ * selinux_check_access - Check permissions and perform appropriate auditing.
+ * @scon: source security context
+ * @tcon: target security context
+ * @tclass: target security class string
+ * @perm: requested permissions string, interpreted based on @tclass
+ * @auditdata: auxiliary audit data
+ *
+ * Check the AVC to determine whether the @perm permissions are granted
+ * for the SID pair (@scon, @tcon), interpreting the permissions
+ * based on @tclass.
+ * Return %0 if all @perm permissions are granted, -%1 with 
+ * @errno set to %EACCES if any permissions are denied or to another 
+ * value upon other errors.
+ * If auditing or logging is configured the appropriate callbacks will be called
+ * and passed the auditdata field
+ */
+extern int selinux_check_access(const security_context_t scon, const security_context_t tcon, const char *tclass, const char *perm, void *auditdata);
+
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
 extern int selinux_check_passwd_access(access_vector_t requested);
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index f2d9f30..1e36952 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -24,6 +24,8 @@ the SELinux policy database in the kernel.
 .BI "int security_get_initial_context(const char *" name ", security_context_t
 "con );
 .sp
+.BI "int selinux_check_access(const security_context_t " scon, " const security_context_t " tcon, " const char *" class, " const char *" perm, "void *" auditdata);
+.sp
 .BI "int selinux_check_passwd_access(access_vector_t " requested );
 .sp
 .BI "int checkPasswdAccess(access_vector_t " requested );
@@ -74,6 +76,9 @@ source context. It is mainly used by
 is used to get the context of a kernel initial security identifier specified by 
 .I name
 
+.B selinux_check_access
+is used to check if the source context has the access permission for the specified class on the target context.
+
 .B selinux_check_passwd_access
 is used to check for a permission in the
 .I passwd
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index c1982c7..37ccc15 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -4,8 +4,40 @@
 #include <errno.h>
 #include "selinux_internal.h"
 #include <selinux/flask.h>
+#include <selinux/avc.h>
 #include <selinux/av_permissions.h>
 
+static pthread_once_t once = PTHREAD_ONCE_INIT;
+
+static void avc_init_once(void)
+{
+	avc_open(NULL, 0);
+}
+
+int selinux_check_access(const security_context_t scon, const security_context_t tcon, const char *class, const char *perm, void *aux) {
+	int status = -1;
+	int rc = -1;
+	security_id_t scon_id;
+	security_id_t tcon_id;
+	security_class_t sclass;
+	access_vector_t av;
+
+	if (is_selinux_enabled() == 0)
+		return 0;
+
+	__selinux_once(once, avc_init_once);
+
+	if ((rc = avc_context_to_sid(scon, &scon_id)) < 0)  return rc;
+
+	if ((rc = avc_context_to_sid(tcon, &tcon_id)) < 0)  return rc;
+
+	if ((sclass = string_to_security_class(class)) == 0) return status;
+
+	if ((av = string_to_av_perm(sclass, perm)) == 0) return status;
+
+	return (avc_has_perm (scon_id, tcon_id, sclass, av, NULL, aux);
+}
+
 int selinux_check_passwd_access(access_vector_t requested)
 {
 	int status = -1;

--------------040606090503050402060807--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
