Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED44363C
	for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645481; cv=none; b=U5R7/AaMjjDeQ3WklyjLnhK0uuMS0M+df0dXBAfBs98pDuFV0a6Kf8oNK2gAkg08YO84+NjGZbsNPOjsp7oG16JXrxu+CiWLIbj5qcxWjrvKmQ7hQ3OCyKi/SfHaIOzknQxy5rXfOpLu4uPBd2PwCTeFMEUooW3gyV1OrSBUEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645481; c=relaxed/simple;
	bh=zGbWv7Kt9WIKf9r9xdJAESjVnz3VWU3vZE70L7Kg74E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tazeni4czseeVomnvzenhUXV9fVS9FdH1hJCBfAANhWMRsoSXML4nzxtSyDydkvB/TwC0bgZscpRlUMiiEIzocRN4cKYaWtqmUAJyThwIJrfIYmg6CRZmjQJakMZPuzKo0sz4eEvRDznhmVyJMWynD7th2R3wBYJnCw/cJ6/IlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkYhTexh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkYhTexh"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b43e6b9c82so92419327b3.0
        for <selinux@vger.kernel.org>; Sun, 25 Aug 2024 21:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724645479; x=1725250279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvQ8hKKXc0V7XmFasBTEZ+kw0DaF7eIBRfB0aAkMxUk=;
        b=rkYhTexhw+vSVyg/VEAuBQhMOb/J5TlMjn/hAr1Eb0RwOG2UilNMWB44a3qnK/WzMm
         VMU8FUs+FmqfCafCZvmYW8vxYvxeyu2ZYzE1xZcuI41jZUUIDayAkGXEsvazjzfVNY1x
         u4WMRpWOk2hrnCienChGtyK+1vTTTMRaFAj5TcgrEZDDaa06eZ11IpGnnNrwAgVtOaOJ
         6ojgBFbs0fUUqYuRQHlF950NYrH7kgbe7YUsBT0JRn3hMHW4C6kTLzkOcJq4rpCaJzb1
         hh5IIMQyiRiS7/CNAlqbruAhGamS+mXYz0C55b2YaZgz+MMTDda3hpRzO9GVLTi+d8MC
         J7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724645479; x=1725250279;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvQ8hKKXc0V7XmFasBTEZ+kw0DaF7eIBRfB0aAkMxUk=;
        b=ko5tCRa8dlKfQohXGVGeg/0CXVH51OMBlhS++0p5Y+k89eaIxWJqrmQ4IAbjj9Qt7K
         0BOcY52Ov0mRMaQeFyZNIJc1yIB9nYncZ7o4huJLe/3w/HSTKI8UotpXpFllfQbbuac9
         lOvpq9zsHrQD/3yFBas3wpJtvn1iPmG7xiwQEpFklKCXUGm01YXXz9q1fy/sDUizw+qS
         gyWeDDm0WxHIRvvbB7wHZML8TaXsN5KyUc2XuHmYGKa3bGcfmm1RIhOvQCFRvgqjYEHL
         VjkvYvC21xeN4CAim82lbils+HOx5eTfCu1BRQU4Se7M2m++Qc0ENNxZHj66w8AqdHPF
         ufZg==
X-Forwarded-Encrypted: i=1; AJvYcCWTKpquhOZcGrrLWgcCvaoI8NPzMjzJD4yuC8n3J8mtaXuB8+uhlpHbtwfKsk1CD3m6HY7tvKW8@vger.kernel.org
X-Gm-Message-State: AOJu0YyUTVFlZ1yWDWoTlj2H2aTi8cG3fcKl/4EnLtl+UG7nSbHKCbnT
	H25os8mGdxu1HDwW/jddGtnAMpdNbYjRguD9r1j9K5x54NavOxtan5IMivmdp9lZOYX8lXW+UA=
	=
X-Google-Smtp-Source: AGHT+IFXgNZKFCrMqHrLbCJCu04o5e8jFfwDIpwy9A2PaTX/HqRVNRaevRL74zyzVLrdRpbhqfjR5U6J/g==
X-Received: from tweek-syd.c.googlers.com ([fda3:e722:ac3:cc00:b7:3870:c0a8:26])
 (user=tweek job=sendgmr) by 2002:a05:690c:ed3:b0:68d:52a1:bf4 with SMTP id
 00721157ae682-6c62450e4bamr1581707b3.2.1724645478820; Sun, 25 Aug 2024
 21:11:18 -0700 (PDT)
