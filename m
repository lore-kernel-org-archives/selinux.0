Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9A3438BB
	for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824914; cv=none; b=s8X07EAiUHKUZ76DYs7zR5M1t7xWckK5PWmiSBWZy9Mxpl7zs+5jId2DHOAPzqw1U2B1n1ZGlF/qsQLOs4MoQtuSjSfAxd1LxX/0azr213gtt9btxQtoCfdS9iH434Ws4k2Ljn6lDfr/jPfL2qEeUoc4c+l35y2METLvY6ZtmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824914; c=relaxed/simple;
	bh=FP+cKVSzI65xOHE37Wv/ci3oMoPA/GEijv0vVLmvVl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFXwSiyrfU1I4TsPhJO/uAGKKQxDHm/jHG8ZhnCveO6Qt9YbQYmS/Gn37eMAVV9oDRcVdbTEwZcsOypyg3DT7zkQOQTArRBtTY4+eJjStxTm+7RW/BORlkbK8D7YxfnzHCEaw3mRAxuC9aKwLUSvKJd7XzKADSWTBGhDK2/jFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw/A62HV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw/A62HV"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45fd464d51fso916665f8f.3
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781824911; x=1782429711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1ifYMp6eTzkqzEKoZeR2RnwxSQq3FkUzNIWNL2M6s=;
        b=cw/A62HVjv80TkF/pqxCxaoc2ONvZuE+avVJhirASf6O3QjkJXuekOD/kUgaGyrk5R
         /Jecbk5kX4UPxX/qOcD1fZWHNsnwfuUeEaCR0jauznlNdaedUC1ON9k3hBZNzHqwLLbp
         goXfOe8/8y/zgmj0s1UJgc+iag2WDnl+OASAtfGt3demVoYrEDxTMs4rDR3ax8pWg/QI
         mqe191mlkSb9o8pGkyiY8hTc3NUmgXOI3FXPWFaH+wsjUZf6dV00Hm4yUiZC/fGzg4Vw
         +jXpzPldW+2hUndwYM9tK650LrQW0jtIm0riTFeidevcls92Ivj7vgT4UryD0nliJCbP
         Ac2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781824911; x=1782429711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1ifYMp6eTzkqzEKoZeR2RnwxSQq3FkUzNIWNL2M6s=;
        b=NxABU4IiKl0Frsi9ozqBqvw4HYYD+4vmrABAshsNmRE9untEOPngotk7zPm7wS8Ymj
         dX5LwLSWKIlZO/uT0K2/eT1jUMk5nA32i5qVmo/rdfelCT8VrMgTqcaMtRLlyJAYmlem
         DJXcrFAwRABMwshDtYDUNuewEPTOJUTIIMFzrIRABwOdE/6a1ouOHwcbo2i5rRy6bTPh
         r5Y7mzMrxqQfLo5YYNF9HaiPTntG78IPspWu3UZTx1DYnp6vxiYR74xKV+ch6EloPs5P
         V+Sen1Y/i/SvviJQPtTaKOsd0EAGupY74dyBw5xcDlTh6Yw+1kR/ZuB8u8gYPlNMsXv0
         i0mw==
X-Forwarded-Encrypted: i=1; AFNElJ87tohHSHKiG7gQLIZ9qwbn9GI17VLIA5mJb9qg546F+Hw++XV3MXIYnoR43IKt/Eu9snAgenZY@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmNYwfcCf72tdt+WiFV0gobod15ACyHhsZnr/h/kc4qBxahQU
	MFHysE038Jm3OrBnV0IE0PFcLzqDGhy2zOPGSBoA92ftA3ZDmTCnE1c=
X-Gm-Gg: AfdE7cl3mV35lkSiRNFqNbGUITo7bvkDOiCeTPn0dwzxs/l+MsMfI77HlaajWSWRuoV
	x0RAiJdhuuTZGrEpTgxZoDC+ahmykW7oCWeNXQl0xedAbaWehuDIX6WyZYFWfbw818PabF8Fj9r
	lRtndGUd07VeVasaPKitDHaMd/++wrBDsqeac8WIiMioml5fGgDsCaw9AFGSFKwNyGT0j0yIdDL
	e0S83KAjR1mNYxe0gRGMW0B8MmR+DQc7guscTPkfenHjULZyXqHNJ07x7dbpq4wLYP9lGPOWZPA
	+bGuoP4DoyaGR3PhwGBy62LY+AIAsO7tnlc2FeAcbx+TCWlULvQjvjf4hcS8GV7e3DGBM780GnL
	kVgzUzsq84lUNuJ+cy0xPkToWK6Yjge7OrUVxT6s8GlCMtcSbwOE0o8QPyA==
X-Received: by 2002:a05:6000:2386:b0:460:1967:abed with SMTP id ffacd0b85a97d-46503646b28mr2545178f8f.39.1781824910620;
        Thu, 18 Jun 2026 16:21:50 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a0546fsm2619200f8f.2.2026.06.18.16.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 16:21:49 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Richard Haines <richard_c_haines@btinternet.com>,
	selinux@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] selinux: fix NULL pointer dereference in selinux_sctp_bind_connect()
Date: Thu, 18 Jun 2026 23:21:48 +0000
Message-ID: <20260618232149.1780219-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

selinux_sctp_bind_connect() reads sk->sk_socket and passes it to
selinux_socket_bind() or selinux_socket_connect_helper() without
checking for NULL.  When an SCTP ASCONF chunk is processed in softirq
context on a socket that has been concurrently closed, sock_orphan()
will have already set sk->sk_socket to NULL.  The subsequent
dereference of sock->sk at offset 0x18 triggers a kernel panic.

Add a NULL check on sk->sk_socket before use.

Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 security/selinux/hooks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0f704380a8c8..e45588563caa 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5717,6 +5717,9 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 
 	/* Process one or more addresses that may be IPv4 or IPv6 */
 	sock = sk->sk_socket;
+	if (!sock)
+		return -ECONNRESET;
+
 	addr_buf = address;
 
 	while (walk_size < addrlen) {
-- 
2.47.3

