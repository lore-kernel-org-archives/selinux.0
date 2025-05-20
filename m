Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B647E26B948;
	Tue, 20 May 2025 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742519; cv=none; b=jALW70LTTZMGixJkRjM4yRar1XWPEogUjRSchT8n96TyYOQC/yJfHoloWtgX0oGsLcpLZEVnRbI0x+TX22IRnCTEMnggLO19+Z0AavYoXhuRsZkYct6mhvPVV77KCVPMX2z62cIap0toFQwYvv+0uwAdEieDYWS0/jwTXASrMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742519; c=relaxed/simple;
	bh=RAPV0XupHBPU+sxoXsNTiW8FNW3XXZqf0SHmY2yO0e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I67WrbKX1AB7Vnra7LM+xsSysWQd8XOPVUXZkGgXm8o5ni0gg9EayiHHP+bToxe2EscBzl7LQkt1iH6Hmp9TbSxXVDUCxK0G+FNKTsmn5qQFHKA5aJwKysLLWCaaAJm3S9AtOOfb0Fa4xGeFXQ8Jgh2DoZoM1dVWGpr6bRVtmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDGV4S8e; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDGV4S8e"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7cad6a4fae4so914366585a.2;
        Tue, 20 May 2025 05:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742516; x=1748347316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiPMTCWHzzmvqTaUQA8eRkbXJwfIgGwK9f7ct44S1sU=;
        b=WDGV4S8eyKfF6jxIutWwuk6u033inP7UsCElkIPlk/Etvqk9E1FqcnPr/oXXOWXSW4
         2zz8eBIS6sDCO2EBbu4yzJTe8XGMDue1CItF+S80vgtTChb1uF/Q6WaO9ORx7PpcM62k
         pgT9PMwh0XVb1X05cQmrYnk+QXBXQG9bVv1j1ZW/waHsupS/JoJDXTnDYYd5G9vAFDRD
         TI3AmxmHiK5ptRHsoZNI2c07VqD6olTnBqN0H5AS99kxIP46Rjt+vgLOXlBYXQTRySyK
         AVv+uC4pfqmH0eJx4q3sUVM3MiZ0AOfqDWqFJykRJchuisT2DkrmII8ltJZth2JfxTb1
         NZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742516; x=1748347316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiPMTCWHzzmvqTaUQA8eRkbXJwfIgGwK9f7ct44S1sU=;
        b=hdbgaS1Nl+Mkl+g77wsteMEKwK+5ElhKUKCdTl5o3MJQINVv2R7XvQUS7OVAEO9qlR
         cQ+pm9MNyZSkHEmgPQn3JiWQCKwk//lDo618wD+BKnpGE1oUioN4BA9eWNSPSkqzXDGN
         VJ5cRBhTc7ai6CKJQjpm0BfV+dGIzxtlZ1NlzAGbIyzYcySyfiWTBVVOpv6oOk63OcdR
         TcyvuYDcXnMRD03Ae9pLMqs8YNQZc4vN2ZviRy+xtLNrJut7G2aW1atockNsE7Q+szN8
         T9z4W1QfG3SBBXNOoyQMHvpM+0fMnbc1g+QpoffevuWG/OhINGyKrJecST7V2k5/nhAE
         OaWA==
X-Forwarded-Encrypted: i=1; AJvYcCW6oR1N6PP5NCcNgZc4polE/63ZktrlgdCgMNIOkcWLB+qizfDlMlQ7IYwTzg/w0gjKFWd7CxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73lp+atmHXGvy5lY2/+LnnNjmr3eYfEaGgeGhkz3a1G6Ejo3d
	UDSBcX0JISy3KhtSU2vjMT6bzC4o3xqFti9UNTG1kBA1ylkRx1EGWVC05fuf2A==
X-Gm-Gg: ASbGncty+HxX6gT2L/nyt9WNMZVrBapHu8q4rn7nrWqTgooh1Kw2RWJmnW7T6DiGVaV
	FhlMbbyRO9WJHwZlSaS5zjCbY95YUgyCLAMi8UqO6wyDp1GpdZ4f+i8tb7Yff18jcT11snPkOTg
	UmBxSVY2rkeU3pHgXoIWFbtCySjkqA6Tr3dXhpCDv+6WB+H4tizwjznvaSDYilCXBMuOGkbdYlQ
	Yembnwg6jz/j3ZrB49/9Yn2VbhJ37Rcm3l9eFw3IpRkEpzKXL2+9VGnAvYDNQJ49cfHVZbIB4Az
	a3JrK6VFtMsOR1u7MzXIZCbmK7FQJuCm0frQ2/g/jU+lC1Vx3PR70wyOoO4rNLm7j0ef87dR81X
	8YHV5UfapwGt3hVyjVC2LCrdlsHaQAotdPxNa+GOPCuQs+q6HNo7Yrw==
X-Google-Smtp-Source: AGHT+IErMeUT2sBtrNFIi2A9CrG6UuQNK8gJEphqHIDjHvDVAZXSMPjIXd9DNUtwth9YmAH5lKjVRw==
X-Received: by 2002:a05:620a:198c:b0:7cd:45ef:f181 with SMTP id af79cd13be357-7cd47f1e97amr2026577485a.21.1747742516437;
        Tue, 20 May 2025 05:01:56 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:55 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 41/42] selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
Date: Tue, 20 May 2025 07:59:39 -0400
Message-ID: <20250520120000.25501-43-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert nlmsg_sock_has_extended_perms() to use the
cred_has_extended_perms() helper for namespace-aware checking.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index deba2b4d81c9..dcb97a636aa2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6303,9 +6303,9 @@ static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_t
 	driver = nlmsg_type >> 8;
 	xperm = nlmsg_type & 0xff;
 
-	return avc_has_extended_perms(current_selinux_state, current_sid(),
-				      sksec->sid, sksec->sclass, perms,
-				      driver, AVC_EXT_NLMSG, xperm, &ad);
+	return cred_has_extended_perms(current_cred(), sksec->sid,
+				       sksec->sclass, perms, driver,
+				       AVC_EXT_NLMSG, xperm, &ad);
 }
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
-- 
2.49.0

