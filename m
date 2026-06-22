Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12C3115BD
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149760; cv=none; b=dqUsZEcrEAu4h1xx6kbWZ2JIkOfx/8Xuxswy604nDmW9BQkq70j1pWENqr4qWH4si2i4uu7KzDCIsdOJaGDDpoXRx4FQ3kddL2lkDkrUwFe/gQ0x5iMGkB/zu45NG9N7PLlfLOctEIgT9IrCnxrjfGGM+AzED5Ym56jNUZ+V8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149760; c=relaxed/simple;
	bh=GqtjUeTLF9kN9LGyl2kmp3eBp8DM7uG4KyP4/ksrQSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxohJIqDLpo44UuBaWSnuKnMO/vnjZ1A34NuieQf12ENTk8UVbzPW8zlNQhUFH7D1tZl+fblO2lu/qd+FiecaFgLMtKlvUFW/nqtHnCqZrHgWC+9DnfCKQrPDaTtSVFquXlKNDxcq3kpI11CePhwgj1OslBOvqK8XzdNLxW3Tbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enmBucyO; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enmBucyO"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-915b5ce94c7so557251085a.2
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782149759; x=1782754559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLhNNYcu/DA7bauWGEUzKhh5wkP1dMrjtoHP69bkudk=;
        b=enmBucyOT6RVjGcEac3nOzvmQ0VxbQWM4uNfx3XqhHTrovEDIL+9ymM5yF45DLELc1
         lnRaDbiRMmb1xl1KlySJb7RUg/PPjgQ6oWTHuN20ggYDCAJECZkOjrodGqr2iqMBY5kW
         15KTugPGw51aaiVVgY/WAsCqg/oyzqlqBH9EJogzemkK8XgRH/hROiGW3i2wqEd0sRp7
         Xn97DFEj1Dg2A7mEmKIimNUMfztIkmBedFEnJah/MAAzNiuZlVVUwnAUNPaD/V48y/2d
         VDLts82b+DX23yG11O1fNDtIE8Y3oodh2dseYdB22EnDqbj91BJFCNyCS7KkuZPOQzZi
         90eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782149759; x=1782754559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pLhNNYcu/DA7bauWGEUzKhh5wkP1dMrjtoHP69bkudk=;
        b=rJaNRAjn0qKHNVqCiu2pl5GgRFAwdeHVm1jh0kWcl6jS2eXtLxQCgvVN1ftYYAeJQU
         1G/5r7s64X5yQ+pGkBlCIS4TpSnOP6Slz8yVnTgoWyBsvqJn1BrjMdi8O0q2t9zbjpU3
         In832IsLrPSy7/jqy4rl6X5EvQWpslfRjEKRht22z7KdC0a7ikE9G0EEA9GGZUNbDfM0
         Mn3koll6H9Ew7+gIUcfuMXB/P1b8ViYvAswxfCMmQh8F30S2md7o/bkyipGB7qKdNGU+
         RnI+aDFmkn0uLSK6Km8h4oj4XQGvVUAq4l33kwivEVvhuFAnClDYtXr/7CRTr8RxUov8
         Cw+w==
X-Gm-Message-State: AOJu0YzPhB0AK//czur+TkCa82/bBLF8cqQ0yBXQqzwN2kGDyw/3h4y7
	3l5FVhTBs/YIXv6amIvVHHGlBkMHJ/VOdBxu60B7Dxlr2iOGyPlTOozYhhr5AA==
X-Gm-Gg: AfdE7cmk57iGkpSIdtgHg93gWLzoK/jJncfMRC2x8F0YLqjAULmw/CErmsKniZ9w3ZF
	98QkQ+RWOBRG5JagSLX3TCSiLVBpRU/H05R476i1yDpUqv4Pwn438eBBklNKd1oRDKX21Vcaj/t
	RplUmGv4NMIlRHdEuST/5S/gGOygLbeiVltn8n4Tf0eCHfyUoQBQ2gI0c66c0ka/Qh4oDQpni61
	Xf3wgPQuxKYpEFqnCHwVSeKAWQB+kxq3pPwhlFCb362j1ygk4e+5fCTrb1k0x5ldHCy8GtiaHUP
	uO/SVjTBz2k/kPerlhPdpM+rSKOg5fm2gUpNOuiG1cvU/JQDnKVQJJHzZGjb7ZqDsbfGzSPaScJ
	qFsB0GI7aDYYM98rPhiB679yVUPjvIl6G5yHolN6fAuc7SyVv2SjBIhelo4he4mSGGUQ3uYNoGE
	GmF+IJ0DHq0oEpmjZlKPINbgk0HwNescOi9VA=
X-Received: by 2002:a05:620a:4049:b0:915:cb5c:7f70 with SMTP id af79cd13be357-920906d6426mr2557622585a.29.1782149758557;
        Mon, 22 Jun 2026 10:35:58 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd39188csm34813485a.6.2026.06.22.10.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 10:35:58 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/6 v3] libsemanage: Add overflow checks
Date: Mon, 22 Jun 2026 13:35:37 -0400
Message-ID: <20260622173541.174998-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622173541.174998-1-jwcart2@gmail.com>
References: <20260622173541.174998-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using "*= 2" is a common idiom to grow a buffer, but it is
possible for this multiplication to overflow.

Use the __builtin_mul_overflow() family of functions that will
do the multiplication while checking for overflow.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v3: Use __builtin_mul_overflow() family of functions

 libsemanage/src/direct_api.c    |  7 +++++--
 libsemanage/src/genhomedircon.c | 11 +++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 9572dbf0..b87b87e7 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -588,8 +588,11 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len,
 		data_read_len += read_len;
 		if (data_read_len == max_len) {
 			char *tmp;
-
-			max_len *= 2;
+			if (__builtin_mul_overflow(max_len, 2, &max_len)) {
+				ERR(sh, "Overflow");
+				free(data_read);
+				return -1;
+			}
 			tmp = realloc(data_read, max_len);
 			if (tmp == NULL) {
 				ERR(sh, "Failed to realloc, out of memory.");
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index ce7ea167..f04fc127 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1090,9 +1090,9 @@ retry:
 		goto cleanup;
 
 	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-	if (retval == ERANGE && rbuflen < LONG_MAX / 2) {
+	if (retval == ERANGE &&
+	    !__builtin_smull_overflow(rbuflen, 2, &rbuflen)) {
 		free(rbuf);
-		rbuflen *= 2;
 		goto retry;
 	}
 	if (retval != 0 || pwent == NULL) {
@@ -1171,11 +1171,10 @@ static int get_group_users(genhomedircon_settings_t *s,
 				    &group)) != 0 &&
 	       errno == ERANGE) {
 		char *new_grbuf;
-		grbuflen *= 2;
-		if (grbuflen < 0)
-			/* the member list could exceed 2Gb on a system with a 32-bit CPU (where
-			 * sizeof(long) = 4) - if this ever happened, the loop would become infinite. */
+		if (__builtin_smull_overflow(grbuflen, 2, &grbuflen)) {
+			ERR(s->h_semanage, "Overflow");
 			goto cleanup;
+		}
 		new_grbuf = realloc(grbuf, grbuflen);
 		if (new_grbuf == NULL)
 			goto cleanup;
-- 
2.54.0

