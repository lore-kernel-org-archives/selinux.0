Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093657;
	b=wZzKcHyZapHEEUcvmwAzmAxMlTnOQrcB9mG4bc1Jl8pUNGWa3dBS0InN37xyNtnhAxs8
	 dKAil4EAjJeXvezT6PVPe89pfjTZ3o05OKtO/NEXjpdB8lg3W9sNlWoz3iqogI+1qq6p1
	 AuLvTPSjR7sU5E/izSxPhl22eHQxnbu0b6RITP33z35BTZfiHVDz1+xywJSvPw1nsnKud
	 OooRdy3/wbYnbKEKLr0O9pwuBlyH5HBicW53bPn13QTlrD31EUi4IRFoezG16hyGGwSK/
	 qy62twWcDq5CKjrPWtbLr15IUnIuK5eMh0gnXgYOZupc54/S3uc532N299AdqF5LOLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YUQEfrybYNwjd4K1V8vGFto1xdTnl7ExPmG6thJlkik=;
	b=fWhc71LwOk78fITq1PfXWUH9r2RiFXuTewS+lToj+2xR/NljNkYQKX1i/G4/bZLvG3Ka
	 NesZOZ/045Wx29MBWlq4I+jBoAccnWM5GzMOBQQZSZ9+PLXbp2sjOSsfEEpUv6p5ybCkW
	 IOdAveFSLL0eAgYZyXo5+hCfjVrGUY0eeKo5hpFbqS7Df+lcaZwbOYjCNVIqwbhxUCZTD
	 +xWUULJKz2ixQjpiTkHH7GGJvnwHQcJ51GGbCwRNr9JyvYDQ7Hy9QZgCQBSz2shZx7J4U
	 F+UQAnvdn07P0YOS6wOZK1imHUudHaM25n16irtMuM4D7FYXC+WP4KCQjuaX4GlGtkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSyWFWH9;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604D2606A320
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 604D2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSyWFWH9
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9495e8ae23aso188414085a.2
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 05:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795093656; x=1795698456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YUQEfrybYNwjd4K1V8vGFto1xdTnl7ExPmG6thJlkik=;
        b=tSyWFWH9vH1MCGKQX/lGTwEO7m9sW1lQJLBMe1Vm3V4DGq6BrhZ6CHk+cyNwh9xv3L
         Wgt2W6xPBKEa6S4hzYfsOASTUmr+3Sjp7ejlUCe77eW+uzUkPER99qTzxKHZwpZvOTuP
         cQjttxsRKTBGN1PaFHc1+BXBcTjC8CJi7gylIKOEY9OvloP3rK6yCheh5o9aTCpGCZ4V
         DJ8IPqHGU2fKdYebUXrJquX9HUjlWp4eeXth0vGveR+L2t6gGCLnLCFNDoFSKTR7qVVb
         HtujgqUmFzmUHm312PXqK2OYV4KzrFqVScNP0Y8SWZV/L+9QzxytlsohvhhcZOWqnsSd
         D4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795093656; x=1795698456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUQEfrybYNwjd4K1V8vGFto1xdTnl7ExPmG6thJlkik=;
        b=grAIojoksmAqxjwQwOfZf+qr48Mr2UXhBNIWiPppIpy65NkTBuvlv+/ZpTRnzre0LG
         VtfD1AQHUMJ9Pgmb71J/eqqTACSACoxXbeOxeEHJuuyP/XJwb/yghU1+axZCptLAyEsn
         z9Wc0pdHXzwRh4ovqqDzKE4+L4RzSpEbZsEBpu9g1ce+uxgSRK2kUEPyzQ8gMoPy83/p
         FaF0eh4OGhZ6XeAh+7OoOnpInIV4K98bR20lTWtlXI1HUbqRAxQ639RqDETUQdKu73LC
         XpbXmngk3DMtMvLXKjyp3pK+lVSMs8YpPtDjWe88flYuKEy4qJA9gZBQK13dJjZCmZ6P
         3FRg==
