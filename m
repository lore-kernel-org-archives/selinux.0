Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABE9C4332F
	for <selinux@archiver.kernel.org>; Wed,  8 Nov 2023 10:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjKHKab (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Nov 2023 05:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjKHKaa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Nov 2023 05:30:30 -0500
X-Greylist: delayed 910 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 02:30:28 PST
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519041BDA
        for <selinux@vger.kernel.org>; Wed,  8 Nov 2023 02:30:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699438508; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=TSKyyz+2BxLURx8ezzTw6+yJGl2SHupQwlcj9yOampTkRR9Kvr5SND4Lora7O0MwhoO6Lr2SsOn1wRLDFIhI4/67KucFQAG9YN0rNsujxFjZ7TZBjEgHK3p+Nn/3Y5lXFbkdU3OePtm3Vyww1mIqfgym0J5s6Csl4NtN8fTqVVc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1699438508; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=Or3Kctt0Bbmik8DpUYhMcW9IjXSd7hEIE31VwdeGPjg=; 
        b=iiXFnbmHLyumVBpF1NKzSBPyI5lToDW1FBJd4u7BLcZgHqpeLxFqdlttxScs2sbXFvlNZPYmd3Sr3v4TxM/BuriTIG6kYM4J9deq6KibUGdlHqdtOSIuq6Vmg1wjdw9LvDOGtpf06OrtL7eG9iLrJqKbJlUmPlu1vVeLmQXCm4s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1699438508;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Or3Kctt0Bbmik8DpUYhMcW9IjXSd7hEIE31VwdeGPjg=;
        b=GxGIePgxFdT7l5plRQM9In53kSorjBnypmgotA5W9ulppD9UVHb9edX4O/DrWw5O
        cvSiKzYDC9moUff/pO16H4phkbI3AiDHJUI9zDtpYkpHHW2u2bE7yI9hAvCZ+cZB/0G
        1q6GkWyNJkYAHOv/UYO1rJwcHaXH0ydC+Sj7WsmI=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1699438505965160.0077037824159; Wed, 8 Nov 2023 11:15:05 +0100 (CET)
Received: from jmarcin-t14s-01.brq.redhat.com (unknown [213.175.37.10])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id B518A20890FD;
        Wed,  8 Nov 2023 10:15:04 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v3] selinux: add prefix/suffix matching to filename type transitions
Date:   Wed,  8 Nov 2023 11:13:56 +0100
Message-ID: <20231108101427.3514509-1-juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, filename transitions are stored separately from other type
enforcement rules and only support exact name matching. However, in
practice, the names contain variable parts. This leads to many
duplicated rules in the policy that differ only in the part of the name,
or it is even impossible to cover all possible combinations.

This patch changes the filename transition table in the policydb
structure into an array of three tables, where the index determines the
match type for the rules contained (extract, prefix, and suffix match).
Then the patch extends the functions that access the table through the
policydb structure to accompany this change while reusing the majority
of the old filename transitions code.

This patch also updates the code responsible for finding the right
filename transition based on the context and the name. The rules have
the following order of prioriy, if no matching rule is found, the code
moves on to the next category:
- exact filename transitions,
- prefix filename transitions in the order of the longest prefix match,
- suffix filename transitions in the order of the longest suffix match.
This ensures the compatibility with older policies.

Without prefix/suffix rules in the policy, this patch has no impact on
performance or policy loading times. Moreover, with prefix/suffix rules,
the overall number of filename transitions can be reduced, which results
in smaller binary policy size and therefore also slightly lower load
time and memory usage.

Performance tests:

1: Reference kernel (f5bbdeda34c63), Fedora policy (format v33)
2: This patch, Fedora policy (format v33)
3: This patch, Fedora policy without prefix/suffix rules (format v34)
4: This patch, Fefora policy with prefix rules (format v35)

   | Mem    | Binary | Policy  | Create tty [1]       | osbench [2]
   | Usage  | policy | load    |                      | create
   |        | size   | time    | (ms/file)            | files
   | (MiB)  | (KiB)  | (ms)    | real     | kernel    | (us/file)
