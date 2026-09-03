Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA90412C08
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466443; cv=none; b=jgGcacV+Lx1of2jfXkbJab6uuPsu73vOdTzuKYeyzc3AACAnedMLuI9IEtsDzDFIjQYewuTSFDXM+eGOpeO8fLSzmLqVMzpy0JJfhXA0MGKRzz0RKwd0LUT0k0WWvFXLqNeNfvHPY+QPamOBlEAMWTp63CEW2NnMPmDW07zIbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466443; c=relaxed/simple;
	bh=4/3FkJsYd6TTjImedwiVQIeXt8bAJDQcjKvUv6eK+MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIDoHgUYAhYtdVi2hRQj7hExYKiqp+Rn5i5t8GjHDO5WawcIaDnk7uwSNqaqO7BTVvg2JRWDQ4ooq8B+aw5ZRJfP1wg1Cio4zaWa1zvHcRRSLasuXyE+jlyg8ECZvjS9cUbkJ/MZ5beke0Zcqy6UzTtRI1LxdtjPoGOwhRzgFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZMX1tzY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZMX1tzY"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5304310b3e0so4017391cf.3
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788466420; x=1789071220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HaPO9NqLuFsbvBSCXEUwl2HFO/NKPC9vPpxTIj+F8QA=;
        b=jZMX1tzYHxzfwlxXmTNTJLviH37BCxVxRYVlw9F4dgE3zTqm+QE8QxlkeD+J7VY+Kq
         rjG6hcJTEpP3hU00au7FcK4xtsNSlmMvEb3/Gbf45IBpOdcQXVDLSmVN7xhVfwPsiEFI
         Oc36n5u0l3eunHKluPRC5N7Rl61Um8wJn7KgPHBwlQV3SbAnvgzD8y+M5MrmnDqfRWez
         gYE3NF2C7wC0z+4vm2hJZWT1617zST3tRlmcCe6/34ymlAGeh4WHHi+abmUVfIa+aDuX
         ojAvWDhW8VlzfusDiPuyp1bjSNZs+NwXBupom4AZtJX2o3kfWRi7ZaWCa0JVG30NAV5a
         QDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788466420; x=1789071220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HaPO9NqLuFsbvBSCXEUwl2HFO/NKPC9vPpxTIj+F8QA=;
        b=RcrGv+QfBdd6YveP2BqSBgiL501uO9vvUZxJe2Ekqmy3Z32+gB6R017JmhyECKyZQu
         lCP1a7mNGxNlO6+DZOT/SSG+e2dHYqkQjZqeznrk11cjIXkSHtTGcjmGshDBLrt93vRI
         J8bEk9MehDw7hSTtv/ZFu8SnBm64nctvByy7Brel0UU7o8AfPgh6ZJO6dfXnT+1ArJ4X
         +Qsd/9b6OicrvJM0lAyjivywNmt/AeuX4T7G+qS/spoLQ9qDkFadgMJdCJ0WS245pl2n
         QXacxvjGB1/AQl0Ik7ZB31AYSoorYHSX/wjUT+0KDDDLZi1kLMQFa6u4Tm6QvxRpAjjj
         2nQw==
X-Gm-Message-State: AFuF++nsEREPw27ryBvQA/ffFa40stLTGzocEfKSbeIBtQpXHIXxIrLq
	1aqFuAaZWtI7IhJH8UOAlVvqtloI9UFWTSQuO4G/zsmaxmBcvnAq2dSXTVcw5Q==
X-Gm-Gg: AYBFou2XLFUjEmvCS1BP53BcfIirjTdYP2fEp4zwMS0yAyw5onRll1fByuYov8Q9cTe
	6fIovZ0jjiD3eqAS8qwM9oeUJHuPRE/b4a1K+nUdoqNFwoj/Q27UZrR6VwCJiT/roHYUSmZtXqA
	LQGdVNehe3aILQDad5PwoJoME6F95RtEmam7noluAaIWUUQvHN8vN2g13gFP/3yf51PNv48SIHl
	tthXcX622hu2jMfbmxg8H5t4CgzEYJxX29VWFy8ECFhrZOKYET2wiS2UhTgQ32Yrt1Aemw5bbQN
	EcyJ2n/ipOeVH9VDMTC1xt3X7qKuafJCMZMxMlKJMv5jPT41X/W5wZM0juHzAQ/i0WsU2UUQZcB
	nMoXOJ1krjuNIQIEZ3HXvgv7kJ38qo+IXA1+snsFeWa2w6X3c8CFG54FpFVy6ZKyebm35LmJKG0
	hctn35EPeo7ZwKEmodyAhvwmcutt0NFJtwk5lThKdN0OKmQiL9jo+Le2hOzntVEIU/PLIFk4Xdq
	rSRUJGWxqs=
