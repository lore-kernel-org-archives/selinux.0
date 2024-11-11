Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6619CC1C
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334641; cv=none; b=TxDRkSV3h2I6z43Qx2zwIU+ac3R1D4bn6OW0o7jCSUHS2rsmMb6AncVaUgYoG2vqrCiNZIUPVZJR4q2Ssu6/QMGfSdqeDopUd7IUGW19ILFhGjvMBF51yJ2sFcTFeEP9jMBPYTww9XOThpUQ7dcNnNdSJ0NZlpMm0dZQ4l2JKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334641; c=relaxed/simple;
	bh=AJHWi70tHqT9PHmo9lHuWvaYxmJyv5o1s61aTz5A5i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtH+ct+p53mFJCOO2Td0xYEWaic0g/zY1io/4Zf6CjjV+VU/DZfvGvjMQnnweE76XdjtIIVFLPZD4TYbibS2bpZLDnQCq/Ru82TyooHr8XwaiglSypkyTtZWeq7eEYyhuFyypd0PkHjK1EEmbmT2546GuKHR1EvJ3iZhZzCXDKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=N2iFFyGv; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="N2iFFyGv"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334635;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVVQbQkE9pm+qY/yrXvK1e/Y1hDOMGnI8UKmO0u/dEk=;
	b=N2iFFyGv5i3YVeUYIZWAUx9UG985lZvfL4owQlttJ+0ttGYvrNrZYV+boC+UJY6UR2jJMA
	2bTE+Bf9zMgmsI+RF5hWDWjsiweUz5cw/Rz5EJgRqKGVIMUyfiT4G3JfAReLNjmxO9xOJk
	pizjQPO5S/BsPSPDJjP7KSq2tGu0Dho6X3frb0QdWgPQ5Cwo6AbcaM/pN6BfLMDCIUPJrr
	VgiCDQz1mzLMlVa0ddP5GQi9bV1X2Ls2xN7LXkoI3nar/yaGEMx6PZ2fn4gMj2AeRvosqz
	uU9fj6VP1rbw8YG2cdoBfRI2HDcKnyhRFoBWhcMkxLtTAdSiSm/9B5SNaZQzGw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 13/47] libsemanage: free resources on failed connect attempt
Date: Mon, 11 Nov 2024 15:16:32 +0100
Message-ID: <20241111141706.38039-13-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

In case connecting to the semanage database fails, free all already
allocated resources.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/database_activedb.c | 3 +++
 libsemanage/src/database_file.c     | 3 +++
 libsemanage/src/database_join.c     | 3 +++
 libsemanage/src/database_policydb.c | 2 +-
 libsemanage/src/direct_api.c        | 1 +
 libsemanage/src/handle.c            | 5 ++---
 6 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/database_activedb.c b/libsemanage/src/database_activedb.c
index fa6b6105..e0369963 100644
--- a/libsemanage/src/database_activedb.c
+++ b/libsemanage/src/database_activedb.c
@@ -139,6 +139,9 @@ int dbase_activedb_init(semanage_handle_t * handle,
 void dbase_activedb_release(dbase_activedb_t * dbase)
 {
 
+	if (!dbase)
+		return;
+
 	dbase_llist_drop_cache(&dbase->llist);
 	free(dbase);
 }
diff --git a/libsemanage/src/database_file.c b/libsemanage/src/database_file.c
index 6fe2ddf3..716f54e7 100644
--- a/libsemanage/src/database_file.c
+++ b/libsemanage/src/database_file.c
@@ -191,6 +191,9 @@ int dbase_file_init(semanage_handle_t * handle,
 void dbase_file_release(dbase_file_t * dbase)
 {
 
+	if (!dbase)
+		return;
+
 	dbase_llist_drop_cache(&dbase->llist);
 	free(dbase);
 }
diff --git a/libsemanage/src/database_join.c b/libsemanage/src/database_join.c
index 2a2008e8..bf260952 100644
--- a/libsemanage/src/database_join.c
+++ b/libsemanage/src/database_join.c
@@ -271,6 +271,9 @@ int dbase_join_init(semanage_handle_t * handle,
 void dbase_join_release(dbase_join_t * dbase)
 {
 
+	if (!dbase)
+		return;
+
 	dbase_llist_drop_cache(&dbase->llist);
 	free(dbase);
 }
diff --git a/libsemanage/src/database_policydb.c b/libsemanage/src/database_policydb.c
index 19d90de5..6e922b5e 100644
--- a/libsemanage/src/database_policydb.c
+++ b/libsemanage/src/database_policydb.c
@@ -44,7 +44,7 @@ struct dbase_policydb {
 static void dbase_policydb_drop_cache(dbase_policydb_t * dbase)
 {
 
-	if (dbase->cache_serial >= 0) {
+	if (dbase && dbase->cache_serial >= 0) {
 		sepol_policydb_free(dbase->policydb);
 		dbase->cache_serial = -1;
 		dbase->modified = 0;
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 3fa24331..83addbee 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -321,6 +321,7 @@ int semanage_direct_connect(semanage_handle_t * sh)
 
       err:
 	ERR(sh, "could not establish direct connection");
+	(void) semanage_direct_disconnect(sh);
 	return STATUS_ERR;
 }
 
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index f048f6d7..9bb84546 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -361,12 +361,11 @@ int semanage_access_check(semanage_handle_t * sh)
 
 int semanage_disconnect(semanage_handle_t * sh)
 {
-	assert(sh != NULL && sh->funcs != NULL
-	       && sh->funcs->disconnect != NULL);
+	assert(sh != NULL);
 	if (!sh->is_connected) {
 		return 0;
 	}
-	if (sh->funcs->disconnect(sh) < 0) {
+	if (sh->funcs && sh->funcs->disconnect(sh) < 0) {
 		return -1;
 	}
 	sh->is_in_transaction = 0;
-- 
2.45.2

