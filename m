Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p36L8TrG008249
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 17:08:29 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p36L8Sd4007820
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 21:08:29 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p36L8SK1019919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 17:08:28 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p36L8RJe022928
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 17:08:28 -0400
Message-ID: <4D9CD64B.7020207@redhat.com>
Date: Wed, 06 Apr 2011 17:08:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: This patch adds a new subs_dist file.
Content-Type: multipart/mixed;
 boundary="------------020806070105060106020602"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020806070105060106020602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The idea is to allow distributions to ship a subs file as well as let
the user modify subs.

In F16 we are looking at shipping a

file_contexts.subs_dist file like this

cat file_contexts.subs_dist
/run /var/run
/run/lock /var/lock
/var/run/lock /var/lock
/lib64 /lib
/usr/lib64 /usr/lib


The we will remove all (64)?  from policy.

This will allow us to make sure all /usr/lib/libBLAH is labeled the same
as /usr/lib64/libBLAH

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2c1ksACgkQrlYvE4MpobNXcQCgqgAiQJxmwa1+NdIq8E3tQRp6
QT0An0ihA60di9CRsEqEdVbSaHOwtte5
=LXgd
-----END PGP SIGNATURE-----

--------------020806070105060106020602
Content-Type: text/plain;
 name="libselinux-subs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-subs.patch"

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 0725b57..f110dcf 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -482,6 +482,7 @@ extern const char *selinux_file_context_path(void);
 extern const char *selinux_file_context_homedir_path(void);
 extern const char *selinux_file_context_local_path(void);
 extern const char *selinux_file_context_subs_path(void);
+extern const char *selinux_file_context_subs_dist_path(void);
 extern const char *selinux_homedir_context_path(void);
 extern const char *selinux_media_context_path(void);
 extern const char *selinux_virtual_domain_context_path(void);
diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_path_suffixes.h
index ccf43e1..0b00156 100644
--- a/libselinux/src/file_path_suffixes.h
+++ b/libselinux/src/file_path_suffixes.h
@@ -23,4 +23,5 @@ S_(BINPOLICY, "/policy/policy")
     S_(VIRTUAL_DOMAIN, "/contexts/virtual_domain_context")
     S_(VIRTUAL_IMAGE, "/contexts/virtual_image_context")
     S_(FILE_CONTEXT_SUBS, "/contexts/files/file_contexts.subs")
+    S_(FILE_CONTEXT_SUBS_DIST, "/contexts/files/file_contexts.subs_dist")
     S_(SEPGSQL_CONTEXTS, "/contexts/sepgsql_contexts")
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 2fd19c5..ba316df 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -56,12 +56,11 @@ static char *selabel_sub(struct selabel_sub *ptr, const char *src)
 	return NULL;
 }
 
-static struct selabel_sub *selabel_subs_init(void)
+static struct selabel_sub *selabel_subs_init(const char *path,struct selabel_sub *list)
 {
 	char buf[1024];
-	FILE *cfg = fopen(selinux_file_context_subs_path(), "r");
+	FILE *cfg = fopen(path, "r");
 	struct selabel_sub *sub;
-	struct selabel_sub *list = NULL;
 
 	if (cfg) {
 		while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
@@ -160,7 +159,10 @@ struct selabel_handle *selabel_open(unsigned int backend,
 	memset(rec, 0, sizeof(*rec));
 	rec->backend = backend;
 	rec->validating = selabel_is_validate_set(opts, nopts);
-	rec->subs = selabel_subs_init();
+
+	rec->subs = NULL;
+	rec->subs = selabel_subs_init(selinux_file_context_subs_dist_path(), rec->subs);
+	rec->subs = selabel_subs_init(selinux_file_context_subs_path(), rec->subs);
 
 	if ((*initfuncs[backend])(rec, opts, nopts)) {
 		free(rec);
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index e040959..f4c33df 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -45,7 +45,8 @@
 #define VIRTUAL_IMAGE     22
 #define FILE_CONTEXT_SUBS 23
 #define SEPGSQL_CONTEXTS  24
-#define NEL               25
+#define FILE_CONTEXT_SUBS_DIST 25
+#define NEL               26
 
 /* Part of one-time lazy init */
 static pthread_once_t once = PTHREAD_ONCE_INIT;
@@ -423,6 +424,12 @@ const char * selinux_file_context_subs_path(void) {
 
 hidden_def(selinux_file_context_subs_path)
 
+const char * selinux_file_context_subs_dist_path(void) {
+	return get_path(FILE_CONTEXT_SUBS_DIST);
+}
+
+hidden_def(selinux_file_context_subs_dist_path)
+
 const char *selinux_sepgsql_context_path()
 {
 	return get_path(SEPGSQL_CONTEXTS);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index fdddfaf..806e87c 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -65,6 +66,7 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(selinux_file_context_path)
     hidden_proto(selinux_file_context_homedir_path)
     hidden_proto(selinux_file_context_local_path)
+    hidden_proto(selinux_file_context_subs_dist_path)
     hidden_proto(selinux_file_context_subs_path)
     hidden_proto(selinux_netfilter_context_path)
     hidden_proto(selinux_homedir_context_path)

--------------020806070105060106020602
Content-Type: application/pgp-signature;
 name="libselinux-subs.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-subs.patch.sig"

iEYEABECAAYFAk2c1ksACgkQrlYvE4MpobObtACeOjHJ1f/lwWE797z7IcDkev0+gxwAn2eQ
o92BcFAUR7YN9chRxZUIn0jl
--------------020806070105060106020602--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
