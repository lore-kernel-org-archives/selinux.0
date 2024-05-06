Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEA3745D9
	for <selinux@vger.kernel.org>; Mon,  6 May 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016687; cv=none; b=nWP6onWKDzEXi2ltl0T7oAcmr55K+iDdxxG/SgqDIiBykV0LU94Owsprd+wK8cVStqeWYphvlZxxFpRSDzAzF/t15D2HmLR8zzAbKfKe3dT1EB8y2Sb8OQ8C1sJm7MPllh1VBYsQXZnGj9x3/I2o+ECw4Ak8BXtpDMj0V5Vp+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016687; c=relaxed/simple;
	bh=EcCnGZIZl6Xl3/AkK5GAj+l6qPF2tYUunBXDGc7FRJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oy5Fq+S7Z/PB2qRE1bHJ7J9gZsHEFeRUOydDFP7C5M0KxiwO7Bea1kyYHRr/aI1T5X3Sf7d0Fj2BzMgSBeeeXVPIMbLljB8W71ROQTCb01FmfNOaJQbfK4wkpe1OhXQAq7Z9yBekb8+HPutWtydvwBcxjGSV0P49/7JXqidfyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=gsYde0UJ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="gsYde0UJ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1715016675;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03P2U+ZJd6Ai4thqTWC+JJvhTL+i9PpJjo9ZtC6iNmM=;
	b=gsYde0UJZP6ypMl5zy9Y9lL82G731fquzTjPIfCgIiMXI9UCRfmC/sy6j3IvlS3OYPeHV8
	zkdsfjKCk7LvHeD7jFAb2jd+g9inVHt0vWr1yEQhVustJVAvG8MQ/SVuC6iG8kL3bqgg4k
	6i+fGl1PNYlgRqXfE0EkE5Nu8dcuxBrAtRY8QYehPWL54ty85jhA+1t2oxyPRtkPArYDnP
	ZUeEjbS+Ey4BcZ8PTxPPlklJ0oArtvsUsyc/3orzzG/X0iSgZXthbNIWhZGhnc3kMBN8rM
	U91AOxiyPajmt79Pl4BHKWOqVXwfTdZffqCJDlv9Y9E7R5CmAADpi8G5r2WV4g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/4] libsepol: only exempt gaps checking for kernel policies
Date: Mon,  6 May 2024 19:31:08 +0200
Message-ID: <20240506173110.220702-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240506173110.220702-1-cgoettsche@seltendoof.de>
References: <20240506173110.220702-1-cgoettsche@seltendoof.de>
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

Kernel policy versions 20 to 23 store attributes only in type_attr_map
and reference gaps in the type arrays.  Thus they are exempted from gaps
checks.

Only exempt kernel policies, not base and module ones.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index be3ebe5f..04135d84 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -63,7 +63,7 @@ static int validate_array_init(const policydb_t *p, validate_t flavors[])
 		goto bad;
 	if (validate_init(&flavors[SYM_ROLES], p->p_role_val_to_name, p->p_roles.nprim))
 		goto bad;
-	if (p->policyvers < POLICYDB_VERSION_AVTAB || p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
+	if (p->policy_type != POLICY_KERN || p->policyvers < POLICYDB_VERSION_AVTAB || p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
 		if (validate_init(&flavors[SYM_TYPES], p->p_type_val_to_name, p->p_types.nprim))
 			goto bad;
 	} else {
@@ -803,7 +803,7 @@ static int validate_datum_array_gaps(sepol_handle_t *handle, const policydb_t *p
 	 * For policy versions between 20 and 23, attributes exist in the policy,
 	 * but only in the type_attr_map, so all gaps must be assumed to be valid.
 	 */
-	if (p->policyvers < POLICYDB_VERSION_AVTAB || p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
+	if (p->policy_type != POLICY_KERN || p->policyvers < POLICYDB_VERSION_AVTAB || p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
 		for (i = 0; i < p->p_types.nprim; i++) {
 			if (bool_xnor(p->type_val_to_struct[i], ebitmap_get_bit(&flavors[SYM_TYPES].gaps, i)))
 				goto bad;
-- 
2.43.0