---+--------+--------+---------+----------+-----------+-----------
 1 |  298.7 |   3682 |  58.626 |   1.0228 |    0.6793 |    8.4916
   | sd=3D4.1 |        | sd=3D0.47 | sd=3D0.058 | sd=3D0.0497 |  sd=3D0.1=
31
 2 |  296.3 |   3682 |  58.915 |   1.0209 |    0.6752 |    8.5728
   | sd=3D3.9 |        | sd=3D0.28 | sd=3D0.021 | sd=3D0.0244 |  sd=3D0.1=
56
 3 |  295.7 |   3682 |  56.374 |   1.0160 |    0.6616 |    8.7467
   | sd=3D2.6 |        | sd=3D0.44 | sd=3D0.008 | sd=3D0.0141 |  sd=3D0.1=
26
 4 |  296.2 |   2585 |  51.434 |   1.0116 |    0.6699 |    8.7467
   | sd=3D4.1 |        | sd=3D0.39 | sd=3D0.012 | sd=3D0.0115 |  sd=3D0.1=
26

[1] Create test_tty benchmark:

    mknod /dev/test_tty c 4 1
    time for i in `seq 1 10000`; do
        mknod /dev/test_tty$i c 4 1
    done

This benchmark should simulate the worst case scenario as many filename
transitions affect files created in the /dev directory.

[2] https://github.com/mbitsnbites/osbench

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
v3:
- reworked the solution from scratch, this time only adding the
  prefix/suffix matching feature without moving filename transition
  rules to the avtab
---
 security/selinux/include/security.h |  3 +-
 security/selinux/ss/policydb.c      | 96 ++++++++++++++++++++++-------
 security/selinux/ss/policydb.h      | 12 +++-
 security/selinux/ss/services.c      | 57 ++++++++++++++---
 4 files changed, 134 insertions(+), 34 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
index a9de89af8fdc5..943dfe7ede834 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -46,10 +46,11 @@
 #define POLICYDB_VERSION_INFINIBAND		31
 #define POLICYDB_VERSION_GLBLUB		32
 #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitio=
ns */
+#define POLICYDB_VERSION_PREFIX_SUFFIX	34 /* prefix/suffix filename tran=
sitions */
=20
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COMP_FTRANS
+#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_PREFIX_SUFFIX
=20
 /* Mask for just the mount related flags */
 #define SE_MNTMASK	0x0f
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
index 595a435ea9c85..10e692346688a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -157,6 +157,11 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 		.sym_num	=3D SYM_NUM,
 		.ocon_num	=3D OCON_NUM,
 	},
+	{
+		.version	=3D POLICYDB_VERSION_PREFIX_SUFFIX,
+		.sym_num	=3D SYM_NUM,
+		.ocon_num	=3D OCON_NUM,
+	},
 };
=20
 static const struct policydb_compat_info *policydb_lookup_compat(unsigne=
d int version)
@@ -444,10 +449,33 @@ static const struct hashtab_key_params filenametr_k=
ey_params =3D {
 	.cmp =3D filenametr_cmp,
 };
=20
-struct filename_trans_datum *policydb_filenametr_search(
-	struct policydb *p, struct filename_trans_key *key)
+/**
+ * policydb_filenametr_search() - Search for filename transition in poli=
cy
+ * @p: policydb structure to search in
+ * @match_type: filename transition match type to search for
+ * @key: key to search for
+ * @stype: source type to search for, when stype is zero, the function w=
ill
+ *         return head of the linked list with matching key, otherwise i=
t will
+ *         traverse the linked list to find the item with matching stype
+ *
+ * Return: head of the linked list of filename transition datums or sing=
le item
+ * 	   of the list, based on the stype value
+ */
+struct filename_trans_datum *policydb_filenametr_search(struct policydb =
*p,
+	unsigned int match_type, struct filename_trans_key *key, u32 stype)
 {
-	return hashtab_search(&p->filename_trans, key, filenametr_key_params);
+	struct filename_trans_datum *datum =3D hashtab_search(
+		&p->filename_trans[match_type], key, filenametr_key_params);
+
+	if (stype) {
+		while (datum) {
+			if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
+				return datum;
+			}
+			datum =3D datum->next;
+		}
+	}
+	return datum;
 }
