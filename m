Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hATHuuRb000927
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 12:56:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hATHutqY028571
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 17:56:55 GMT
Received: from wavehammer.waldi.eu.org (hornet.berlios.de [195.37.77.140])
        by jazzband.ncsc.mil  with ESMTP id hATHum0o028565 for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 17:56:53 GMT
Date: Fri, 28 Nov 2003 10:31:54 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] checkpolicy-5
Message-ID: <20031128093154.GB27465@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--SFyWQ0h3ruR435lw
Content-Type: multipart/mixed; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi folks

this patch fixes:
- size_t vs. int, unsigned int, __u32
- mark some attributes as unused

bastian

--=20
Where there's no emotion, there's no motive for violence.
		-- Spock, "Dagger of the Mind", stardate 2715.1

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=checkpolicy-5
Content-Transfer-Encoding: quoted-printable

--- services.c	(.../upstream/current/checkpolicy)	(revision 86)
+++ services.c	(.../trunk/checkpolicy)	(revision 86)
@@ -170,7 +170,7 @@
 static int context_struct_compute_av(context_struct_t *scontext,
 				     context_struct_t *tcontext,
 				     security_class_t tclass,
-				     access_vector_t requested,
+				     access_vector_t requested __attribute__ ((unused)),
 				     struct av_decision *avd)
 {
 	constraint_node_t *constraint;
@@ -301,7 +301,7 @@
  */
 int context_struct_to_string(context_struct_t * context,
 			     security_context_t * scontext,
-			     __u32 *scontext_len)
+			     size_t *scontext_len)
 {
 	char *scontextp;
=20
@@ -315,7 +315,7 @@
 	*scontext_len +=3D mls_compute_context_len(context);
=20
 	/* Allocate space for the context; caller must free this space. */
-	scontextp =3D (char *) kmalloc(*scontext_len+1,GFP_ATOMIC);
+	scontextp =3D kmalloc(*scontext_len+1,GFP_ATOMIC);
 	if (!scontextp) {
 		return -ENOMEM;
 	}
@@ -350,7 +350,7 @@
  */
 int security_sid_to_context(security_id_t sid,
 			    security_context_t * scontext,
-			    __u32 *scontext_len)
+			    size_t *scontext_len)
 {
 	context_struct_t *context;
 	int rc =3D 0;
@@ -387,7 +387,7 @@
  * has the string representation specified by `scontext'.
  */
 int security_context_to_sid(security_context_t scontext,
-			    __u32 scontext_len,
+			    size_t scontext_len,
 			    security_id_t * sid)
 {
 	security_context_t scontext2;
@@ -510,7 +510,7 @@
 		return -EACCES;
 	} else {
 		security_context_t s, t, n;
-		__u32 slen, tlen, nlen;
+		size_t slen, tlen, nlen;
=20
 		context_struct_to_string(scontext, &s, &slen);
 		context_struct_to_string(tcontext, &t, &tlen);
@@ -800,7 +800,7 @@
 		return -EINVAL;
 	} else {
 		security_context_t s;
-		__u32 len;
+		size_t len;
=20
 		context_struct_to_string(context, &s, &len);
 		printk("security:  context %s is invalid\n", s);
@@ -821,7 +821,7 @@
  * in the policy `p->newp'.  Verify that the
  * context is valid under the new policy.
  */
-static int convert_context(security_id_t key,
+static int convert_context(security_id_t key __attribute__ ((unused)),
 			   context_struct_t * c,
 			   void *p)
 {
@@ -831,7 +831,7 @@
 	type_datum_t *typdatum;
 	user_datum_t *usrdatum;
 	security_context_t s;
-	__u32 len;
+	size_t len;
 	int rc =3D -EINVAL;
       =20
 	args =3D (convert_context_args_t *) p;
@@ -1045,8 +1045,8 @@
  * Return the SID of the port specified by
  * `domain', `type', `protocol', and `port'.
  */
-int security_port_sid(__u16 domain,
-		      __u16 type,
+int security_port_sid(__u16 domain __attribute__ ((unused)),
+		      __u16 type __attribute__ ((unused)),
 		      __u8 protocol,
 		      __u16 port,
 		      security_id_t * out_sid)
@@ -1141,7 +1141,7 @@
  */
 int security_node_sid(__u16 domain,
 		      void *addrp,
-		      __u32 addrlen,
+		      size_t addrlen,
 		      security_id_t *out_sid)
 {
 	int rc =3D 0;
@@ -1201,7 +1201,8 @@
 	user_datum_t *user;
 	role_datum_t *role;
 	struct av_decision avd;
-	int rc =3D 0, i, j;
+	int rc =3D 0;
+	unsigned int i, j;
=20
 	if (!ss_initialized) {
 		*nel =3D 0;
@@ -1293,7 +1294,7 @@
 		       security_class_t sclass,
 		       security_id_t *sid)
 {
-	int len;
+	size_t len;
 	genfs_t *genfs;
 	ocontext_t *c;
 	int rc =3D 0, cmp =3D 0;
--- checkpolicy.c	(.../upstream/current/checkpolicy)	(revision 86)
+++ checkpolicy.c	(.../trunk/checkpolicy)	(revision 86)
@@ -57,7 +57,7 @@
 char *txtfile =3D "policy.conf";
 char *binfile =3D "policy";
=20
-int avc_ss_reset(__u32 seqno)
+int avc_ss_reset(__u32 seqno __attribute__ ((unused)))
 {
 	return 0;
 }
@@ -69,10 +69,10 @@
 }
=20
 static int print_sid(security_id_t sid,
-		     context_struct_t * context, void *data)
+		     context_struct_t * context __attribute__ ((unused)), void *data __a=
ttribute__ ((unused)))
 {
 	security_context_t scontext;
-	unsigned int scontext_len;
+	size_t scontext_len;
 	int rc;
=20
 	rc =3D security_sid_to_context(sid, &scontext, &scontext_len);
@@ -105,7 +105,7 @@
 	return 0;
 }
=20
-static int type_attr_remove(hashtab_key_t key, hashtab_datum_t datum, void=
 *p)
+static int type_attr_remove(hashtab_key_t key __attribute__ ((unused)), ha=
shtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	type_datum_t *typdatum;
=20
@@ -244,12 +244,12 @@
=20
 extern char *av_to_string(__u32 tclass, access_vector_t av);
=20
-void check_assertion_helper(int stype, int ttype, ebitmap_t *tclasses,=20
+void check_assertion_helper(unsigned int stype, unsigned int ttype, ebitma=
p_t *tclasses,=20
 			    access_vector_t *avp, unsigned long line)=20
 {
 	avtab_key_t avkey;
 	avtab_datum_t *avdatump;
-	int k;
+	unsigned int k;
 =09
=20
 	for (k =3D ebitmap_startbit(tclasses); k < ebitmap_length(tclasses); k++)=
 {
@@ -275,7 +275,7 @@
 void check_assertions(void)=20
 {
 	te_assert_t *a, *tmp;
-	int i, j;
+	unsigned int i, j;
=20
 	a =3D te_assertions;
 	while (a) {
@@ -309,11 +309,13 @@
 	struct av_decision avd;
 	class_datum_t *cladatum;
 	char ans[80 + 1], *file =3D txtfile, *outfile =3D NULL, *path, *fstype;
-	unsigned int scontext_len, pathlen, i;
+	size_t scontext_len, pathlen;
+	unsigned int i;
 	unsigned int protocol, port, addr;
 	unsigned int binary =3D 0, debug =3D 0;
 	struct val_to_name v;
-	int ret, ch, nel, fd;
+	int ret, ch, fd;
+	unsigned int nel;
 	struct stat sb;
 	void *map;
 	FILE *outfp =3D NULL;
--- include/security.h	(.../upstream/current/checkpolicy)	(revision 86)
+++ include/security.h	(.../trunk/checkpolicy)	(revision 86)
@@ -80,7 +80,7 @@
 int security_sid_to_context(
 	security_id_t  sid,			/* IN */
 	security_context_t *scontext,		/* OUT */
-	__u32   *scontext_len);			/* OUT */
+	size_t  *scontext_len);			/* OUT */
=20
 /*
  * Return a SID associated with the security context that
@@ -88,7 +88,7 @@
  */
 int security_context_to_sid(
 	security_context_t scontext,		/* IN */
-	__u32   scontext_len,			/* IN */
+	size_t  scontext_len,			/* IN */
 	security_id_t *out_sid);		/* OUT */
=20
 /*
@@ -147,7 +147,7 @@
 int security_node_sid(
 	__u16 domain,
 	void *addr,
-	__u32 addrlen,
+	size_t addrlen,
 	security_id_t *out_sid);
=20
 /*
--- hashtab.c	(.../upstream/current/checkpolicy)	(revision 86)
+++ hashtab.c	(.../trunk/checkpolicy)	(revision 86)
@@ -17,7 +17,7 @@
 			 unsigned int size)
 {
 	hashtab_t p;
-	int i;
+	unsigned int i;
=20
=20
 	p =3D (hashtab_t) kmalloc(sizeof(hashtab_val_t),GFP_KERNEL);
@@ -187,7 +187,7 @@
=20
 void hashtab_destroy(hashtab_t h)
 {
-	int i;
+	unsigned int i;
 	hashtab_ptr_t cur, temp;
=20
=20
@@ -217,7 +217,7 @@
 			      void *args),
 		void *args)
 {
-	int i, ret;
+	unsigned int i, ret;
 	hashtab_ptr_t cur;
=20
=20
@@ -246,7 +246,8 @@
 						  void *args),
 				 void *args)
 {
-	int i, ret;
+	unsigned int i;
+	int ret;
 	hashtab_ptr_t last, cur, temp;
=20
=20
@@ -283,7 +284,8 @@
=20
 void hashtab_hash_eval(hashtab_t h, char *tag)
 {
-	int i, chain_len, slots_used, max_chain_len;
+	unsigned int i;
+	int chain_len, slots_used, max_chain_len;
 	hashtab_ptr_t cur;
=20
=20
--- context.h	(.../upstream/current/checkpolicy)	(revision 86)
+++ context.h	(.../trunk/checkpolicy)	(revision 86)
@@ -80,18 +80,18 @@
=20
 #else
=20
-static inline void mls_context_init(context_struct_t *c)
+static inline void mls_context_init(context_struct_t *c __attribute__ ((un=
used)))
 { }
=20
-static inline int mls_context_cpy(context_struct_t * dst,=20
-				  context_struct_t * src)
+static inline int mls_context_cpy(context_struct_t * dst __attribute__ ((u=
nused)),=20
+				  context_struct_t * src __attribute__ ((unused)))
 { return 0; }
=20
-static inline int mls_context_cmp(context_struct_t * c1,
-                                  context_struct_t * c2)
+static inline int mls_context_cmp(context_struct_t * c1 __attribute__ ((un=
used)),
+                                  context_struct_t * c2 __attribute__ ((un=
used)))
 { return 1; }
=20
-static inline void mls_context_destroy(context_struct_t * c)
+static inline void mls_context_destroy(context_struct_t * c __attribute__ =
((unused)))
 { }
=20
 #endif
Index: write.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- write.c	(.../upstream/current/checkpolicy)	(revision 86)
+++ write.c	(.../trunk/checkpolicy)	(revision 86)
@@ -101,7 +101,7 @@
 		    FILE * fp)
 {
 	__u32 sens;
-	int items;
+	size_t items;
=20
 	sens =3D cpu_to_le32(l->sens);
 	items =3D fwrite(&sens, sizeof(__u32), 1, fp);
@@ -123,7 +123,7 @@
 				  FILE * fp)
 {
 	__u32 buf[3];
-	int items, items2;
+	size_t items, items2;
 	int rel;
=20
 	rel =3D mls_level_relation(r->level[1], r->level[0]);
@@ -163,7 +163,7 @@
 {
 	mls_perms_t *p =3D &cladatum->mlsperms;
 	__u32 buf[32];
-	int items, items2;
+	size_t items, items2;
=20
 	items =3D 0;
 	buf[items++] =3D cpu_to_le32(p->read);
@@ -227,8 +227,8 @@
 int sens_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	level_datum_t *levdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp =3D p;
=20
 	levdatum =3D (level_datum_t *) datum;
@@ -254,8 +254,8 @@
 int cat_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	cat_datum_t *catdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp =3D p;
=20
=20
@@ -317,8 +317,8 @@
 static int perm_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	perm_datum_t *perdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp =3D p;
=20
 	perdatum =3D (perm_datum_t *) datum;
@@ -343,8 +343,8 @@
 static int common_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	common_datum_t *comdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp =3D p;
=20
 	comdatum =3D (common_datum_t *) datum;
@@ -375,8 +375,8 @@
 	class_datum_t *cladatum;
 	constraint_node_t *c;
 	constraint_expr_t *e;
-	__u32 buf[32], len, len2, ncons, nexpr;
-	int items, items2;
+	__u32 buf[32], ncons, nexpr;
+	size_t items, items2, len, len2;
 	FILE *fp =3D p;
=20
 	cladatum =3D (class_datum_t *) datum;
@@ -457,8 +457,8 @@
 static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	role_datum_t *role;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp =3D p;
=20
 	role =3D (role_datum_t *) datum;
@@ -487,8 +487,8 @@
 static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	type_datum_t *typdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp =3D p;
=20
 	typdatum =3D (type_datum_t *) datum;
@@ -512,8 +512,8 @@
 static int user_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	user_datum_t *usrdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp =3D p;
=20
=20
@@ -561,8 +561,8 @@
 	ocontext_t *c;
 	genfs_t *genfs;
 	int i, j;
-	__u32 buf[32], len, config, nel;
-	size_t items, items2;
+	__u32 buf[32], config;
+	size_t items, items2, len, nel;
 	char *policydb_str =3D POLICYDB_STRING;
=20
 	config =3D 0;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- avtab.c	(.../upstream/current/checkpolicy)	(revision 86)
+++ avtab.c	(.../trunk/checkpolicy)	(revision 86)
@@ -186,9 +186,10 @@
 }
=20
=20
-int avtab_read(avtab_t * a, void * fp, __u32 config)
+int avtab_read(avtab_t * a, void * fp, __u32 config __attribute__ ((unused=
)))
 {
-	int i, rc;
+	unsigned int i;
+	int rc;
 	avtab_key_t avkey;
 	avtab_datum_t avdatum;
 	__u32 *buf;

--TiqCXmo5T1hvSQQg--

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iEYEARECAAYFAj/HFgoACgkQLkAIIn9ODhFKswCgo1shE92yg8I1VeuaWRR8CksT
S3EAoOUaynJJ3iJ6Qt4cXvAVuu8081kb
=NkcS
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
