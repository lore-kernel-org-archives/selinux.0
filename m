Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA244AB92;
	Fri, 31 Jul 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519851; cv=none; b=mSRHNBLA9QnHrSiazbaIl/MQ0X5mw3q6J9QVpVluqDgGX5x2ACzQQ1Ep4/Cj7z7/eDbUwYcQXB+SflmSxeT7WiQPxUPZMRRdCnmeKfsgHIkwqZYv3FRBAksBz4blAOyAU41CHE839yhaZiYJAJ1H8HHN2VRDuZyu34lu6M5/ynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519851; c=relaxed/simple;
	bh=jdHeH42NJK+sRNHUhRFHxkP9qChVfte4gNDC1Rcw0i4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDx5w/MsAeY/NEynSdXvKWZJG6TOFc/jiMVxIUCxpoSxF4kSnaN5n+TbdVYzFeuwJfPBtX4YdWmrSA3JS8WIeS+lubb9gE0cIL3Blhanv2COKBmrkuDmgQviCzrY3+epJFutaA0YqdnF9mk5Q5bxbi1mFaBhLx2FPJ/a5O5RoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdTcBwGC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdTcBwGC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D6FCC2BCFB;
	Fri, 31 Jul 2026 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785519850;
	bh=jdHeH42NJK+sRNHUhRFHxkP9qChVfte4gNDC1Rcw0i4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BdTcBwGClXbwYxtNZmkECny1/nRGdATKk/AMMjvKGzQW/9ANHw1mqjpz71Y0fNpVh
	 QzT26XXQ9yA6nbzTzNotDse31KuULwjyPB6+N8o8IiYoFi5Xi0QRtgzfnF+GWI/saH
	 CJiv1CqGn9O8WgkAufRkWVTHNIFqiJHEMJhx6QkOUchpfArwlF8ubY7Y6jGMpIOGJI
	 kwGj3dRkTRE1jzSqHFBpX7VavT8wap00XF8ubYTRJqJrCeZr5+PMXlqjUWNW7Z+5i0
	 uCYtI1B5/FViYCnusTOFa6S8xeU52lWqtDSKDR8jQq4vtRpjv3ZtFvha6QHm29Xdi4
	 ZIEKBErQI711A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009F5C55175;
	Fri, 31 Jul 2026 17:44:10 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 31 Jul 2026 12:44:11 -0500
Subject: [PATCH 3/4] selinux: reject an unclaimed class value in
 security_get_classes()
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-b4-disp-d32e997b-v1-3-0341d038ee47@proton.me>
References: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me>
In-Reply-To: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me>
To: Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
 Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, 
 =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785519848; l=2212;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=146rmnAfLEvFW4uw+zlgvifpJzRkQBhtNeevcrvrVxY=;
 b=75DlDjNX2pjUbExZ1Kf+vXP0AyfZVSOzdMKlZr7wbTah/wLkZaJIMQ5BcA7uc31mfFZ5/h4zP
 W17KLxQSHlHCGW3Cb3d6NgzU0UimsXtm8tWZQH6NZ8rdP9d4vfS44UI
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

security_get_classes() sizes an array by p_classes.nprim and fills it at
value - 1, so a class value the policy never defines leaves a NULL.
sel_make_classes() passes every entry to sel_make_dir(), reaching the same
d_alloc_name() dereference as the permission array. The class symbol table
is allowed to be sparse (policydb_class_isvalid() exists to absorb that),
but this getter builds its own array straight from the hash table and has
no such predicate.

Fail the lookup when a value went unclaimed instead of handing out the
NULL. Conforming policies define every class they declare and are
unaffected.

Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 security/selinux/ss/services.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 90e81186cb2e..7afce975436e 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3304,6 +3304,7 @@ int security_get_classes(struct selinux_policy *policy,
 			 char ***classes, u32 *nclasses)
 {
 	struct policydb *policydb;
+	u32 i;
 	int rc;
 
 	policydb = &policy->policydb;
@@ -3316,16 +3317,29 @@ int security_get_classes(struct selinux_policy *policy,
 
 	rc = hashtab_map(&policydb->p_classes.table, get_classes_callback,
 			 *classes);
-	if (rc) {
-		u32 i;
+	if (rc)
+		goto err;
 
-		for (i = 0; i < *nclasses; i++)
-			kfree((*classes)[i]);
-		kfree(*classes);
+	/*
+	 * The class symtab may be sparse, which policydb_class_isvalid() exists
+	 * to absorb; the callback fills this array by value, so an unclaimed
+	 * one leaves a NULL that sel_make_classes() hands to sel_make_dir().
+	 */
+	for (i = 0; i < *nclasses; i++) {
+		if (!(*classes)[i]) {
+			rc = -EINVAL;
+			goto err;
+		}
 	}
 
 out:
 	return rc;
+
+err:
+	for (i = 0; i < *nclasses; i++)
+		kfree((*classes)[i]);
+	kfree(*classes);
+	return rc;
 }
 
 static int get_permissions_callback(void *k, void *d, void *args)

-- 
2.55.0


