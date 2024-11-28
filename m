Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E225761
	for <selinux@vger.kernel.org>; Thu, 28 Nov 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808446; cv=none; b=gXHx8DIPnCxsHtRbl00xyPjsu7aIUBSf0bDO3D+MlmlShNt7nUaNAJTH1rLF084UZtFGa28pis3TcwTJEEGo30l5ZJUu6t7R8CbUHmbahGCYtrCtXd4Z0bhGYLNB6T+HM2WnwMXef78aTi6V4mMWWxAvPScfGBxHEftM1Yd0RlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808446; c=relaxed/simple;
	bh=lC88kg1+xJUL8xXwIg4eR3dZEPH09pKxIIGdoe3WYic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VjRYvhA2cedrSVadHf8lEhMxE6f4R6CbwLcDcCrFTCWOOikYCBEewafxSkQO66kFA5pSfLXjKiWY/iIKPd6ZIk98oIBlXUFaU5fE0APKREHDv+34laHCtetl0aMIZTEMNsus6SL5K+EDylvj3NX/IbCGf4GkWG6LE+9HHmXzhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=OO8RW6r/; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="OO8RW6r/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732808441;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mJM6UWBEXtDrEtvyrvgY4By1wZRScmBNJYoNUAGOarU=;
	b=OO8RW6r/NP3lTZkDtQgfYtUyjiarOB1o4LE4XmjWekV3fIi23hQN6jUqlDpijCjO5Codqs
	k1tJpozUPSqpYWORyiIDNN1qLAiSHuzduQC61lWtz1kDQGjEqzRjNta2AhUcpFWcVDGfxn
	vkqG4dx8RTEv5HqBSO9HGHsP57lH0FwD4I22AGbQJM+EFUohiOWjvWlXw3vASnFev/c+h0
	Vdpu4DDLdfkEYbl1sWNHiels8qPUQlwLk5jRctC9Ay6GITezwZOEJaPCK8jT8lU7JNl9cB
	C0TKR7Ld7VUG7V0h5xYmn8MAjgZdidGQiNZtnABKWt8JNthp3mo1xxe6tMOJTQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol: avoid unnecessary memset(3) calls in hashtab
Date: Thu, 28 Nov 2024 16:40:34 +0100
Message-ID: <20241128154034.23298-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Use struct initialization with designators to skip unnecessary memset(3)
calls.  Since libsepol is not a security boundary uninitialized padding
is not a concern.

Also drop the dead assignment of a region to be free'd in the next line.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/hashtab.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index 399582b1..4c658588 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -48,12 +48,14 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
 	if (p == NULL)
 		return p;
 
-	memset(p, 0, sizeof(hashtab_val_t));
-	p->size = size;
-	p->nel = 0;
-	p->hash_value = hash_value;
-	p->keycmp = keycmp;
-	p->htable = (hashtab_ptr_t *) calloc(size, sizeof(hashtab_ptr_t));
+	*p = (hashtab_val_t) {
+		.size = size,
+		.nel = 0,
+		.hash_value = hash_value,
+		.keycmp = keycmp,
+		.htable = (hashtab_ptr_t *) calloc(size, sizeof(hashtab_ptr_t)),
+	};
+
 	if (p->htable == NULL) {
 		free(p);
 		return NULL;
@@ -127,9 +129,10 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
 	newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
 	if (newnode == NULL)
 		return SEPOL_ENOMEM;
-	memset(newnode, 0, sizeof(struct hashtab_node));
-	newnode->key = key;
-	newnode->datum = datum;
+	*newnode = (hashtab_node_t) {
+		.key = key,
+		.datum = datum,
+	};
 	if (prev) {
 		newnode->next = prev->next;
 		prev->next = newnode;
@@ -223,8 +226,6 @@ void hashtab_destroy(hashtab_t h)
 	}
 
 	free(h->htable);
-	h->htable = NULL;
-
 	free(h);
 }
 
-- 
2.45.2

