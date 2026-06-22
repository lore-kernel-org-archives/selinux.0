Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1683BE155
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142424; cv=none; b=J7F+6CSEvsF78NbEtWe3bQDuQFcMCAuuCj7T5+kZ1ObW5yBT4nwGeMrh+7FZ/SQNDSUsNA5occJKkl29qxrIgvIvI60jW0gAP/pes/Cw3TLjBoNMAx/2M3kJCfTXH4Og1DQtUuS74d8+xHvpA2Dngmi3EGGwaS7+wIg41OiRw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142424; c=relaxed/simple;
	bh=Bo+f3mxEFNK+5sKruqkAlg2oZGbHOMO4q5tVUTemKps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIFR8ncWwNKh1W54MvpvIFxaaPyPYQn36rb4odhhFqaiCBIZgv9zYqCxuFdwmxDmvJaZEHVbtqC0jGMM0tygWLZnForw8tYEc7Boe5bQS/sgQSLLOQx7J/QqkClMWMa2vFfk88CpDC9AToqh97Z50//vTc3xwaDIC8BLl+NQsGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSmux1Op; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSmux1Op"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-728fa2ce6f9so1423934137.1
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782142421; x=1782747221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lvf3ucdqAGWGiFv56n+bbdirRxQ7gxn7ErVF7nu+92I=;
        b=dSmux1OpSbcOrzuRQ57vQL666t6wkpjuHTm2QpkVc+BNgd8dDhaVUqFiG34E1dx5a+
         89wcls1ZTtda65AtLpCrZ3TzJ1wrWuhVhSWQjbXpgYcy2JQdXDAc6kmuxUOV7ONyoplx
         oj6yHIxWOz9ohR6gUdaS+E8kkVTCWHUGDZNkI7MXAjV+1ViAeeVVz0124KZL1GFprxHP
         +EDH2ds2VwYLCSLsl/cunkJE6Up6DKV0roGRnkHDD917MN9JXYwVNdJhpSdueaFB5Bvo
         HFtBAlYvGcWfD14drHDm4n0kwDChqdznnGmFe86UUfRub145T468BjT0nygY2dDNVQsK
         3oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142421; x=1782747221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lvf3ucdqAGWGiFv56n+bbdirRxQ7gxn7ErVF7nu+92I=;
        b=NCa4UFqtPEk7fRjg1Bd2IHYgNBRyuRnOzbXBpodwselpYbk54asChXfcjtcStVq9p5
         dKDoipfRaivAvB8evaMikSb3dtS7RLnqLC0jcSzwXdnyFo4DdPbbPtEt/tGnf6X4XQkA
         VXgYgekIbVKRbQLMYE7zVN9xl+ak6bN3BPef8+s57WJdgSRU8bcJR7uQeQcKWGn/CNYr
         pZ4SpxAs1FEIaDozDmTuqrnNOOAn9Q6ujM+pQQRVAGCcVW29l0fEQ6jT7iYQqp/l8nVf
         5KgMFhd47VXp4Qm/i04QsCDryPC7TdBr8QzzTgp55wl+ve1dr8CAhLIIjs5ibmlQUx93
         rO7w==
X-Gm-Message-State: AOJu0YzXz9JWIV0m3KFityP1/e1dadrRnxnooq50d7KjjxWkamQnw6h6
	1m9SmjmSvhgMdfAio0PI4irKnzNpwF4Wp2cDeawdB8r2igL7G61eonXvlagXbw==
X-Gm-Gg: AfdE7clpLaIvuIbsYhjQ9gvGWd9pBYtBHZ5BpOIxAaka3ba9Nyea162A9pDzg9gElnk
	CqsY/Ru/Gv8t1kMhD73KLkigJ+FiBaL5cZiFziN9t1xfAfqaCdeP625fl2FBzorfivKSrmFSJvJ
	fnugVEmdBMHc1qj4nFF5uEbqYhRQRdE09POG8Fu7VWw5bnVpBQERqysVSBmKXNaH+QA3MOcfe1l
	DsudgvV0v9OJqPXmdnjb2eM17ng24i2vIBhtK/01dA5gzyQ7bjXZoAqWgGOLKHUTvje96Ma9DOX
	vni4MiQEHgaxz+78JKdXkWqhwqcQlCNdUZwsp/lFrmGtJe7oP+5T0Bg/LA4rAQiAcD8ux5JF0ai
	Qe+sGKhuy9kiE9nqSKbH2+Rr83Nxu/oWpryKmEu1RnccZYI+6lLlwwAjIqiou/Abg9XPLCCgZ58
	aCE5SEp1MaQfRiLtHbrgu249alE3KVfuy9Vaz76XZvWexlIIM/+zcKeEAF38pPjG8SN32ZBAHqF
	YgkHjbB3jY+g5/5
X-Received: by 2002:a05:6102:5110:b0:650:9174:f3 with SMTP id ada2fe7eead31-72b65396399mr5606865137.12.1782142420561;
        Mon, 22 Jun 2026 08:33:40 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd3923edsm2964785a.8.2026.06.22.08.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:33:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH v2 1/2] libsepol: bound type values in type_set_expand negset loop
Date: Mon, 22 Jun 2026 11:33:24 -0400
Message-ID: <20260622153325.17783-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

type_set_expand() iterates set->negset and dereferences
p->type_val_to_struct[i] for each set bit without checking i against
p->p_types.nprim. type_val_to_struct is allocated with nprim entries, and
the sibling loop over set->types already guards the index with that same
nprim check. For a base or module policy, role_read() fills role->types
(including negset) from the file via type_set_read(), and
policydb_index_others() expands it through policydb_role_cache() and
type_set_expand() during policydb_read(), before policydb_validate()
runs. A policy whose role negset has a bit at or above nprim then causes
an out-of-bounds read of type_val_to_struct. Apply the same bound to the
negset loop. The single fix also covers the other callers, expand_rule()
and expand_convert_type_set().

Fixes: https://github.com/SELinuxProject/selinux/pull/532
Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 libsepol/src/expand.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 0bd61c82..8d7fe519 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2783,6 +2783,13 @@ int type_set_expand(type_set_t *set, ebitmap_t *t, policydb_t *p,
 	/* Now do the same thing for negset */
 	ebitmap_init(&neg_types);
 	ebitmap_for_each_positive_bit(&set->negset, tnode, i) {
+		/*
+		 * invalid policies might have more types set in the ebitmap than
+		 * what's available in the type_val_to_struct mapping
+		 */
+		if (i >= p->p_types.nprim)
+			goto err_neg;
+
 		if (p->type_val_to_struct[i] &&
 		    p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
 			if (ebitmap_union(&neg_types,
-- 
2.54.0

