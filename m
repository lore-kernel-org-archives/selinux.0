Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2E13F43E
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072566; cv=none; b=Ivl2pXLpaChjwy0Fo8OYCxRUYEbDi5S/vcXMQdJly4hpG6P2RR55fWa8xeI1WQj7KzAoS1YJy7MoMc5KEV1ZgsYkPrcnfQ2QHi+v0o1nILnTVyoQhcqh6Lnsj7B8PZF7XFJeBp8UvS+sOZkTio/57aJ0nWiRIqx7/sgveyZuIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072566; c=relaxed/simple;
	bh=FrnyUQHASHU2IaNNV8cPv5LRvRPPZnV5kq3XXYd6lIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O4X9ZC9uuX3kLwc4Ys7i5BQ26rfC1Zn+nMd+mteYnmNsGFFlGo/QDfQ3vlYoXIXkLN4fppwutj4jDXj4IK7OdC5iHu8vIcmTkEc+7vK+RsvSo6Q/xgHEItDcQEzOnTIW1W1SsSjZfLUKSsjiLvGWfDlMM/8JpXkm4NRiy928uHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Ccupj2B7; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Ccupj2B7"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712072562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xtIzQVs9wFVJUg59Nza959ImI3JzkowGRvBUDffcaos=;
	b=Ccupj2B7wON2nC3WIBuAZnfR9ECjRU3D3CEIbTFiRn0sjb1NLFtmf+N8PgTYP5Ae7OB4fx
	FUzJaYGgee90zewnxBQzFw59z2sFTaQH+LBt/P6GRIdEIC9DPIrgvLJs3bt7jP47+Rat/i
	hRQoqv7lKx0GAGMaQKsLgjSBorTb/o81O0f389LRA5omPXovgvVATQ9wGOOZc77YEjnMa4
	kLHb/R3FArdyr7RjediEKdtWbGFN3yoB/hSIhj9CFEmJRj3AulFmDHUcGCmuqDT3BhyUm/
	SPqnGkNImONZNNm6qU0e/L2yfdMHTAu6vJAhxUbRLCBZCfGMs7nQDY7evtqUNQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol: constify function pointer arrays
Date: Tue,  2 Apr 2024 17:42:38 +0200
Message-ID: <20240402154238.104378-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The function pointer arrays are never changed, declare them const.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 0c23a7a2..49f9e8af 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1126,7 +1126,7 @@ static int cat_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	return 0;
 }
 
-static int (*index_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
+static int (*const index_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
 				void *datap) = {
 common_index, class_index, role_index, type_index, user_index,
 	    cond_index_bool, sens_index, cat_index,};
@@ -1409,7 +1409,7 @@ static int cat_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 	return 0;
 }
 
-static int (*destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
+static int (*const destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
 				  void *datap) = {
 common_destroy, class_destroy, role_destroy, type_destroy, user_destroy,
 	    cond_destroy_bool, sens_destroy, cat_destroy,};
@@ -3410,7 +3410,7 @@ static int cat_read(policydb_t * p
 	return -1;
 }
 
-static int (*read_f[SYM_NUM]) (policydb_t * p, hashtab_t h,
+static int (*const read_f[SYM_NUM]) (policydb_t * p, hashtab_t h,
 			       struct policy_file * fp) = {
 common_read, class_read, role_read, type_read, user_read,
 	    cond_read_bool, sens_read, cat_read,};
-- 
2.43.0

