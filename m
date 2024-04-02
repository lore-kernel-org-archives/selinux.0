Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EBE85262
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071783; cv=none; b=jwOAPGtzuaVzDpaBng2HxNfF0txt7t9INiq9mGSUSFICMoFUcJVNYSwGICyENzHM+E8jdZTbEZpGLDUQc+Ae1l/5xomwC7UqlFSRdAnnqyLJqrjP/9yIjViAYj9QVo8ymcddMe77IUsAEE7xez9pGeQqT31xF2INIaPo6yBdf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071783; c=relaxed/simple;
	bh=GKOFTMra7aSBvPHMEWrmrxKu0Lb/BVTjWFfOYJvWYJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0+aut1D96TWNp04K7AmICM6qsbEy4TJi5MLJA4hu8o8+3FkHJAA2tpIKJk7iFGqQcitSlXOgFuzZbj8YnJfW8kg+BdEKCwoVlkbJi7htHfKPa0Gplv/+yTwGq6v2qWuqXgjHWg1TbkICBjE7vZ3CZTkihFOjV2dxyu48MEzGm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=kC9zuf9q; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="kC9zuf9q"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712071772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ugv3pfOJf6skuDXKNJGROSiznNnrwTfCi1Rimn1xVI0=;
	b=kC9zuf9qfPxxVBuy9Ke7sGYsRlqz/x6PVeXi2x2W3xzPESfQsnF8eP3558/aplXWKu8QSy
	QezeAWhjf7muRzNiMSVuPX2LUprr0L4LM1DmBNWcM9xHCKnMk4H9wfyjVg7vweKJC8gT/j
	qVdD/vYr9ULqeoUBKG2FYVBWkwg4A1YXp1dcJRn5+4roiwT8C29rtVkb6gO78CYngXhCr4
	RufdOd9MQM59lOuGeRsR604yiby7KrM8UIMn/UU+nluLErNG+JlFduYzESlTKUsrBrpxzs
	1VAYITj59J0hxZcIhxmxswdSE4E9yGgGg109q74RySADGShZ2fpMloSGpWC1yg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/6] libsepol: validate access vector permissions
Date: Tue,  2 Apr 2024 17:29:22 +0200
Message-ID: <20240402152925.99781-3-cgoettsche@seltendoof.de>
In-Reply-To: <20240402152925.99781-1-cgoettsche@seltendoof.de>
References: <20240402152925.99781-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Since commit c205b924e280 ("libsepol: Fix buffer overflow when using
sepol_av_to_string()") writing an access vector with no valid permission
results in an error instead of an empty string being written.

Validate that at least one permission of an access vector is valid.
There might be invalid bits set, e.g. by previous versions of
checkpolicy setting all bits for the wildcard (*) permission.

Reported-by: oss-fuzz (issue 67730)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 62 ++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index e987d8da..c4f8c300 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -876,6 +876,49 @@ static int validate_xperms(const avtab_extended_perms_t *xperms)
 bad:
 	return -1;
 }
+
+static int perm_match(__attribute__ ((unused)) hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	const uint32_t *v = data;
+	const perm_datum_t *perdatum = datum;
+
+	return *v == perdatum->s.value;
+}
+
+static int validate_access_vector(sepol_handle_t *handle, const policydb_t *p, sepol_security_class_t tclass,
+				  sepol_access_vector_t av)
+{
+	const class_datum_t *cladatum = p->class_val_to_struct[tclass - 1];
+	uint32_t i;
+
+	/*
+	 * Check that at least one permission bit is valid.
+	 * Older compilers might set invalid bits for the wildcard permission.
+	 */
+	for (i = 0; i < cladatum->permissions.nprim; i++) {
+		if (av & (UINT32_C(1) << i)) {
+			uint32_t v = i + 1;
+			int rc;
+
+			rc = hashtab_map(cladatum->permissions.table, perm_match, &v);
+			if (rc == 1)
+				goto good;
+
+			if (cladatum->comdatum) {
+				rc = hashtab_map(cladatum->comdatum->permissions.table, perm_match, &v);
+				if (rc == 1)
+					goto good;
+			}
+		}
+	}
+
+	ERR(handle, "Invalid access vector");
+	return -1;
+
+good:
+	return 0;
+}
+
 static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *args)
 {
 	map_arg_t *margs = args;
@@ -883,6 +926,16 @@ static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *
 	if (validate_avtab_key(k, 0, margs->policy, margs->flavors))
 		return -1;
 
+	if (k->specified & AVTAB_AV) {
+		uint32_t data = d->data;
+
+		if ((0xFFF & k->specified) == AVTAB_AUDITDENY)
+			data = ~data;
+
+		if (validate_access_vector(margs->handle, margs->policy, k->target_class, data))
+			return -1;
+	}
+
 	if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, margs->policy, margs->flavors))
 		return -1;
 
@@ -915,6 +968,15 @@ static int validate_cond_av_list(sepol_handle_t *handle, const cond_av_list_t *c
 
 			if (validate_avtab_key(key, 1, p, flavors))
 				goto bad;
+			if (key->specified & AVTAB_AV) {
+				uint32_t data = datum->data;
+
+				if ((0xFFF & key->specified) == AVTAB_AUDITDENY)
+					data = ~data;
+
+				if (validate_access_vector(handle, p, key->target_class, data))
+					goto bad;
+			}
 			if ((key->specified & AVTAB_TYPE) && validate_simpletype(datum->data, p, flavors))
 				goto bad;
 		}
-- 
2.43.0