X-Received: by 2002:a05:622a:598e:b0:528:601:301e with SMTP id d75a77b69052e-53054944547mr15674021cf.26.1788466419457;
        Thu, 03 Sep 2026 13:13:39 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305413ce9dsm4855391cf.11.2026.09.03.13.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:13:38 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Improve validation of scopes
Date: Thu,  3 Sep 2026 16:13:23 -0400
Message-ID: <20260903201323.138212-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The validation of scopes can be improved in several ways.

For non-kernel policies and excluding the commons scope table, every
key found in a symbol table should also be in the correspondeing
scope table and vice versa. To validate this, verify that symbol and
scope tables with the same flavor have the same number of elements
and then check that each key found in a scope table can also be found
in the matching symbol table. The function scope_read() in policydb.c
also checks that scope keys can be found in the symbol tables, so
remove that check to consolidate validation.

The commons scope table is always be empty for all policies, so fail
validation if it is not.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb.c          |  5 ----
 libsepol/src/policydb_validate.c | 39 ++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 3dd3ac4f..81c8da82 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3903,11 +3903,6 @@ static int scope_read(policydb_t *p, int symnum, struct policy_file *fp)
 	if (rc < 0)
 		goto cleanup;
 
-	/* ensure that there already exists a symbol with this key */
-	if (hashtab_search(p->symtab[symnum].table, key) == NULL) {
-		goto cleanup;
-	}
-
 	if ((scope = calloc(1, sizeof(*scope))) == NULL) {
 		goto cleanup;
 	}
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 34182e8e..5b2e94ea 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -38,6 +38,11 @@ typedef struct perm_arg {
 	const uint32_t inherited_nprim;
 } perm_arg_t;
 
+typedef struct scope_arg {
+	const symtab_t *symtab;
+	uint32_t num_decls;
+} scope_arg_t;
+
 static int create_gap_ebitmap(char **val_to_name, uint32_t nprim,
 			      ebitmap_t *gaps)
 {
@@ -210,11 +215,10 @@ bad:
 	return -1;
 }
 
-static int validate_scope(__attribute__((unused)) hashtab_key_t k,
-			  hashtab_datum_t d, void *args)
+static int validate_scope(hashtab_key_t k, hashtab_datum_t d, void *args)
 {
 	const scope_datum_t *scope_datum = (scope_datum_t *)d;
-	const uint32_t *nprim = (uint32_t *)args;
+	scope_arg_t *sargs = (scope_arg_t *)args;
 	uint32_t i;
 
 	switch (scope_datum->scope) {
@@ -226,10 +230,13 @@ static int validate_scope(__attribute__((unused)) hashtab_key_t k,
 	}
 
 	for (i = 0; i < scope_datum->decl_ids_len; i++) {
-		if (!value_isvalid(scope_datum->decl_ids[i], *nprim))
+		if (!value_isvalid(scope_datum->decl_ids[i], sargs->num_decls))
 			goto bad;
 	}
 
+	if (!hashtab_search(sargs->symtab->table, k))
+		goto bad;
+
 	return 0;
 
 bad:
@@ -237,20 +244,34 @@ bad:
 }
 
 static int validate_scopes(sepol_handle_t *handle, const symtab_t scopes[],
-			   const avrule_block_t *block)
+			   const symtab_t symtabs[], const policydb_t *p)
 {
+	scope_arg_t sargs;
+	const avrule_block_t *block;
 	const avrule_decl_t *decl;
 	unsigned int i;
 	uint32_t num_decls = 0;
 
-	for (; block != NULL; block = block->next) {
+	for (block = p->global; block != NULL; block = block->next) {
 		for (decl = block->branch_list; decl; decl = decl->next) {
 			num_decls++;
 		}
 	}
 
-	for (i = 0; i < SYM_NUM; i++) {
-		if (hashtab_map(scopes[i].table, validate_scope, &num_decls))
+	if (scopes[SYM_COMMONS].table->nel != 0)
+		goto bad;
+
+	if (p->policy_type != POLICY_KERN) {
+		for (i = 1; i < SYM_NUM; i++) {
+			if (scopes[i].table->nel != symtabs[i].table->nel)
+				goto bad;
+		}
+	}
+
+	sargs.num_decls = num_decls;
+	for (i = 1; i < SYM_NUM; i++) {
+		sargs.symtab = &symtabs[i];
+		if (hashtab_map(scopes[i].table, validate_scope, &sargs))
 			goto bad;
 	}
 
@@ -2152,7 +2173,7 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 	if (validate_genfs(handle, p, flavors))
 		goto bad;
 
-	if (validate_scopes(handle, p->scope, p->global))
+	if (validate_scopes(handle, p->scope, p->symtab, p))
 		goto bad;
 
 	if (validate_datum_array_gaps(handle, p, flavors))
-- 
2.55.0

