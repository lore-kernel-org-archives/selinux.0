Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA13A5E89
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577782; cv=none; b=Ex7VOT3sBKHe53916J35oFkn6Qhw86b+1cblgKED2wRnR0jyrp2m2EkFeVRBuITMeVqaseTuvH3WXVd7JPyJXZVGPWw1Fekqg8DD+MqMlMJYgmH/gg1m9yQh2Mj2ollDJy4CqcxfzF2laW7wGh0pf1iHTEG4j3LKVyUV7B4nU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577782; c=relaxed/simple;
	bh=a7QXsComewTpYKXh+oVPSrKVnGbcKzaUzVsNVUZCFQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjczrCh0VI+EcUbDqMzSMxZ+Ouv6L8nF/rX4iXkEaUkUnWqKA0NFef+KSWGhShRTAlIUVmM3DreJwhxsZiRZOamDihBxtM/Tr6leQNvCwzqdWusd9/VnsxH+ztINmKFgk8OopaSA1gLaMPAeLzef0JywMbWrHlgxZ2FICeFqwxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+KfCNGm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+KfCNGm"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91563382bcfso83444685a.0
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577780; x=1781182580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WplKddhKbVtx6pi0A9I6GKiFVIzM98OMuoeLsTdmHQc=;
        b=L+KfCNGmuRlp1KTveEkG0Gui5PkFrxUgMB1rT6C2xS7riCCM/UGi2a1zHGGobZGyxt
         ovrgFINkqcqcBVowz5/DJQkTiPsVUtCjP+qOzciV3NK2x5xKEJfpJ9oNXuEh85w1u06u
         Dc45h6PMbeVqZkn+RI+UKcwBDTT+Z4lsXCnIjvNkgGtES7atqsupRq83j8MkZ2aExqvu
         KE0u/JFJDcVi6ydFbZjlFq2t6CVD3S/5MtVVY+Ud6KKg2biQQE8TZ1JCCyvTirIqBxH7
         I2l+f5L+Y7cD5u7gPsSdOxuK3Uk6lAmqnO/xoeDAzxV0ySuz3L3esiSmvZmh7YYHTkP+
         0lFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577780; x=1781182580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WplKddhKbVtx6pi0A9I6GKiFVIzM98OMuoeLsTdmHQc=;
        b=Nz/KA5GOyAUO05SckrcyVzjU64+CN9X7Q+lmUFBpXJG8x9pZPl36bwZwjXhSibeZeu
         WGZYt/M7owqNUgz41ZQfv/fYBVmEeksn83GS5CugJvw6oguu9/EcWlWEo2WV0qg0MbmV
         1OdIbJbqhlex0sehF3LT4cVSsNryKN/3jggE0lr/OB/Axx2FP+kJ3YrxGdpMFVW4V69c
         3TtSZfTaND9jcyuXwRGDfVhmQwfCIa0alyY84/NslSokrOAHLGY03VU0+aQwWBB6Olm4
         arDoNhC5fhUIdtFS4NWYUfDFF9L3+MzeW5Us8yFsgqam6hWFdC+ZuhJsm+KB/OuFOAwf
         g6kg==
X-Gm-Message-State: AOJu0Yz6Wy2Jd5dyv+9KMhB1Wg6b86ev06SU4vMjLPSedn0gPtEf49ht
	6XtvuQFvEqTrVWWekMCeVTb5mc47jloTf0vxAIYJboPxcpxSFGV44xOpwFsAsw==
X-Gm-Gg: Acq92OH5aJPV+UxY/jwyWqa2SoSdvAtxy6b1z2sY4LOPVHyW4Qt+HUKNVsQO3mvzeIl
	yt6QpyD7bH31pprfE0/D3+DIjLfUcM9Kf+F6FaN3xi3wPeSQ+BL8PIe+dqWmcZ6IIcVMiHyJcz6
	UgQRxVStxGATX2tr/Id+VwsqEPH7usxjINdhskd3wDrEYZce34SpnQ5IScpXhf+AgzegXpzcyrB
	K8AT7rgMyukeNOZ69GG0xT7jB+V+C9SSYRSRbZwNWCFH569PV+tpCUZf6r46BcHmKbCtJm/2E+C
	4PqgjRWhqnaB7yax5v2HOG52FiDXteTYTAGdUCR2K6i8n4BoNobNER35ihPhJE1u0Xx9hDL9jQJ
	BbiQcyc/b9hkVPivGwVN14umsLREHp+Sa0qHI9yT8mIyPSS54F6Oud7HIlOWeNK3+eczdwDdGqx
	pk+4MTh/V/+omSbqGMbyJRbXlAxurWNNqz4zJCa1SRm8HL1Ko5kGxsB5XCYb1TCWTzY1Gus5pLH
	3U8iSrvsio36Fnm6QWSINUhSMQlczVqefAtzQ==
X-Received: by 2002:a05:620a:488c:b0:915:8010:c2a9 with SMTP id af79cd13be357-9158a82bcb7mr1204024085a.52.1780577779672;
        Thu, 04 Jun 2026 05:56:19 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a243041sm598297785a.18.2026.06.04.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:56:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/6] mcstrans: handle NULL domain
Date: Thu,  4 Jun 2026 08:55:53 -0400
Message-ID: <20260604125557.255554-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604125557.255554-1-stephen.smalley.work@gmail.com>
References: <20260604125557.255554-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

destroy_domain() can be called with NULL, e.g. from the
create_domain() error path, so we need to handle it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index b1b73e40..a983e53e 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -374,6 +374,10 @@ static void destroy_domain(domain_t *domain)
 {
 	int i;
 	unsigned int rt = 0, tr = 0;
+
+	if (!domain)
+		return;
+
 	for (i = 0; i < N_BUCKETS; i++) {
 		context_map_node_t *ptr;
 		for (ptr = domain->trans_to_raw[i]; ptr;) {
-- 
2.54.0