X-Gm-Message-State: APuU4Z/VoIRs11yRI7/AgYtESH95rP6sAVeZjSYMjYpBVHMZLB2EZhj0
	w27IucNNQLR0OI0AMVPoa9UdzcOXi7xE9GTpbmfBQww3vfu/2jAYauEQ+ECkXw==
X-Gm-Gg: AYBFou2i2ehU1sMrBaXflGiYl4dIxgTEQ8Iy0JGKoIfKTRZABfBC7POM19yydg9lrcF
	VJMYSgJFp6jq8xzkL/H12323VoBwnP1DZqB23sDoOy3T4qBq2EzbGGZzJRd+OmZSwO4gxJ5x3vr
	UhtwaOcubuUKduavQAL8Vj20UrKR+NJpMHD/1dcOROC+A5Ow4XgYuUJHy2AUqnamdJRVQzPLS9+
	6p8YNcw5TOU+N/osi5BRV2fWTDJh3ifpZpy4APagIvRUCfZHZHWuUmgqEW6pDI9Y8qiXKvhOonx
	ikZCnAOUjCh4o9h79O/azW1Kwte1uSpkI/M2b688Oc+CLczjjqTdzVa7/2IG5HEHEYDxul5zwGo
	Jm6jhTVPhzJFn+Cdeab5vFYlRa+c1LsC+2Lx5DUE0xYz1bkfu8Nj9Ah/8w5c7STvpQ0jgtVMvdu
	a26gabeUSDRba63kmySaGHnOaScfIlaHh5TLvmH0qzOMD/RKnaJ4jYW0VB/btfd7wyIn3w//9BX
	iM+N5jSqazB48bypB7/5k8bQqswXnk5Kum4sXiEote9z8nApV8nCtxlvl3RQSERP5JXVwtHhdNd
	ZcTfYiOAEmdtxcHGHqC/cET789i6TnrDlnz5ZaoVClUMb4jdsibZViV6jFg2NzH3iQzypGs5Tu/
	+wjPbwIuqoknykGZ54Racy74hvH3+XgL819oh2EWNY+6P1ZCPqkjbSOYLzfOrYJdOCOw6YJYyap
	Ytm3TUMEg9Z6A8OuzsK9qMJSJv6rh/CxKa
X-Received: by 2002:a05:620a:1a22:b0:93e:c12c:43f9 with SMTP id af79cd13be357-94999605c74mr989600885a.70.1795093656157;
        Thu, 19 Nov 2026 05:07:36 -0800 (PST)
Received: from debian.. (pool-96-244-147-163.bltmmd.fios.verizon.net. [96.244.147.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b721ccbsm438971785a.10.2026.11.19.05.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:07:35 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jwcart2@gmail.com,
	paul@paul-moore.com,
	jason@perfinion.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: prevent path traversal via crafted username in getseuser()
Date: Thu, 19 Nov 2026 13:07:17 +0000
Message-ID: <20261119130718.783-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

getseuser() builds "<policy_root>/logins/<username>" and reads the
per-user seuser mapping from that file. The username is whatever NSS
resolved for the login and is passed straight through by pam_selinux;
Linux imposes no character-set restriction on NSS names, and directory
backends (LDAP/AD) can serve names containing "/".

A crafted username can make a root-running PAM stack read a file the
user controls and take that user's SELinux user and MLS range from it,
i.e. the confinement decision is delegated to whoever named the account.
Fall through to the ordinary seusers lookup for such names instead.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/seusers.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index ea542392..df9385eb 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -293,6 +293,14 @@ int getseuser(const char *username, const char *service, char **r_seuser,
 	char *rec = NULL;
 	char *path = NULL;
 	FILE *fp = NULL;
+
+	/*
+	 * Prevent path traversal via crafted username; no valid username
+	 * should be NULL, start with ".", or contain a '/'.
+	 */
+	if (!username || username[0] == '.' || strchr(username, '/'))
+		goto err;
+
 	if (asprintf(&path, "%s/logins/%s", selinux_policy_root(), username) <
 	    0)
 		goto err;
-- 
2.47.3

