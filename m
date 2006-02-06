Message-Id: <200602062234.k16MYuNq012281@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
   "Chad Hanson" <chanson@TrustedCS.com>
Subject: [PATCH 2/3] libsepol - fix aliased sensitivities
Date: Mon, 6 Feb 2006 17:34:56 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01ED_01C62B43.A544A3A0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_01ED_01C62B43.A544A3A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This second patch fixes reading sensitivities from disk.  Basically we want
the aliased sens to have to the same cat bitmap instance as the
corresponding primary sens.

Kevin Carr
Tresys Technology
410.290.1411 x137


------=_NextPart_000_01ED_01C62B43.A544A3A0
Content-Type: application/octet-stream;
	name="aliased-sens-reading.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="aliased-sens-reading.patch"

Index: libsepol/include/sepol/policydb/policydb.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- libsepol/include/sepol/policydb/policydb.h	(revision 481)
+++ libsepol/include/sepol/policydb/policydb.h	(working copy)
@@ -392,6 +392,7 @@
 	role_datum_t **role_val_to_struct;
 	user_datum_t **user_val_to_struct;
 	type_datum_t **type_val_to_struct;
+	level_datum_t **sens_val_to_struct;
=20
        =20
         /* module stuff section -- used in parsing and for modules */
Index: libsepol/src/policydb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- libsepol/src/policydb.c	(revision 481)
+++ libsepol/src/policydb.c	(working copy)
@@ -564,6 +564,7 @@
 		    levdatum->level->sens > p->p_levels.nprim)
 			return -EINVAL;
 		p->p_sens_val_to_name[levdatum->level->sens - 1] =3D (char *)key;
+		p->sens_val_to_struct[levdatum->level->sens - 1] =3D levdatum;
 	}
=20
 	return 0;
@@ -700,6 +701,16 @@
 	memset(p->type_val_to_struct, 0,=20
 	       p->p_types.nprim*sizeof(type_datum_t *));
=20
+	if (p->mls) {
+		free(p->sens_val_to_struct);
+		p->sens_val_to_struct =3D (level_datum_t **)
+		    malloc(p->p_levels.nprim * sizeof(level_datum_t *));
+		if (!p->sens_val_to_struct)
+			return -1;
+		memset(p->sens_val_to_struct, 0,=20
+		       p->p_levels.nprim*sizeof(level_datum_t *));
+	}
+
 	cond_init_bool_indexes(p);
=20
 	for (i =3D SYM_ROLES; i < SYM_NUM; i++) {
@@ -886,6 +899,7 @@
 		free(p->user_val_to_struct);
 	if (p->type_val_to_struct)
 		free(p->type_val_to_struct);
+	free(p->sens_val_to_struct);
=20
 	for (i =3D 0; i < SYM_NUM; i++) {
 		hashtab_map(p->scope[i].table, scope_destroy, 0);
@@ -2629,6 +2643,9 @@
 	if (policydb_index_others(fp->handle, p, verbose))
 		goto bad;
=20
+	if (mls_remap_sens_aliases(p))
+		goto bad;
+
 	if (ocontext_read (info, p, fp) =3D=3D -1) {
                 goto bad;
         }
Index: libsepol/src/mls.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- libsepol/src/mls.c	(revision 481)
+++ libsepol/src/mls.c	(working copy)
@@ -677,3 +677,26 @@
 	free(con);
 	return ret;
 }
+
+static int mls_resolve_sens_alias(hashtab_key_t k __attribute__ =
((unused)), hashtab_datum_t d, void *args)
+{
+	level_datum_t *levdatum =3D (level_datum_t *) d;
+	mls_level_t *level =3D levdatum->level;
+	policydb_t *p =3D (policydb_t *) args;
+	if (!levdatum->isalias) {
+		return 0;
+	}
+	levdatum->level =3D p->sens_val_to_struct[level->sens - 1]->level;
+	ebitmap_destroy(&level->cat);
+	free(level);
+	return 0;
+}
+
+/* Go through all sensitivities declared in the toplevel of the
+ * policy.  For those marked as aliases, point their level data to the
+ * primary's level.  Note that this routine will not remap
+ * sensitivities declared inside any avrule_block_t. */
+int mls_remap_sens_aliases(policydb_t *p)
+{
+	return hashtab_map(p->p_levels.table, mls_resolve_sens_alias, p);
+}
Index: libsepol/src/mls.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- libsepol/src/mls.h	(revision 481)
+++ libsepol/src/mls.h	(working copy)
@@ -78,5 +78,7 @@
         context_struct_t *fromcon, user_datum_t *user,
         context_struct_t *usercon, int mls);
=20
+extern int mls_remap_sens_aliases(policydb_t *p);
+
 #endif
=20

------=_NextPart_000_01ED_01C62B43.A544A3A0--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