=20
 static u32 rangetr_hash(const void *k)
@@ -840,8 +868,10 @@ void policydb_destroy(struct policydb *p)
 	}
 	kfree(lra);
=20
-	hashtab_map(&p->filename_trans, filenametr_destroy, NULL);
-	hashtab_destroy(&p->filename_trans);
+	for (unsigned int i =3D 0; i < FILENAME_TRANS_MATCH_NUM; i++) {
+		hashtab_map(&p->filename_trans[i], filenametr_destroy, NULL);
+		hashtab_destroy(&p->filename_trans[i]);
+	}
=20
 	hashtab_map(&p->range_tr, range_tr_destroy, NULL);
 	hashtab_destroy(&p->range_tr);
@@ -1916,7 +1946,9 @@ static int filename_trans_read_helper_compat(struct=
 policydb *p, void *fp)
 	otype =3D le32_to_cpu(buf[3]);
=20
 	last =3D NULL;
-	datum =3D policydb_filenametr_search(p, &key);
+	// this version does not support other than exact match
+	datum =3D policydb_filenametr_search(p, FILENAME_TRANS_MATCH_EXACT, &ke=
y,
+					   0);
 	while (datum) {
 		if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
 			/* conflicting/duplicate rules are ignored */
@@ -1946,8 +1978,9 @@ static int filename_trans_read_helper_compat(struct=
 policydb *p, void *fp)
 			if (!ft)
 				goto out;
=20
-			rc =3D hashtab_insert(&p->filename_trans, ft, datum,
-					    filenametr_key_params);
+			rc =3D hashtab_insert(
+				&p->filename_trans[FILENAME_TRANS_MATCH_EXACT],
+				ft, datum, filenametr_key_params);
 			if (rc)
 				goto out;
 			name =3D NULL;
@@ -1968,7 +2001,8 @@ static int filename_trans_read_helper_compat(struct=
 policydb *p, void *fp)
 	return rc;
 }
=20
-static int filename_trans_read_helper(struct policydb *p, void *fp)
+static int filename_trans_read_helper(struct policydb *p, void *fp,
+				      unsigned int match_type)
 {
 	struct filename_trans_key *ft =3D NULL;
 	struct filename_trans_datum **dst, *datum, *first =3D NULL;
@@ -2035,7 +2069,7 @@ static int filename_trans_read_helper(struct policy=
db *p, void *fp)
 	ft->tclass =3D tclass;
 	ft->name =3D name;
=20
-	rc =3D hashtab_insert(&p->filename_trans, ft, first,
+	rc =3D hashtab_insert(&p->filename_trans[match_type], ft, first,
 			    filenametr_key_params);
 	if (rc =3D=3D -EEXIST)
 		pr_err("SELinux:  Duplicate filename transition key\n");
@@ -2057,7 +2091,8 @@ static int filename_trans_read_helper(struct policy=
db *p, void *fp)
 	return rc;
 }
=20
-static int filename_trans_read(struct policydb *p, void *fp)
+static int filename_trans_read(struct policydb *p, void *fp,
+			       unsigned int match_type)
 {
 	u32 nel, i;
 	__le32 buf[1];
@@ -2074,27 +2109,28 @@ static int filename_trans_read(struct policydb *p=
, void *fp)
 	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
 		p->compat_filename_trans_count =3D nel;
=20
-		rc =3D hashtab_init(&p->filename_trans, (1 << 11));
+		rc =3D hashtab_init(&p->filename_trans[match_type], (1 << 11));
 		if (rc)
 			return rc;
=20
 		for (i =3D 0; i < nel; i++) {
+			// this version does not support other than exact match
 			rc =3D filename_trans_read_helper_compat(p, fp);
 			if (rc)
 				return rc;
 		}
 	} else {
-		rc =3D hashtab_init(&p->filename_trans, nel);
+		rc =3D hashtab_init(&p->filename_trans[match_type], nel);
 		if (rc)
 			return rc;
=20
 		for (i =3D 0; i < nel; i++) {
-			rc =3D filename_trans_read_helper(p, fp);
+			rc =3D filename_trans_read_helper(p, fp, match_type);
 			if (rc)
 				return rc;
 		}
 	}
-	hash_eval(&p->filename_trans, "filenametr");
+	hash_eval(&p->filename_trans[match_type], "filenametr");
 	return 0;
 }
