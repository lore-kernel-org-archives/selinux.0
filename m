Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hATHuuRb000926
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 12:56:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hATHusqY028568
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 17:56:54 GMT
Received: from wavehammer.waldi.eu.org (hornet.berlios.de [195.37.77.140])
        by jazzband.ncsc.mil  with ESMTP id hATHum0o028564 for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 17:56:53 GMT
Date: Fri, 28 Nov 2003 10:19:11 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: libselinux-3 (reviewed)
Message-ID: <20031128091911.GA27465@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--7iMSBzlTiPOCCT2k
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi folks

this patch fixes following problems:
- size_t vs. int, ssize_t
- unsigned int vs. int
files: src/*

bastian

--=20
Lots of people drink from the wrong bottle sometimes.
		-- Edith Keeler, "The City on the Edge of Forever",
		   stardate unknown

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=libselinux-3
Content-Transfer-Encoding: quoted-printable

--- src/get_context_list.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/get_context_list.c	(.../trunk/libselinux)	(revision 62)
@@ -36,13 +36,13 @@
 	       an entry is found, and a 1 is returned otherwise.
 */
 static int find_line (FILE *infile, security_context_t con, char *line,=20
-                      int length)
+                      size_t length)
 {
     char *current_line;
     char *ptr, *ptr2 =3D NULL;
     int found =3D 0;
     char *cc_str =3D 0;
-    int cc_len =3D 0;
+    size_t cc_len =3D 0;
=20
     /* Skip the user field. */
     cc_str =3D index(con, ':');
@@ -53,12 +53,12 @@
     if (!cc_len)
 	    return -1;
=20
-    current_line =3D (char *) malloc (length);
+    current_line =3D malloc (length);
     if (!current_line)
 	    return (-1);
=20
     while (!feof (infile)) {
 	if (!fgets(current_line, length, infile)) {
 		free(current_line);
 		return -1;
 	}
@@ -119,9 +119,9 @@
                              int pri_length)
 {
     char *ptr, *ptr2;
-    int length;
+    size_t length;
     security_context_t current_context;
-    int current_context_len;
+    size_t current_context_len;
     int count =3D 0;
=20
     ptr =3D instr;
@@ -205,7 +205,7 @@
 {
     FILE *config_file;    /* The configuration file                    */
     char *fname =3D 0;      /* The name of the user's configuration file */
-    int fname_len;        /* The length of fname                       */
+    size_t fname_len;     /* The length of fname                       */
     struct passwd *pwd;   /* The user's passwd structure               */
     int retval;           /* The return value                          */
=20
@@ -218,7 +218,7 @@
             return -1;
         }
         fname_len =3D strlen (pwd->pw_dir) + 20;
-        fname =3D (char *) malloc (fname_len);
+        fname =3D malloc (fname_len);
         if (!fname)
         {
             return -1;
@@ -366,13 +366,13 @@
 	if (!ptr)
 		return -1;
 	plen =3D strlen(ptr);
 	if (buf[plen-1] =3D=3D '\n')=20
 		buf[plen-1] =3D 0;
=20
 	nlen =3D strlen(user)+1+plen+1;
 	*newcon =3D malloc(nlen);
 	rc =3D snprintf(*newcon, nlen, "%s:%s", user, ptr);
-	if (rc < 0 || rc >=3D nlen) {
+	if (rc < 0 || (size_t) rc >=3D nlen) {
 		free(*newcon);
 		*newcon =3D 0;
 		return -1;
Index: src/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/Makefile	(.../upstream/current/libselinux)	(revision 62)
+++ src/Makefile	(.../trunk/libselinux)	(revision 62)
@@ -25,10 +26,10 @@
 	ln -sf $@ $(TARGET)=20
=20
 %.o:  %.c
-	$(CC) -o $@ -c $(CFLAGS) $<
+	$(CC) $(CFLAGS) -c -o $@ $<
=20
 %.lo:  %.c
-	$(CC) -o $@ -c -fPIC $(CFLAGS) $<
+	$(CC) $(CFLAGS) -fPIC -c -o $@ $<
=20
 install: all
 	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
Index: src/fsetfilecon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Index: src/compute_av.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/compute_av.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/compute_av.c	(.../trunk/libselinux)	(revision 62)
@@ -16,7 +16,7 @@
 			struct av_decision *avd)
 {
 	char *buf;
-	unsigned int len;
+	size_t len;
 	int fd, ret;
=20
 	fd =3D open(SELINUXMNT "access", O_RDWR);
Index: src/helpers.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/helpers.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/helpers.c	(.../trunk/libselinux)	(revision 62)
@@ -23,7 +23,7 @@
=20
 security_class_t string_to_security_class(const char *s)
 {
-	int val;
+	unsigned int val;
=20
 	if (isdigit(s[0])) {
 		val =3D atoi(s);
@@ -45,7 +45,7 @@
 {
         char          **common_pts =3D 0;
         access_vector_t common_base =3D 0;
-        int             i, i2, perm;
+        unsigned int             i, i2, perm;
 =20
 =20
         if (av =3D=3D 0) {
Index: src/lsetfilecon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Index: src/compute_user.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/compute_user.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/compute_user.c	(.../trunk/libselinux)	(revision 62)
@@ -16,8 +16,8 @@
 	char **ary;
 	char *buf, *ptr;
 	size_t size;
-	int fd, ret, i;
-	unsigned int nel;
+	int fd, ret;
+	unsigned int i, nel;
=20
 	fd =3D open(SELINUXMNT "user", O_RDWR);
 	if (fd < 0)
Index: src/get_default_type.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/get_default_type.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/get_default_type.c	(.../trunk/libselinux)	(revision 62)
@@ -29,7 +29,7 @@
 {
     char buf[250];
     char *ptr =3D "", *end, *t;
-    int len;
+    size_t len;
     int found =3D 0;
=20
     len =3D strlen(role);
Index: src/context.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/context.c	(.../upstream/current/libselinux)	(revision 62)
+++ src/context.c	(.../trunk/libselinux)	(revision 62)
@@ -93,14 +93,15 @@
 context_str(context_t context)
 {
         context_private_t *n =3D context->ptr;
-        int i, total;
+        int i;
+        size_t total =3D 0;
         conditional_free(&n->current_str);
-        for ( i =3D total =3D 0; i < 4; i++ ) {
+        for ( i =3D 0; i < 4; i++ ) {
                 if ( n->component[i] ) {
                         total +=3D strlen(n->component[i])+1;
                 }
         }
-        n->current_str =3D (char*) malloc(total);
+        n->current_str =3D malloc(total);
         if ( n->current_str !=3D 0 ) {
                 strcpy(n->current_str,n->component[0]);
                 strcat(n->current_str,":");

--FCuugMFkClbJLl1L--

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iEYEARECAAYFAj/HEw8ACgkQLkAIIn9ODhHLrgCg/ChB4DT7FiI8Ju3XAEMAfirT
QYcAn1xagdkTTIm8wKdjJa24DumRrGoM
=2sBZ
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
