Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9NLsgWt012562
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 17:54:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9NLsfIE000485
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 21:54:41 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
        by jazzband.ncsc.mil  with ESMTP id h9NLsd1J000481 for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 21:54:40 GMT
Date: Thu, 23 Oct 2003 23:54:34 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux-3
Message-ID: <20031023215434.GA24235@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--1LKvkjL3sHcu1TtY
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi folks

this patch fixes following problems:
- size_t vs. int, ssize_t
- unsigned int vs. int
- a little bit error checking
files: src/*

bastian

--=20
Only a fool fights in a burning house.
		-- Kank the Klingon, "Day of the Dove", stardate unknown

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=libselinux-3
Content-Transfer-Encoding: quoted-printable

Index: src/get_context_list.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/get_context_list.c	(.../upstream/current/libselinux)	(revision 53)
+++ src/get_context_list.c	(.../trunk/libselinux)	(revision 53)
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
@@ -53,8 +53,8 @@
     if (!cc_len)
 	    return -1;
=20
-    current_line =3D (char *) malloc (length);
+    current_line =3D malloc (length);
     if (!current_line)
 	    return (-1);
=20
     while (!feof (infile)) {
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
-	if (buf[plen-1] =3D=3D '\n')=20
+	if (plen > 1 && buf[plen-1] =3D=3D '\n')=20
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
Index: src/fgetfilecon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/fgetfilecon.c	(.../upstream/current/libselinux)	(revision 53)
+++ src/fgetfilecon.c	(.../trunk/libselinux)	(revision 53)
@@ -10,7 +10,7 @@
 int fgetfilecon(int fd, security_context_t *context)
 {
 	char *buf;
-	ssize_t size;
+	size_t size;
 	ssize_t ret;
=20
 	size =3D INITCONTEXTLEN+1;
@@ -23,11 +23,11 @@
 	if (ret < 0 && errno =3D=3D ERANGE) {
 		char *newbuf;
=20
-		size =3D fgetxattr(fd, XATTR_NAME_SELINUX, NULL, 0);
-		if (size < 0)
+		ret =3D fgetxattr(fd, XATTR_NAME_SELINUX, NULL, 0);
+		if (ret < 0)
 			goto out;
=20
-		size++;
+		size =3D (size_t) ret + 1;
 		newbuf =3D realloc(buf, size);
 		if (!newbuf)
 			goto out;
Index: src/lgetfilecon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/lgetfilecon.c	(.../upstream/current/libselinux)	(revision 53)
+++ src/lgetfilecon.c	(.../trunk/libselinux)	(revision 53)
@@ -10,7 +10,7 @@
 int lgetfilecon(const char *path, security_context_t *context)
 {
 	char *buf;
-	ssize_t size;
+	size_t size;
 	ssize_t ret;
=20
 	size =3D INITCONTEXTLEN+1;
@@ -23,11 +23,11 @@
 	if (ret < 0 && errno =3D=3D ERANGE) {
 		char *newbuf;
=20
-		size =3D lgetxattr(path, XATTR_NAME_SELINUX, NULL, 0);
-		if (size < 0)
+		ret =3D lgetxattr(path, XATTR_NAME_SELINUX, NULL, 0);
+		if (ret < 0)
 			goto out;
=20
-		size++;
+		size =3D (size_t) ret + 1;
 		newbuf =3D realloc(buf, size);
 		if (!newbuf)
 			goto out;
Index: src/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/Makefile	(.../upstream/current/libselinux)	(revision 53)
+++ src/Makefile	(.../trunk/libselinux)	(revision 53)
@@ -11,7 +11,7 @@
 LIBSO=3D$(TARGET).$(LIBVERSION)
 OBJS=3D $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS=3D $(patsubst %.c,%.lo,$(wildcard *.c))
-CFLAGS =3D -Wall
+CFLAGS =3D -Wall -W -Wconversion -Werror
 override CFLAGS +=3D -I../include=20
=20
 all: $(LIBA) $(LIBSO)
Index: src/fsetfilecon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Index: src/helpers.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/helpers.c	(.../upstream/current/libselinux)	(revision 53)
+++ src/helpers.c	(.../trunk/libselinux)	(revision 53)
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
--- src/compute_user.c	(.../upstream/current/libselinux)	(revision 53)
+++ src/compute_user.c	(.../trunk/libselinux)	(revision 53)
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
Index: src/getfilecon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/getfilecon.c	(.../upstream/current/libselinux)	(revision 53)
+++ src/getfilecon.c	(.../trunk/libselinux)	(revision 53)
@@ -10,7 +10,7 @@
 int getfilecon(const char *path, security_context_t *context)
 {
 	char *buf;
-	ssize_t size;
+	size_t size;
 	ssize_t ret;
=20
 	size =3D INITCONTEXTLEN+1;
@@ -23,11 +23,11 @@
 	if (ret < 0 && errno =3D=3D ERANGE) {
 		char *newbuf;
=20
-		size =3D getxattr(path, XATTR_NAME_SELINUX, NULL, 0);
-		if (size < 0)
+		ret =3D getxattr(path, XATTR_NAME_SELINUX, NULL, 0);
+		if (ret < 0)
 			goto out;
=20
-		size++;
+		size =3D (size_t) ret + 1;
 		newbuf =3D realloc(buf, size);
 		if (!newbuf)
 			goto out;
Index: src/context.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/context.c	(.../upstream/current/libselinux)	(revision 53)
+++ src/context.c	(.../trunk/libselinux)	(revision 53)
@@ -41,10 +41,10 @@
         n->component[3] =3D 0;
         for ( i =3D 0, tok =3D str; *tok; i++ ) {
                 for ( p =3D tok; *p && *p !=3D ':'; p++ ) { /* empty */ }
-                n->component[i] =3D (char*) malloc(p-tok+1);
+                n->component[i] =3D malloc((size_t) (p-tok+1));
 		if (n->component[i] =3D=3D 0)
 		  goto err;
-                strncpy(n->component[i],tok,p-tok);
+                strncpy(n->component[i],tok,(size_t) (p-tok));
                 n->component[i][p-tok] =3D '\0';
                 tok =3D *p ? p+1 : p;
         }
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
Index: src/get_default_type.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/get_default_type.c	(.../upstream/current/libselinux)	(revision 53)
+++ src/get_default_type.c	(.../trunk/libselinux)	(revision 53)
@@ -29,7 +29,7 @@
 {
     char buf[250];
     char *ptr =3D "", *end, *t;
-    int len;
+    size_t len;
     int found =3D 0;
=20
     len =3D strlen(role);

--gKMricLos+KVdGMg--

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iEYEARECAAYFAj+YThoACgkQLkAIIn9ODhEdzwCg8Gv1IUOtw+9chZM1P3DzB+pG
dVcAnA+bkSAD4tEnY+jh7ruwacunyflu
=/M6u
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
