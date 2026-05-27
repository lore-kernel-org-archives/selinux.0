Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C837A488
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896418; cv=none; b=B3ALoQojkYduKTftA/QQ5tcOGUpjU6CYa3CwTPMmpDBex/7u+Idz6wVbq37bDXKDZ9FXbnKjiseBZ8qR9MOloGA1D4sUGIqOJdpAyG9l7ObJhX5T2hy4Cb+kqif7nycqlZV9txrKe1Ug+BbhX068JbXn8rLKgNpd6gYLVFuALTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896418; c=relaxed/simple;
	bh=B06T/2Z7t4GSIArZc8x+P0CDa7/6qgzTJZWK9BbSGZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fveolFlXkA1BTNNIuVoojlePVs7JjIVJCtqGHgQGEzesh1C39g3omRPU0RZRk3nwOnsjqMtAO3g6frtcsdVa1dzXcGmyhtTfdtIOvneUsh3tNSRDCZDh+uLPsYLi81rvy+S7xBTuTdcGrLlMztvbI/p1D7sQwBI4xHOQ9jGhXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAo5ysrv; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAo5ysrv"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-90ca6f20872so1462881585a.0
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779896416; x=1780501216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5P4FBCfvA0TkQxKmwONadtywInWtS61aBNDJEbmyzLg=;
        b=XAo5ysrv4KlEyDwz6frub4LF8x57EQIpGwZ89O7q8TkJb5HpmcuKOh/u8bCaA2gFq+
         wMksEpfFPkJA2NVGkdxVWFLIHgx7xk1JWACAIC69z6VkOVi/9eL9bxcRM5UQUDByIwdp
         oUs7fwi8B/68mcqgONTnHxkCkHbJN+uPlhSDZVvReyc8AfiTl9IvpFrEze7C0frZ0QHw
         gQyXMQ8rrjX6ue2GbopXFrVJQenv339hpSSbFmQZXJ73rcbGj1TtoHreFE+pgyFF9nJF
         3iSZJA5pLVQl7v//QMacX6Du5H1ESz+gt5+z8JSDg1yaJ3PCXsBmqcwwCzfxglXO58Ya
         71yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896416; x=1780501216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5P4FBCfvA0TkQxKmwONadtywInWtS61aBNDJEbmyzLg=;
        b=FZ6EkjlKV6ZICbh4MZQOo05pQcb5EVtetg77nqAm1S5qQDgMcD92zZdc7tGYYcHmYL
         hqsXTnBKQhv6rHXkpnOFpodjPTjLSbaghcpNQMGXsSTgM9GqKJkKS7IWKbJkAa8jP957
         AGnYxKCBX/LbEsY+tUZoywhENIrsK3I1WGllSi/jyLlc+lvVMxZycj8fbl6n0djfBtwB
         UvAPl8UCBLQFEdAJyMsnv0IIKjg8/EC17r4A42KJYsfpkeaTElnCBu47kgXXDaWGWE1M
         pXH+MrYwRtuLucTwxzKj1PsF95BTTG1qWPLlPWU72xCGYvq3+PygjCG7hVLcSQcBuDmb
         HzqA==
X-Gm-Message-State: AOJu0Yw0vLZ2f1p7s65sUQbWVECvIp3qyxxxpGdt6WfEPS21jUpCMOsV
	H6guwIRgI1iM7gzS+DGYkZOs83YI2EWW/ifYZXyrbgnCpCuktOq88yLwUNZ1zA==
X-Gm-Gg: Acq92OE1ihmGVxC/pR5mcEhZU6iz1X4BpPCTZSy20axnrtSblQLWwosW2t9KjG3C/a0
	xCuLuVOrdEyH0A/V7TXD0peXzIT/j3HUz32jfdM/d1Ep9pGvtSyR5PgWkp9R7QV3UTBQcss5wEQ
	mDHsHPT7fjiQN3JJ28e6BlkE5f8lLhfN4HoTDke56RZB2s4RnEdLkjSyCH6PZadtyfTHE2YAvnG
	LzLU2N8BrUcOlJj5DRD4nmB8m73SnHB85ppZBmZdj/p/D6rvXRBBTfanCsjwMyiV1vo6m318tjc
	iGAdnzRSJY8JUQQYBIziqghTygXN2voPV+x6MfDnM11hfB03+Y+AuSPTG22x5HJBQ3VUH5DjCj/
	aK/7fID/jQLIEOaO0CszaWc3rikJvUubZvXrm2v7fWOpOApn9Hw2nx8RPO9+En2FiJEQ4w4hLqs
	6ozBY75Pc4EEBv8xvHkTtaTiSc9/sip1xBP369sTeGONHetbXkAVe5aTSmqjfDR/sa630GCSMnW
	9xchh59dLMA//PF1+fPVx6FcCnuEe9ZbmYoRw==
X-Received: by 2002:a05:620a:29c8:b0:8cd:d688:7aef with SMTP id af79cd13be357-914b50caa55mr2682538585a.19.1779896415918;
        Wed, 27 May 2026 08:40:15 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f880c526sm494679785a.39.2026.05.27.08.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:40:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/3] mcstrans: fix error path leaks and NULL-derefs
Date: Wed, 27 May 2026 11:39:53 -0400
Message-ID: <20260527153953.27606-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527153953.27606-1-stephen.smalley.work@gmail.com>
References: <20260527153953.27606-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several error path memory leaks and potential NULL-derefs.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 45935540..5056f86e 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -235,7 +235,7 @@ static mls_level_t *
 parse_raw(const char *raw) {
 	mls_level_t *mls = calloc(1, sizeof(mls_level_t));
 	if (!mls)
-		goto err;
+		return NULL;
 	if (sscanf(raw,"s%u", &mls->sens) != 1)
 		goto err;
 	raw += numdigits(mls->sens) + 1;
@@ -439,6 +439,8 @@ add_word(word_group_t *group, char *raw, char *trans) {
 		return -1;
 	}
 	word_t *word = create_word(&group->words, trans);
+	if (!word)
+		return -1;
 	int rc = parse_ebitmap(&word->cat, &group->def, raw);
 	if (rc < 0) {
 		log_error(" syntax error in %s\n", raw);
@@ -485,6 +487,7 @@ add_constraint(char op, char *raw, char *tok) {
 		}
 		if (asprintf(&constraint->text, "%s%c%s", raw, op, tok) < 0) {
 			log_error("asprintf failed %s", strerror(errno));
+			ebitmap_destroy(&constraint->cat);
 			free(constraint);
 			return -1;
 		}
@@ -513,6 +516,9 @@ add_constraint(char op, char *raw, char *tok) {
 		}
 		if (asprintf(&constraint->text, "%s%c%s", raw, op, tok) < 0) {
 			log_error("asprintf failed %s", strerror(errno));
+			ebitmap_destroy(&constraint->mask);
+			ebitmap_destroy(&constraint->cat);
+			free(constraint);
 			return -1;
 		}
 		constraint->nbits = ebitmap_cardinality(&constraint->cat);
-- 
2.54.0

