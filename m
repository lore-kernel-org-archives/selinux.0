Received: from sender-of-o53.zoho.eu (sender-of-o53.zoho.eu [136.143.169.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E814134C4
	for <selinux@vger.kernel.org>; Tue,  5 Mar 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658364; cv=pass; b=ovup2lAZvWlosdZi+qHYhbxEjvS7O9BvrEgrcABcFBU37ERJIGg6y9jzryI9tN3nj3o2STFgqUindXMng1W4pGBGhhbUSk6uUPgLEvw7wN9+OoMpLCYQN8JcdWwa21p1dCwhg3Ia1d40vAeSRszEWJciPzvZBB693IH5XmowQhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658364; c=relaxed/simple;
	bh=jSqbvTZw6Mtlrm6BbHcfokekaUAGNRdcKzShFpXYQI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJkgGxZZ1UJ55BJ/pMFkBL7j4BOae4RXrpuoq1ATTiShRk6JSf0Wf7ud78HHNhA0DPSelW5TcWHud8gGuj753jCi2aM5A/KqBxD/RODlDwtgjzgdUvvKfChaIHtMAKqjKqXyMvCl1fa3UJYknEcAY3mG/kzMdCkaqE4Xa+dKzv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jurajmarcin.com; spf=pass smtp.mailfrom=jurajmarcin.com; dkim=pass (1024-bit key) header.d=jurajmarcin.com header.i=juraj@jurajmarcin.com header.b=PW5Nmer+; arc=pass smtp.client-ip=136.143.169.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jurajmarcin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jurajmarcin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jurajmarcin.com header.i=juraj@jurajmarcin.com header.b="PW5Nmer+"
ARC-Seal: i=1; a=rsa-sha256; t=1709658348; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=P3hFQooUvQVlHyJCv/idP3HO/Ox761c+Mdkm/lfikRiJX55uKud7l2G6bNH4LCnYotSoMdX7mtvllRRGDdG1dS/V76BPqCnc6ZirwlVTHuEVRngS4So9wq5UM12uDlZzcz+70XO9BQ/Dr2GpZeNRKsxmtR5YxH7/f/nEqCVr3V4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1709658348; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kAps3O8n3C0r4ZDyO8xX0dwMVh0CC2h8DKyo58LzjIc=; 
	b=B7jP2YFHTWFoZTYSzO/ptK4azV4seoFlKvzQlDR3tiLc8peIT8JxaYjZA1BbPiCX1J5Jq5XJT5vPQR4NKgKOGjT5TbSvpeRw774vaxMiOXYzoTmsvSoviSxmURQBOtcAbBZCYT0kP3EqI/lp1kX1u0x0mT+YEIgChGfCvCawx2Y=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=jurajmarcin.com;
	spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
	dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1709658348;
	s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kAps3O8n3C0r4ZDyO8xX0dwMVh0CC2h8DKyo58LzjIc=;
	b=PW5Nmer+xhExhyUjCuQcCUyGMHLgSU0wJ6fsYI+1XD/D9KMoCKbliTy8h+bgGE1D
	a+JcKux7MCFMIEUQ2R1JVsrac3IvrcurTZOX30Ai/pFRDG/7WiIE5RH1XNLgBemQAyV
	NESq9MPLH74y4xMkaaB4mxMXq5E9TiTFRV54ixJ0=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
	with SMTPS id 1709658346174206.00521673143226; Tue, 5 Mar 2024 18:05:46 +0100 (CET)
Received: from jmarcin-t14s-01.brq.redhat.com (unknown [213.175.37.10])
	by morty01.jurajmarcin.com (Postfix) with ESMTPSA id D001D207C09C;
	Tue,  5 Mar 2024 17:05:43 +0000 (UTC)
From: Juraj Marcin <juraj@jurajmarcin.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	selinux@vger.kernel.org,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v5] selinux: add prefix/suffix matching to filename type transitions
Date: Tue,  5 Mar 2024 18:04:52 +0100
Message-ID: <20240305170501.2185811-1-juraj@jurajmarcin.com>
In-Reply-To: <20240301125331.cijacxb4yqbum72c@jmarcin-t14s-01>
References: <20240301125331.cijacxb4yqbum72c@jmarcin-t14s-01>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
the following order of priority, if no matching rule is found, the code
moves on to the next category:
- exact filename transitions,
- prefix filename transitions in the order of the longest prefix match,
- suffix filename transitions in the order of the longest suffix match.
This ensures the compatibility with older policies.

Lastly, this patch adds an attribute containing the explicit length of
the name string in the filename transition key to allow using only
prefix of a constant string as key.

Without prefix/suffix rules in the policy, this patch has no impact on
performance or policy loading times. Moreover, with prefix/suffix rules,
the overall number of filename transitions can be reduced, which results
in smaller binary policy size and therefore also slightly lower load
time and memory usage.

Performance tests:

1: Reference kernel (a1fc79343abbd), Fedora policy (format v33)
2: This patch, Fedora policy (format v33)
3: This patch, Fedora policy without prefix/suffix rules (format v34)
4: This patch, Fedora policy with prefix rules (format v35)

   | Mem   | Binary | Policy  | Create    | osbench [2]
   | Usage | policy | load    | tty [1]   | create
   |       | size   | time    |           | files
   | (MiB) | (KiB)  | (ms)    | (ms/file) | (us/file)
---+-------+--------+---------+-----------+-----------
 1 |   430 |   3682 |  46.930 |    2.4569 |   43.4431
   | sd=3D 8 |        | sd=3D0.25 |  sd=3D0.043 |  sd=3D0.434
 2 |   410 |   3682 |  46.829 |    2.4623 |   43.4112
   | sd=3D20 |        | sd=3D0.27 |  sd=3D0.053 |  sd=3D0.442
 3 |   419 |   3682 |  46.823 |    2.4257 |   43.0575
   | sd=3D14 |        | sd=3D0.18 |  sd=3D0.057 |  sd=3D0.416
 4 |   420 |   2585 |  42.044 |    2.5028 |   43.7907
   | sd=3D10 |        | sd=3D0.19 |  sd=3D0.067 |  sd=3D0.382

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
v5:
- rebased to the latest pcmoore/selinux/next
- applied suggestions from Paul Moore
- added limit optimization suggested by Paul Moore
- removed string duplication by using explicit string length in
  filename trasition key
---
v4:
- rebased to the latest pcmoore/selinux/next
- fixed non-atomic allocation in atomic section
---
v3:
- reworked the solution from scratch, this time only adding the
  prefix/suffix matching feature without moving filename transition
  rules to the avtab
---
 security/selinux/include/security.h |   4 +-
 security/selinux/ss/policydb.c      | 132 ++++++++++++++++++++++------
 security/selinux/ss/policydb.h      |  14 ++-
 security/selinux/ss/services.c      |  72 ++++++++++++---
 4 files changed, 178 insertions(+), 44 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
index 289bf9233f714..49a043633173c 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -46,10 +46,12 @@
 #define POLICYDB_VERSION_INFINIBAND	     31
 #define POLICYDB_VERSION_GLBLUB		     32
 #define POLICYDB_VERSION_COMP_FTRANS	     33 /* compressed filename tran=
sitions */
+#define POLICYDB_VERSION_COMP_FTRANS	     33 /* compressed filename tran=
sitions */
+#define POLICYDB_VERSION_PREFIX_SUFFIX	     34 /* prefix/suffix filename=
 transitions */
=20
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COMP_FTRANS
+#define POLICYDB_VERSION_MAX POLICYDB_VERSION_PREFIX_SUFFIX
=20
 /* Mask for just the mount related flags */
 #define SE_MNTMASK 0x0f
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
index 3d22d5baa829b..5de22ba840673 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -155,6 +155,11 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 		.sym_num =3D SYM_NUM,
 		.ocon_num =3D OCON_NUM,
 	},
