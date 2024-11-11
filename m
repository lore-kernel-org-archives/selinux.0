Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4038E1A0BCF
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334648; cv=none; b=HaeYaFZaxCQKu1QUZ+5qPAbjwAYYNGoVHoQmNBr/87dWlLSZRCk/5vc8e6CRQNyHrRkyh/zRNtxXv2AK2HIsLOEXKQdz33fmXuUTiPVynnXRhd2TDyUduhgz6NE7hIXje6IS6oLv5ywQpOqQoQf9lS1hERHr+Sp0x2MGUwMXiEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334648; c=relaxed/simple;
	bh=uXs6PMPAbUZUtboHxinHAt53lJxop8c+V8+MBZQqA2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DH+/wRUokmD+agwi1V2IXupqaQhR/JxLBJSMswneCs5aunUxAg8feQG36AXy9AAY/Ne21ReHhrHGXr+V3DmaC0Qp8CQo8fw1nunj19fDjABUFcnM/zNt3TuRf0TYZWW/slhja7ecJ/W74QfKqH1YHOe1B6YFPdlMq37MNaRmKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=IUrkMMj/; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="IUrkMMj/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334641;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrJzP/Hct2jclT3UKxsilWlBCcN1MNY9MJE0gfUnaQE=;
	b=IUrkMMj//+X9eo49bOQDcAkmIel0Hy5qatWxgf615uNiG0QuplrWCggIo0gut5OsBsYJUQ
	Rq9W70Q+DArRY0zkeSj6yY3OZ8Ew6Bu2Uw3iV8JtIxQACVr3fffCn/OOLXJfkIV2hLREoF
	asGtPe0umn+dG6FNBnch2HEGZUXN+a8OkNwcLb6ftd36l6hYogIO7PUG+FYNwqjbTVgP84
	4Xsm1GIPM2/oW12o45dG7IrtcZt3lFvLO0EnlSGe3GQiCr83+KSGZIDyO5aIurZaSrTOeJ
	NoACoRzASekIklNIHHdp4EM0jMHYvtCkY5ctbCDaFA4gttaVASbbx1XFpr/0YA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 45/47] libsemanage: skip sort of empty arrays
Date: Mon, 11 Nov 2024 15:17:04 +0100
Message-ID: <20241111141706.38039-45-cgoettsche@seltendoof.de>
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

UBSAN triggers if the first argument of qsort(3) is NULL, even if the
associated passed size is 0 and thus no actual dereference will happen.

Sort only arrays with at least two elements.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/database_join.c     | 4 ++--
 libsemanage/src/ibendports_local.c  | 3 ++-
 libsemanage/src/ibpkeys_local.c     | 3 ++-
 libsemanage/src/policy_components.c | 2 +-
 libsemanage/src/ports_local.c       | 4 +++-
 libsemanage/src/utilities.c         | 2 +-
 6 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/libsemanage/src/database_join.c b/libsemanage/src/database_join.c
index abe6c43c..afb67618 100644
--- a/libsemanage/src/database_join.c
+++ b/libsemanage/src/database_join.c
@@ -77,10 +77,10 @@ static int dbase_join_cache(semanage_handle_t * handle, dbase_join_t * dbase)
 		goto err;
 
 	/* Sort for quicker merge later */
-	if (rcount1 > 0) {
+	if (rcount1 > 1) {
 		qsort(records1, rcount1, sizeof(record1_t *), rtable1->compare2_qsort);
 	}
-	if (rcount2 > 0) {
+	if (rcount2 > 1) {
 		qsort(records2, rcount2, sizeof(record2_t *), rtable2->compare2_qsort);
 	}
 
diff --git a/libsemanage/src/ibendports_local.c b/libsemanage/src/ibendports_local.c
index 0b8c14d2..acf1a37c 100644
--- a/libsemanage/src/ibendports_local.c
+++ b/libsemanage/src/ibendports_local.c
@@ -89,7 +89,8 @@ int semanage_ibendport_validate_local(semanage_handle_t *handle)
 	if (semanage_ibendport_list_local(handle, &ibendports, &nibendports) < 0)
 		goto err;
 
-	qsort(ibendports, nibendports, sizeof(semanage_ibendport_t *), semanage_ibendport_compare2_qsort);
+	if (nibendports > 1)
+		qsort(ibendports, nibendports, sizeof(semanage_ibendport_t *), semanage_ibendport_compare2_qsort);
 
 	/* Test each ibendport */
 	while (i < nibendports) {
diff --git a/libsemanage/src/ibpkeys_local.c b/libsemanage/src/ibpkeys_local.c
index 6848bd0d..eea30c2f 100644
--- a/libsemanage/src/ibpkeys_local.c
+++ b/libsemanage/src/ibpkeys_local.c
@@ -91,7 +91,8 @@ int semanage_ibpkey_validate_local(semanage_handle_t *handle)
 	if (semanage_ibpkey_list_local(handle, &ibpkeys, &nibpkeys) < 0)
 		goto err;
 
-	qsort(ibpkeys, nibpkeys, sizeof(semanage_ibpkey_t *), semanage_ibpkey_compare2_qsort);
+	if (nibpkeys > 1)
+		qsort(ibpkeys, nibpkeys, sizeof(semanage_ibpkey_t *), semanage_ibpkey_compare2_qsort);
 
 	/* Test each ibpkey for overlap */
 	while (i < nibpkeys) {
diff --git a/libsemanage/src/policy_components.c b/libsemanage/src/policy_components.c
index 6557bb18..20f743dc 100644
--- a/libsemanage/src/policy_components.c
+++ b/libsemanage/src/policy_components.c
@@ -168,7 +168,7 @@ int semanage_base_merge_components(semanage_handle_t * handle)
 			goto err;
 
 		/* Sort records on MODE_SORT */
-		if (mode & MODE_SORT) {
+		if ((mode & MODE_SORT) && nrecords > 1) {
 			qsort(records, nrecords, sizeof(record_t *), rtable->compare2_qsort);
 		}
 
diff --git a/libsemanage/src/ports_local.c b/libsemanage/src/ports_local.c
index 7d4d0768..5711bdd8 100644
--- a/libsemanage/src/ports_local.c
+++ b/libsemanage/src/ports_local.c
@@ -82,7 +82,9 @@ int semanage_port_validate_local(semanage_handle_t * handle)
 	/* List and sort the ports */
 	if (semanage_port_list_local(handle, &ports, &nports) < 0)
 		goto err;
-	qsort(ports, nports, sizeof(semanage_port_t *), semanage_port_compare2_qsort);
+
+	if (nports > 1)
+		qsort(ports, nports, sizeof(semanage_port_t *), semanage_port_compare2_qsort);
 
 	/* Test each port for overlap */
 	while (i < nports) {
diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index 9df7b9c1..70b5b677 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -167,7 +167,7 @@ int semanage_list_sort(semanage_list_t ** l)
 	size_t count = 0;
 	size_t i = 0;
 
-	if (!l)
+	if (!l || !(*l)->next)
 		return 0;
 
 	for (temp = *l; temp; temp = temp->next)
-- 
2.45.2