=20
@@ -2643,9 +2679,17 @@ int policydb_read(struct policydb *p, void *fp)
 		lra =3D ra;
 	}
=20
-	rc =3D filename_trans_read(p, fp);
+	rc =3D filename_trans_read(p, fp, FILENAME_TRANS_MATCH_EXACT);
 	if (rc)
 		goto bad;
+	if (p->policyvers >=3D POLICYDB_VERSION_PREFIX_SUFFIX) {
+		rc =3D filename_trans_read(p, fp, FILENAME_TRANS_MATCH_PREFIX);
+		if (rc)
+			goto bad;
+		rc =3D filename_trans_read(p, fp, FILENAME_TRANS_MATCH_SUFFIX);
+		if (rc)
+			goto bad;
+	}
=20
 	rc =3D policydb_index(p);
 	if (rc)
@@ -3576,7 +3620,8 @@ static int filename_write_helper(void *key, void *d=
ata, void *ptr)
 	return 0;
 }
=20
-static int filename_trans_write(struct policydb *p, void *fp)
+static int filename_trans_write(struct policydb *p, void *fp,
+				unsigned int match_type)
 {
 	__le32 buf[1];
 	int rc;
@@ -3590,15 +3635,16 @@ static int filename_trans_write(struct policydb *=
p, void *fp)
 		if (rc)
 			return rc;
=20
-		rc =3D hashtab_map(&p->filename_trans,
+		rc =3D hashtab_map(&p->filename_trans[match_type],
 				 filename_write_helper_compat, fp);
 	} else {
-		buf[0] =3D cpu_to_le32(p->filename_trans.nel);
+		buf[0] =3D cpu_to_le32(p->filename_trans[match_type].nel);
 		rc =3D put_entry(buf, sizeof(u32), 1, fp);
 		if (rc)
 			return rc;
=20
-		rc =3D hashtab_map(&p->filename_trans, filename_write_helper, fp);
+		rc =3D hashtab_map(&p->filename_trans[match_type],
+				 filename_write_helper, fp);
 	}
 	return rc;
 }
@@ -3713,9 +3759,17 @@ int policydb_write(struct policydb *p, void *fp)
 	if (rc)
 		return rc;
=20
-	rc =3D filename_trans_write(p, fp);
+	rc =3D filename_trans_write(p, fp, FILENAME_TRANS_MATCH_EXACT);
 	if (rc)
 		return rc;