+	{
+		.version	=3D POLICYDB_VERSION_PREFIX_SUFFIX,
+		.sym_num	=3D SYM_NUM,
+		.ocon_num	=3D OCON_NUM,
+	},
 };
=20
 static const struct policydb_compat_info *
@@ -412,7 +417,7 @@ static u32 filenametr_hash(const void *k)
 	const struct filename_trans_key *ft =3D k;
 	unsigned long salt =3D ft->ttype ^ ft->tclass;
=20
-	return full_name_hash((void *)salt, ft->name, strlen(ft->name));
+	return full_name_hash((void *)salt, ft->name, ft->name_len);
 }
=20
 static int filenametr_cmp(const void *k1, const void *k2)
@@ -429,7 +434,11 @@ static int filenametr_cmp(const void *k1, const void=
 *k2)
 	if (v)
 		return v;
=20
-	return strcmp(ft1->name, ft2->name);
+	v =3D strncmp(ft1->name, ft2->name, min(ft1->name_len, ft2->name_len));
+	if (ft1->name_len =3D=3D ft2->name_len || v)
+		return v;
+	/* if one name is prefix of the other, the longer is greater */
+	return (int)ft1->name_len - (int)ft2->name_len;
 }
=20
 static const struct hashtab_key_params filenametr_key_params =3D {
@@ -437,10 +446,34 @@ static const struct hashtab_key_params filenametr_k=
ey_params =3D {
 	.cmp =3D filenametr_cmp,
 };
=20
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
+ *         of the list, based on the stype value
+ */
 struct filename_trans_datum *
-policydb_filenametr_search(struct policydb *p, struct filename_trans_key=
 *key)
+policydb_filenametr_search(struct policydb *p, unsigned int match_type,
+			   struct filename_trans_key *key, u32 stype)
 {
-	return hashtab_search(&p->filename_trans, key, filenametr_key_params);
+	struct filename_trans_datum *datum =3D hashtab_search(
+		&p->filename_trans[match_type], key, filenametr_key_params);
+	if (!datum || !stype)
+		return datum;
+
+	while (datum) {
+		if (ebitmap_get_bit(&datum->stypes, stype - 1))
+			return datum;
+
+		datum =3D datum->next;
+	}
+	return datum;
 }
=20
 static u32 rangetr_hash(const void *k)
@@ -520,6 +553,7 @@ struct role_trans_datum *policydb_roletr_search(struc=
t policydb *p,
  */
 static void policydb_init(struct policydb *p)
 {
+	size_t i;
 	memset(p, 0, sizeof(*p));
=20
 	avtab_init(&p->te_avtab);
@@ -528,6 +562,9 @@ static void policydb_init(struct policydb *p)
 	ebitmap_init(&p->filename_trans_ttypes);
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
+
+	for (i =3D 0; i < FILENAME_TRANS_MATCH_NUM; i++)
+		p->filename_trans_name_min[i] =3D U32_MAX;
 }
=20
 /*
@@ -831,8 +868,10 @@ void policydb_destroy(struct policydb *p)
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
@@ -1934,11 +1973,17 @@ static int filename_trans_read_helper_compat(stru=
ct policydb *p, void *fp)
 	key.ttype =3D le32_to_cpu(buf[1]);
 	key.tclass =3D le32_to_cpu(buf[2]);
 	key.name =3D name;
+	key.name_len =3D len;
=20
 	otype =3D le32_to_cpu(buf[3]);
=20
 	last =3D NULL;
-	datum =3D policydb_filenametr_search(p, &key);
+	/*
+	 * this version does not support other than exact match,
+	 * therefore there is also no need to save name max/min
+	 */
+	datum =3D policydb_filenametr_search(p, FILENAME_TRANS_MATCH_EXACT, &ke=
y,
+					   0);
 	while (datum) {
 		if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
 			/* conflicting/duplicate rules are ignored */
@@ -1968,8 +2013,9 @@ static int filename_trans_read_helper_compat(struct=
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
@@ -1990,7 +2036,8 @@ static int filename_trans_read_helper_compat(struct=
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
@@ -2010,6 +2057,12 @@ static int filename_trans_read_helper(struct polic=
ydb *p, void *fp)
 	if (rc)
 		return rc;
=20
+	/* save name len to limit prefix/suffix lookups later */
+	if (len > p->filename_trans_name_max[match_type])
+		p->filename_trans_name_max[match_type] =3D len;
+	if (len < p->filename_trans_name_min[match_type])
+		p->filename_trans_name_min[match_type] =3D len;
+
 	rc =3D next_entry(buf, fp, sizeof(u32) * 3);
 	if (rc)
 		goto out;
@@ -2056,8 +2109,9 @@ static int filename_trans_read_helper(struct policy=
db *p, void *fp)
 	ft->ttype =3D ttype;
 	ft->tclass =3D tclass;
 	ft->name =3D name;
+	ft->name_len =3D len;
=20
-	rc =3D hashtab_insert(&p->filename_trans, ft, first,
+	rc =3D hashtab_insert(&p->filename_trans[match_type], ft, first,
 			    filenametr_key_params);
 	if (rc =3D=3D -EEXIST)
 		pr_err("SELinux:  Duplicate filename transition key\n");
@@ -2079,7 +2133,8 @@ static int filename_trans_read_helper(struct policy=
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
@@ -2096,27 +2151,30 @@ static int filename_trans_read(struct policydb *p=
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
+			/*
+			 * this version does not support other than exact match
+			 */
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
@@ -2676,9 +2734,17 @@ int policydb_read(struct policydb *p, void *fp)
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
@@ -3537,17 +3603,17 @@ static int filename_write_helper_compat(void *key=
, void *data, void *ptr)
 	void *fp =3D ptr;
 	__le32 buf[4];
 	int rc;
-	u32 bit, len =3D strlen(ft->name);
+	u32 bit;
=20
 	do {
 		ebitmap_for_each_positive_bit(&datum->stypes, node, bit)
 		{
-			buf[0] =3D cpu_to_le32(len);
+			buf[0] =3D cpu_to_le32(ft->name_len);
 			rc =3D put_entry(buf, sizeof(u32), 1, fp);
 			if (rc)
 				return rc;
=20
-			rc =3D put_entry(ft->name, sizeof(char), len, fp);
+			rc =3D put_entry(ft->name, sizeof(char), ft->name_len, fp);
 			if (rc)
 				return rc;
=20
@@ -3574,14 +3640,14 @@ static int filename_write_helper(void *key, void =
*data, void *ptr)
 	void *fp =3D ptr;
 	__le32 buf[3];
 	int rc;
-	u32 ndatum, len =3D strlen(ft->name);
+	u32 ndatum;
=20
-	buf[0] =3D cpu_to_le32(len);
+	buf[0] =3D cpu_to_le32(ft->name_len);
 	rc =3D put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
=20
-	rc =3D put_entry(ft->name, sizeof(char), len, fp);
+	rc =3D put_entry(ft->name, sizeof(char), ft->name_len, fp);
 	if (rc)
 		return rc;
=20
@@ -3616,7 +3682,8 @@ static int filename_write_helper(void *key, void *d=
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
@@ -3630,15 +3697,16 @@ static int filename_trans_write(struct policydb *=
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
@@ -3754,9 +3822,17 @@ int policydb_write(struct policydb *p, void *fp)
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
index 4bba386264a3d..78abb959e7205 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -93,6 +93,7 @@ struct filename_trans_key {
 	u32 ttype; /* parent dir context */
 	u16 tclass; /* class of new object */
 	const char *name; /* last path component */
+	u32 name_len; /* length of the last path component */
 };
=20
 struct filename_trans_datum {
@@ -232,6 +233,11 @@ struct genfs {
 #define OCON_IBENDPORT 8 /* Infiniband end ports */
 #define OCON_NUM       9
=20
+#define FILENAME_TRANS_MATCH_EXACT 0
+#define FILENAME_TRANS_MATCH_PREFIX 1
+#define FILENAME_TRANS_MATCH_SUFFIX 2
+#define FILENAME_TRANS_MATCH_NUM 3
+
 /* The policy database */
 struct policydb {
 	int mls_enabled;
@@ -266,9 +272,12 @@ struct policydb {
 	/* quickly exclude lookups when parent ttype has no rules */
 	struct ebitmap filename_trans_ttypes;
 	/* actual set of filename_trans rules */
-	struct hashtab filename_trans;
+	struct hashtab filename_trans[FILENAME_TRANS_MATCH_NUM];
 	/* only used if policyvers < POLICYDB_VERSION_COMP_FTRANS */
 	u32 compat_filename_trans_count;
+	/* lenghts of prefix/suffix rules to optimze for long filenames */
+	u32 filename_trans_name_max[FILENAME_TRANS_MATCH_NUM];
+	u32 filename_trans_name_min[FILENAME_TRANS_MATCH_NUM];
=20
 	/* bools indexed by (value - 1) */
 	struct cond_bool_datum **bool_val_to_struct;
@@ -322,7 +331,8 @@ extern int policydb_read(struct policydb *p, void *fp=
);
 extern int policydb_write(struct policydb *p, void *fp);
=20
 extern struct filename_trans_datum *
-policydb_filenametr_search(struct policydb *p, struct filename_trans_key=
 *key);
+policydb_filenametr_search(struct policydb *p, unsigned int match_type,
+			   struct filename_trans_key *key, u32 stype);
=20
 extern struct mls_range *policydb_rangetr_search(struct policydb *p,
 						 struct range_trans *key);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
index e88b1b6c4adbb..e142c6bdfe2ed 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1672,13 +1672,20 @@ static int compute_sid_handle_invalid_context(
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
+	size_t prefix_len;
+	size_t suffix_len;
+	size_t prefix_max;
+	size_t suffix_max;
+	size_t prefix_min;
+	size_t suffix_min;
+	size_t objname_len =3D strlen(objname);
=20
 	/*
 	 * Most filename trans rules are going to live in specific directories
@@ -1686,20 +1693,55 @@ static void filename_compute_type(struct policydb=
 *policydb,
 	 * if the ttype does not contain any rules.
 	 */
 	if (!ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype))
-		return;
+		return 0;
=20
 	ft.ttype =3D ttype;
 	ft.tclass =3D tclass;
 	ft.name =3D objname;
-
-	datum =3D policydb_filenametr_search(policydb, &ft);
-	while (datum) {
-		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
-			newcontext->type =3D datum->otype;
-			return;
-		}
-		datum =3D datum->next;
+	ft.name_len =3D objname_len;
+
+	/* Search for exact rules */
+	datum =3D policydb_filenametr_search(policydb, FILENAME_TRANS_MATCH_EXA=
CT,
+					   &ft, stype);
+	if (datum)
+		goto found;
+
+	/* Search for prefix rules */
+	prefix_max =3D min(
+		objname_len,
+		policydb->filename_trans_name_max[FILENAME_TRANS_MATCH_PREFIX]);
+	prefix_min =3D
+		policydb->filename_trans_name_min[FILENAME_TRANS_MATCH_PREFIX];
+	/* filename rule with name length 0 is invalid */
+	for (prefix_len =3D prefix_max; prefix_len >=3D prefix_min; prefix_len-=
-) {
+		ft.name_len =3D prefix_len;
+		datum =3D policydb_filenametr_search(policydb,
+						   FILENAME_TRANS_MATCH_PREFIX,
+						   &ft, stype);
+		if (datum)
+			goto found;
+	}
+
+	/* Search for suffix rules */
+	suffix_max =3D min(
+		objname_len,
+		policydb->filename_trans_name_max[FILENAME_TRANS_MATCH_SUFFIX]);
+	suffix_min =3D
+		policydb->filename_trans_name_min[FILENAME_TRANS_MATCH_SUFFIX];
+	for (suffix_len =3D suffix_max; suffix_len >=3D suffix_min; suffix_len-=
-) {
+		ft.name =3D &objname[objname_len - suffix_len];
+		ft.name_len =3D suffix_len;
+		datum =3D policydb_filenametr_search(policydb,
+						   FILENAME_TRANS_MATCH_SUFFIX,
+						   &ft, stype);
+		if (datum)
+			goto found;
 	}
+	return 0;
+
+found:
+	newcontext->type =3D datum->otype;
+	return 0;
 }
=20
 static int security_compute_sid(u32 ssid,
@@ -1844,9 +1886,13 @@ static int security_compute_sid(u32 ssid,
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
2.43.0