Date: Mon, 26 Aug 2024 14:10:44 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826041044.1753994-1-tweek@google.com>
Subject: [PATCH] libselinux: rename hashtab functions
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: paul@paul-moore.com
Cc: jeffv@google.com, selinux@vger.kernel.org, wanghuizhao1@huawei.com, 
	jwcart2@gmail.com, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In commit d95bc8b75539 ("libselinux: migrating hashtab from
policycoreutils") and commit 4a420508a98c ("libselinux: adapting hashtab
to libselinux"), the hashtab implementation was copied to libselinux.
Since the same functions exist in libsepol (e.g., hashtab_create,
hashtab_destroy, etc), a compilation error is raised when both libraries
are included statically.

Prefix the libselinux internal implementation with "selinux_".

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libselinux/src/hashtab.c    | 16 ++++++++--------
 libselinux/src/hashtab.h    | 16 ++++++++--------
 libselinux/src/label_file.c | 10 +++++-----
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/libselinux/src/hashtab.c b/libselinux/src/hashtab.c
index 7452613b..0c6641ed 100644
--- a/libselinux/src/hashtab.c
+++ b/libselinux/src/hashtab.c
@@ -11,7 +11,7 @@
 #include <string.h>
 #include "hashtab.h"
=20
-hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
+hashtab_t selinux_hashtab_create(unsigned int (*hash_value) (hashtab_t h,
 						     const_hashtab_key_t key),
 			 int (*keycmp) (hashtab_t h,
 					const_hashtab_key_t key1,
@@ -42,7 +42,7 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (hash=
tab_t h,
 	return p;
 }
=20
-int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
+int selinux_hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t=
 datum)
 {
 	unsigned int hvalue;
 	hashtab_ptr_t prev, cur, newnode;
@@ -79,7 +79,7 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key, hashta=
b_datum_t datum)
 	return HASHTAB_SUCCESS;
 }
=20
-int hashtab_remove(hashtab_t h, hashtab_key_t key,
+int selinux_hashtab_remove(hashtab_t h, hashtab_key_t key,
 		   void (*destroy) (hashtab_key_t k,
 				    hashtab_datum_t d, void *args), void *args)
 {
@@ -112,7 +112,7 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
 	return HASHTAB_SUCCESS;
 }
=20
-hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
+hashtab_datum_t selinux_hashtab_search(hashtab_t h, const_hashtab_key_t ke=
y)
 {
=20
 	unsigned int hvalue;
@@ -132,7 +132,7 @@ hashtab_datum_t hashtab_search(hashtab_t h, const_hasht=
ab_key_t key)
 	return cur->datum;
 }
=20
-void hashtab_destroy(hashtab_t h)
+void selinux_hashtab_destroy(hashtab_t h)
 {
 	unsigned int i;
 	hashtab_ptr_t cur, temp;
@@ -156,7 +156,7 @@ void hashtab_destroy(hashtab_t h)
 	free(h);
 }
=20
-void hashtab_destroy_key(hashtab_t h,
+void selinux_hashtab_destroy_key(hashtab_t h,
 		int (*destroy_key) (hashtab_key_t k))
 {
 	unsigned int i;
@@ -182,7 +182,7 @@ void hashtab_destroy_key(hashtab_t h,
 	free(h);
 }
=20
-int hashtab_map(hashtab_t h,
+int selinux_hashtab_map(hashtab_t h,
 		int (*apply) (hashtab_key_t k,
 			      hashtab_datum_t d, void *args), void *args)
 {
@@ -205,7 +205,7 @@ int hashtab_map(hashtab_t h,
 	return HASHTAB_SUCCESS;
 }
=20
-void hashtab_hash_eval(hashtab_t h, char *tag)
+void selinux_hashtab_hash_eval(hashtab_t h, char *tag)
 {
 	unsigned int i;
 	int chain_len, slots_used, max_chain_len;
diff --git a/libselinux/src/hashtab.h b/libselinux/src/hashtab.h
index f10fc0af..6fbf5fb4 100644
--- a/libselinux/src/hashtab.h
+++ b/libselinux/src/hashtab.h
@@ -52,7 +52,7 @@ typedef hashtab_val_t *hashtab_t;
    Returns NULL if insufficient space is available or
    the new hash table otherwise.
  */
-extern hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
+extern hashtab_t selinux_hashtab_create(unsigned int (*hash_value) (hashta=
b_t h,
 							    const_hashtab_key_t
 							    key),
 				int (*keycmp) (hashtab_t h,
@@ -66,7 +66,7 @@ extern hashtab_t hashtab_create(unsigned int (*hash_value=
) (hashtab_t h,
    HASHTAB_PRESENT  if there is already an entry with the same key or
    HASHTAB_SUCCESS otherwise.
  */
-extern int hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_datum_t d)=
;
+extern int selinux_hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_da=
tum_t d);
=20
 /*
    Removes the entry with the specified key from the hash table.
@@ -76,7 +76,7 @@ extern int hashtab_insert(hashtab_t h, hashtab_key_t k, h=
ashtab_datum_t d);
    Returns HASHTAB_MISSING if no entry has the specified key or
    HASHTAB_SUCCESS otherwise.
  */
-extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
+extern int selinux_hashtab_remove(hashtab_t h, hashtab_key_t k,
 			  void (*destroy) (hashtab_key_t k,
 					   hashtab_datum_t d,
 					   void *args), void *args);
@@ -87,13 +87,13 @@ extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
    Returns NULL if no entry has the specified key or
    the datum of the entry otherwise.
  */
-extern hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t k);
+extern hashtab_datum_t selinux_hashtab_search(hashtab_t h, const_hashtab_k=
ey_t k);
=20
 /*
    Destroys the specified hash table.
  */
-extern void hashtab_destroy(hashtab_t h);
-extern void hashtab_destroy_key(hashtab_t h,
+extern void selinux_hashtab_destroy(hashtab_t h);
+extern void selinux_hashtab_destroy_key(hashtab_t h,
 			int (*destroy_key) (hashtab_key_t k));
=20
 /*
@@ -107,11 +107,11 @@ extern void hashtab_destroy_key(hashtab_t h,
    iterating through the hash table and will propagate the error
    return to its caller.
  */
-extern int hashtab_map(hashtab_t h,
+extern int selinux_hashtab_map(hashtab_t h,
 		       int (*apply) (hashtab_key_t k,
 				     hashtab_datum_t d,
 				     void *args), void *args);
=20
-extern void hashtab_hash_eval(hashtab_t h, char *tag);
+extern void selinux_hashtab_hash_eval(hashtab_t h, char *tag);
=20
 #endif
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 59c9f2ef..2fad0c93 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -111,7 +111,7 @@ static int nodups_specs(struct saved_data *data, const =
char *path)
 	struct chkdups_key *new =3D NULL;
 	unsigned int hashtab_len =3D (data->nspec / SHRINK_MULTIS) ? data->nspec =
/ SHRINK_MULTIS : 1;
=20
-	hashtab_t hash_table =3D hashtab_create(symhash, symcmp, hashtab_len);
+	hashtab_t hash_table =3D selinux_hashtab_create(symhash, symcmp, hashtab_=
len);
 	if (!hash_table) {
 		rc =3D -1;
 		COMPAT_LOG(SELINUX_ERROR, "%s: hashtab create failed.\n", path);
@@ -121,18 +121,18 @@ static int nodups_specs(struct saved_data *data, cons=
t char *path)
 		new =3D (struct chkdups_key *)malloc(sizeof(struct chkdups_key));
 		if (!new) {
 			rc =3D -1;
-			hashtab_destroy_key(hash_table, destroy_chkdups_key);
+			selinux_hashtab_destroy_key(hash_table, destroy_chkdups_key);
 			COMPAT_LOG(SELINUX_ERROR, "%s: hashtab key create failed.\n", path);
 			return rc;
 		}
 		new->regex =3D spec_arr[ii].regex_str;
 		new->mode =3D spec_arr[ii].mode;
-		ret =3D hashtab_insert(hash_table, (hashtab_key_t)new, &spec_arr[ii]);
+		ret =3D selinux_hashtab_insert(hash_table, (hashtab_key_t)new, &spec_arr=
[ii]);
 		if (ret =3D=3D HASHTAB_SUCCESS)
 			continue;
 		if (ret =3D=3D HASHTAB_PRESENT) {
 			curr_spec =3D
-				(struct spec *)hashtab_search(hash_table, (hashtab_key_t)new);
+				(struct spec *)selinux_hashtab_search(hash_table, (hashtab_key_t)new);
 			rc =3D -1;
 			errno =3D EINVAL;
 			free(new);
@@ -161,7 +161,7 @@ static int nodups_specs(struct saved_data *data, const =
char *path)
 		}
 	}
=20
-	hashtab_destroy_key(hash_table, destroy_chkdups_key);
+	selinux_hashtab_destroy_key(hash_table, destroy_chkdups_key);
=20
 	return rc;
 }
--=20
2.46.0.295.g3b9ea8a38a-goog

