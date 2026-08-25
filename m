Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92D331ED6
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686888; cv=none; b=sG5SBHmNKnJeKhgrxC+MsliLEif3tH1HYFS2p00zwH5NaYE1CHwSpa+8XsgtSnBxurWGUHOR/EKguJgzFv74K8QTojh9Y9n2FtM2l8RtGZXy+5jcGCZVwGUJfd0kt+aV3vYY8ZyIInh6015qMqRC61Fu6SjUyTfYTUuY0IHe5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686888; c=relaxed/simple;
	bh=6u3BFA6sqpRwEtO4BiSkKaIZ9bkoRAvZax7wmrqBplE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pATRGvPZtzdgdNoPkQg0cRLWbhGb+DArBBCK8mFEphgZRLeGT6UP10RcDYGysGLLaFJzKSDcN+a9Ssbg592S+/G29cT04QBpCy5oAGsOOBVgCiAYE474LsaNizvm2wc0hKgh+RxZFS2scatXeNBjgeI06HUjNZ1An7AOGTQb050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JByA0tzJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JByA0tzJ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90cc28ad662so1692306d6.1
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787686886; x=1788291686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fRRztf/1eLVYBQWEfmqMMXf1Orrz6dKl0yy5uiX2spY=;
        b=JByA0tzJoJdsSiypaT1u3kyV5dWSyTq4YOH666V7aqLV3Fyi52PsiafjDOBoBrwMyI
         B8S5Zw0Wm7Vm2/IgRf45lI3IVAR1SiY4S0c4JsxOn+LgqVF01Mh/wjFfadZzjvunhf7Z
         d08v5lT6Ws1FhIt1iXRd4midzMf5ocoGYXuZ1G1nLi031TLY3UAq20VhF2JcF5PLeZGI
         xHAb+c7asFB81Vhyf6vBi1cnxdNKmCYJT+ItRwkYarcysnPJsKiiGkusq6MvL1q2YQ8K
         BEK+9dyQJ2pj9tCe2jgFDPkf3Nvp189AtRDc0XqNs46F+WmH6fx/L1AReEWV+d53Hv19
         16mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787686886; x=1788291686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fRRztf/1eLVYBQWEfmqMMXf1Orrz6dKl0yy5uiX2spY=;
        b=Vyut2msmMswD+ftyjpDwWLuYr6c2b1d6GkLz7evp/EduTII+/qnQ30ctlUpgM97E+R
         7HEJ/VhKZYuN8OjeZ5GvMauvevaXjRRDPWtssqFO2s+qFhKYiXjADnpp77/XxhLurCC3
         BhUwSz0s+MnsQLFnOBeVbu6LWSgG0vFeaBGIGwqeRcSzDLtx57eADonIrZi95SQTzk08
         /FKsXp2+QY207mJsoDpXvNYgBelCPpSAHaVEhT/1+1zK/l+RJm8vldSN+c3teNekSA/W
         +0glbzKHcviMOWpX45ws6iUocCG5JLuebo1mDNQwf2m9RjLQ6pqdTNxZg1SZOycb4+22
         lYPg==
X-Gm-Message-State: AFuF++nPkKR3867SVuWmboRH/HVwMJzdru/OUCpOeAqmd0R4yB0C0Hsv
	I+jDFXLjUdTH+sx+4A8ZNfqdNE+Y96jG5kgHAGR2mmyyO6YJs2YefGF8HrX+ag==
X-Gm-Gg: AR+sD13cOtpdYW2lcpEs0ofWqeUDdWN6dQb1mBk/BN8TSPMhkvHaBiQH4H64c+lG5Bm
	lD7wl7n58dDCuUdTdzKkt9Lsz9cbkO7MeJ2tRzp+bq9S64TyB+NqF7Gbo3dj1gaYFqpaqYlHUrD
	bD+/hvdyvopyeq1FtqXNjoPATaF99BxMHZkB7Mjb3W62cqtnH7dl5slRAhDSwY/WgdDZ7AQAnub
	DhGx2tsvyos5+W2V1giGmv4g5brj5xBbYXBIbSzDzkff87KwWZkpSTlRoJBkoPcMM/1sLiDC3Hh
	BSTqzMmgXZmRfN1V8p4w3Ooiois/O34wsgvd6sIATNO+U9F3uH6Q1q1Doz/Ig2dwZ+8+FsGnJQc
	xFQkdVk9dODwFhuDRJeYRd1vJKHq3PpZYRcYpp+fW5Pn9KTDdQLzPSHq/tE0gBu0xH7BDGac042
	pU+rwxaCjkxaHPH5usq1WaV7cfhaZlEDUiU9mRokzgug1YEpLZQHjuQYElCP3YdrNnBFU+att7q
	VjFXK24QucomueO/RhGkQ==
X-Received: by 2002:a05:6214:301a:b0:8f2:3472:5b33 with SMTP id 6a1803df08f44-90cc7a2044cmr11002926d6.23.1787686885741;
        Tue, 25 Aug 2026 12:41:25 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc63e42d6sm6815846d6.12.2026.08.25.12.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:41:25 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol: Remove junk permissions before optimzing the policy
Date: Tue, 25 Aug 2026 15:41:11 -0400
Message-ID: <20260825194111.75602-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825194111.75602-1-jwcart2@gmail.com>
References: <20260825194111.75602-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In older policy compilers, a wildcard or complement would cause
all the bits higher than those corresponding to the class's declared
permissions to be set. These junk bits must be removed before
optimization is done to avoid a situation where the only bits left
for an access vector are one or more of these junk bits. If a policy
does not have at least one actual permission bit set, it will fail
validation.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/optimize.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index eeffee7d..1efd3832 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -446,6 +446,32 @@ static void optimize_cond_avtab(policydb_t *p, const struct type_vec *type_map)
 	}
 }
 
+/*
+ * Older policy compilers could set bits higher than any of the permissions
+ * in the class. These junk bits must be removed before optimization to keep
+ * redundant rules from being kept because of junk bits and to prevent the
+ * failure of policy validation because no actual permission bit is set. 
+ */
+static int remove_junk_permissions(avtab_key_t *k, avtab_datum_t *d, void *args)
+{
+	const policydb_t *p = args;
+	const class_datum_t *tclass;
+	uint32_t mask;
+
+	if (!(k->specified & AVTAB_AV))
+		return 0;
+
+	tclass = p->class_val_to_struct[k->target_class - 1];
+	mask = PERMISSION_MASK(tclass->permissions.nprim);
+
+	if ((k->specified & ~AVTAB_ENABLED) == AVTAB_AUDITDENY)
+		d->data |= ~mask;
+	else
+		d->data &= mask;
+
+	return 0;
+}
+
 int policydb_optimize(policydb_t *p)
 {
 	struct type_vec *type_map;
@@ -453,6 +479,9 @@ int policydb_optimize(policydb_t *p)
 	if (p->policy_type != POLICY_KERN)
 		return -1;
 
+	avtab_map(&p->te_avtab, remove_junk_permissions, p);
+	avtab_map(&p->te_cond_avtab, remove_junk_permissions, p);
+
 	type_map = build_type_map(p);
 	if (!type_map)
 		return -1;
-- 
2.55.0

