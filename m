Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975000;
	b=WjwqLkKXPolII6EuNZxL8QD0NuDrSnhxEKFxytThdvPakeDlKZfwcDLsMHhEICbQ8DEa
	 hLC01k1V5vizvUNrjSP4OcRJCbn6equao61GZOIeNK8YN+efSVqdRiDf+5ug+K9OR3UOm
	 fu2VhduXbRH4a5ncffxGwVkUhI3dSW4qZGc4Fz475VigoZiM59A4cL2dLfWhexRGvnEdp
	 18RUabLResayYEptKdHkzIa4S83y035qF7dzRywNFbinqwNeNZKewm5wr6L6eVuck7PFl
	 AJsHA8JHSezUwnEAzggrFroFeMf/Vuzl2CgDMRFMCsDwXS82oV4uftrs9pNFp3cyp0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975000;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yMGx5yC026SCBhWakeoqd0MuYbqlBrS3DvU5Utk5Djo=;
	b=cx/uImyKuCosR5KD3v+LKswp4fr/4VPPfEfDkMAWi3G+NNTjg4Z7C6qPogsB4jwO0eAu
	 XV9gcQJpVuDRgJBiKAeN8gSFzJEjp/MOj1g0aNwTM9AHyxxGaq5hHRmnEn+hePWvqZ2Ar
	 x5mrxnK7WERkplVlKDRY8iCQkpXx4L3CJwWqspToOeDJD7Rh5bsKDPfO70fAZeRHUJz71
	 Vr1oVZ+TWc7IABKZSOeMXjFnWPXlzz5+ctChnt0edswbV1gNLyUpJ6/YuQZQuqviRT5YS
	 gnhuTHi09OIRyfJVAqlmTeuMa1nOv0WD0f/+rg3f3dJ9TAtSAfY4w3tAJA2eGadECTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=NvFo0nA3;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53880606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 14:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53880606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=NvFo0nA3
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793974997;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yMGx5yC026SCBhWakeoqd0MuYbqlBrS3DvU5Utk5Djo=;
	b=NvFo0nA3o49QpaR7QOQeLBjCK5kr3yAlIt9WseFtnfrH2LVjsM4zV2HubRbHHtRuMvIhEk
	99CX0Wvz7nwZ82M+lTi8F2qvbqjMkfehTY3FJr53+i17NPULfLkGFLiZH/EMDLD5lwjIvf
	8wlDSCod0b5w1dzy38WLK5sDEaHH1dV3PhXikCE5OgifnZlHD9teJuvPe+5dG/iypqqATU
	whN5u5iis55MPLii/SqIJeX7OIvUsnzPENZmDIU/J5qZKmQRJhjHYAxYMZL1qCABuuMKXg
	PZ2diRQDnsRYzO5RFYlZT6DpxBGcfaZGWu8MFiieweNgSB0D2Yw0z+KE3l94MA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol: avoid quadratic removal of redundant conditional rules
Date: Fri,  6 Nov 2026 15:23:02 +0100
Message-ID: <20261106142302.512540-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

optimize_cond_avtab() collects the redundant conditional rules in a list
and then, for every entry of the conditional avtab, scans that list
linearly to check whether the entry is to be deleted. The cost is the
product of both sizes; on a modular Reference Policy build this single
loop accounted for about 12% of the runtime of `semodule -B`.

Sort the addresses of the nodes to delete once and look up each avtab
entry with bsearch(3). Addresses are stored as uintptr_t, so no pointer
to a freed node is read after its deletion. Should the allocation fail,
fall back to the previous linear scan, so the function stays infallible
and policydb_optimize() keeps its behavior.

Also free the list entries left over after the scan, which were leaked
before if a collected node was not found in the table.

The resulting policy is unchanged.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/optimize.c | 75 +++++++++++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 14 deletions(-)

diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 9e925f36..324ad674 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -379,13 +379,39 @@ static void optimize_cond_av_list(cond_av_list_t **cond, cond_av_list_t **del,
 	}
 }
 
+static int uintptr_cmp(const void *a, const void *b)
+{
+	uintptr_t pa = *(const uintptr_t *)a;
+	uintptr_t pb = *(const uintptr_t *)b;
+
+	return (pa > pb) - (pa < pb);
+}
+
+/* remove the entry for node from the list, returning whether it was found */
+static int cond_av_list_remove(cond_av_list_t **list,
+			       const struct avtab_node *node)
+{
+	for (; *list; list = &(*list)->next) {
+		if ((*list)->node == node) {
+			cond_av_list_t *tmp = *list;
+
+			*list = tmp->next;
+			free(tmp);
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static void optimize_cond_avtab(policydb_t *p, const struct type_vec *type_map)
 {
 	avtab_t *tab = &p->te_cond_avtab;
 	unsigned int i;
 	avtab_ptr_t *cur;
 	cond_node_t **cond;
-	cond_av_list_t **avcond, *del = NULL;
+	cond_av_list_t *item, *del = NULL;
+	uintptr_t *del_nodes;
+	size_t j, ndel = 0;
 
 	/* First go through all conditionals and collect redundant rules. */
 	cond = &p->cond_list;
@@ -409,6 +435,26 @@ static void optimize_cond_avtab(policydb_t *p, const struct type_vec *type_map)
 	if (!del)
 		return;
 
+	/*
+	 * Sort the addresses of the nodes to delete, so membership of a
+	 * cond_avtab entry can be looked up in logarithmic time; a linear scan
+	 * of 'del' per entry is quadratic and dominates on large policies.
+	 * Fall back to that scan if the allocation fails.
+	 */
+	for (item = del; item; item = item->next)
+		ndel++;
+
+	del_nodes = calloc(ndel, sizeof(*del_nodes));
+	if (del_nodes) {
+		for (j = 0, item = del; item; item = item->next)
+			del_nodes[j++] = (uintptr_t)item->node;
+
+		cond_av_list_destroy(del);
+		del = NULL;
+
+		qsort(del_nodes, ndel, sizeof(*del_nodes), uintptr_cmp);
+	}
+
 	/*
 	 * Now go through the whole cond_avtab and remove all rules that are
 	 * found in the 'del' list.
@@ -416,20 +462,18 @@ static void optimize_cond_avtab(policydb_t *p, const struct type_vec *type_map)
 	for (i = 0; i < tab->nslot; i++) {
 		cur = &tab->htable[i];
 		while (*cur) {
-			int redundant = 0;
-			avcond = &del;
-			while (*avcond) {
-				if ((*avcond)->node == *cur) {
-					cond_av_list_t *cond_tmp = *avcond;
-
-					*avcond = cond_tmp->next;
-					free(cond_tmp);
-					redundant = 1;
-					break;
-				} else {
-					avcond = &(*avcond)->next;
-				}
+			int redundant;
+
+			if (del_nodes) {
+				uintptr_t key = (uintptr_t)*cur;
+
+				redundant = bsearch(&key, del_nodes, ndel,
+						    sizeof(*del_nodes),
+						    uintptr_cmp) != NULL;
+			} else {
+				redundant = cond_av_list_remove(&del, *cur);
 			}
+
 			if (redundant) {
 				avtab_ptr_t tmp = *cur;
 
@@ -444,6 +488,9 @@ static void optimize_cond_avtab(policydb_t *p, const struct type_vec *type_map)
 			}
 		}
 	}
+
+	free(del_nodes);
+	cond_av_list_destroy(del);
 }
 
 /*
-- 
2.55.0