+	if (p->policyvers >=3D POLICYDB_VERSION_PREFIX_SUFFIX) {
+		rc =3D filename_trans_write(p, fp, FILENAME_TRANS_MATCH_PREFIX);
+		if (rc)
+			return rc;
+		rc =3D filename_trans_write(p, fp, FILENAME_TRANS_MATCH_SUFFIX);
+		if (rc)
+			return rc;
+	}
=20
 	rc =3D ocontext_write(p, info, fp);
 	if (rc)
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policyd=
b.h
index b97cda489753d..7bd0ecb8ed697 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -235,6 +235,13 @@ struct genfs {
 #define OCON_IBENDPORT	8 /* Infiniband end ports */
 #define OCON_NUM	9
=20
+enum {
+	FILENAME_TRANS_MATCH_EXACT,
+	FILENAME_TRANS_MATCH_PREFIX,
+	FILENAME_TRANS_MATCH_SUFFIX,
+	FILENAME_TRANS_MATCH_NUM,
+};
+
 /* The policy database */
 struct policydb {
 	int mls_enabled;
@@ -269,7 +276,7 @@ struct policydb {
 	/* quickly exclude lookups when parent ttype has no rules */
 	struct ebitmap filename_trans_ttypes;
 	/* actual set of filename_trans rules */
-	struct hashtab filename_trans;
+	struct hashtab filename_trans[FILENAME_TRANS_MATCH_NUM];
 	/* only used if policyvers < POLICYDB_VERSION_COMP_FTRANS */
 	u32 compat_filename_trans_count;
=20
@@ -325,7 +332,8 @@ extern int policydb_read(struct policydb *p, void *fp=
);
 extern int policydb_write(struct policydb *p, void *fp);
=20
 extern struct filename_trans_datum *policydb_filenametr_search(
-	struct policydb *p, struct filename_trans_key *key);
+	struct policydb *p, unsigned int match_type,
+	struct filename_trans_key *key, u32 stype);
=20
 extern struct mls_range *policydb_rangetr_search(
 	struct policydb *p, struct range_trans *key);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
index 1eeffc66ea7d7..cdfc662aaba40 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1661,13 +1661,16 @@ static int compute_sid_handle_invalid_context(
 	return -EACCES;
 }
=20
-static void filename_compute_type(struct policydb *policydb,
+static int filename_compute_type(struct policydb *policydb,
 				  struct context *newcontext,
 				  u32 stype, u32 ttype, u16 tclass,
 				  const char *objname)
 {
 	struct filename_trans_key ft;
 	struct filename_trans_datum *datum;
+	size_t name_len =3D strlen(objname);
+	size_t i;
+	char *name_copy;
=20
 	/*
 	 * Most filename trans rules are going to live in specific directories
@@ -1675,20 +1678,50 @@ static void filename_compute_type(struct policydb=
 *policydb,
 	 * if the ttype does not contain any rules.
 	 */
 	if (!ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype))
-		return;
+		return 0;
=20
 	ft.ttype =3D ttype;
 	ft.tclass =3D tclass;
+
+	/* Search for exact rules */
 	ft.name =3D objname;
+	datum =3D policydb_filenametr_search(policydb, FILENAME_TRANS_MATCH_EXA=
CT,
+					   &ft, stype);
+	if (datum) {
+		newcontext->type =3D datum->otype;
+		return 0;
+	}
=20
-	datum =3D policydb_filenametr_search(policydb, &ft);
-	while (datum) {
-		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
+	/* Search for prefix rules */
+	name_copy =3D kstrdup(objname, GFP_KERNEL);
+	if (!name_copy)
+		return -ENOMEM;
+	ft.name =3D name_copy;
+	for (i =3D name_len; i > 0; i--) {
+		name_copy[i] =3D '\0';
+		datum =3D policydb_filenametr_search(policydb,
+						   FILENAME_TRANS_MATCH_PREFIX,
+						   &ft, stype);
+		if (datum) {
 			newcontext->type =3D datum->otype;
-			return;
+			kfree(name_copy);
+			return 0;
 		}
-		datum =3D datum->next;
 	}
+	kfree(name_copy);
+
+	/* Search for suffix rules */
+	for (i =3D 0; i < name_len; i++) {
+		ft.name =3D &objname[i];
+		datum =3D policydb_filenametr_search(policydb,
+						   FILENAME_TRANS_MATCH_SUFFIX,
+						   &ft, stype);
+		if (datum) {
+			newcontext->type =3D datum->otype;
+			return 0;
+		}
+	}
+	return 0;
 }
=20
 static int security_compute_sid(u32 ssid,
@@ -1833,9 +1866,13 @@ static int security_compute_sid(u32 ssid,
 	}
=20
 	/* if we have a objname this is a file trans check so check those rules=
 */
-	if (objname)
-		filename_compute_type(policydb, &newcontext, scontext->type,
-				      tcontext->type, tclass, objname);
+	if (objname) {
+		rc =3D filename_compute_type(policydb, &newcontext,
+					   scontext->type, tcontext->type,
+					   tclass, objname);
+		if (rc)
+			goto out_unlock;
+	}
=20
 	/* Check for class-specific changes. */
 	if (specified & AVTAB_TRANSITION) {
--=20
2.41.0

