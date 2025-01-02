Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384E1547C0
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836370; cv=none; b=ssY69Iorl8ZdYl+4KCSxP2BcY5iYQXysz0YEs4phmfC/B4LLqLadP2DIggJzuyJN+vmlo+/wujjnt1WS7pBaMV0zSiCG3Br9GcEbqfteyjniTRDTCEu4Vhk5OWYMah/A6ARksqdcPHHvtMazq/kDFuJ1Imfn3KdUjJ1IBCRLZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836370; c=relaxed/simple;
	bh=+iZpS2Rr1b/5SWTrq6fU9FOEkkYcEP/Ggj4ViT0wFNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V481wETQoupFDcHoRrQoVW8vOkboDeCnt9hwd3oJlx9iVmbUzAmu8kJr+Ock/Uo4y+zL2n+b79fcczpypITrrrZ7nnCILdllD6JFRD9xLi4ghlbEA0B+GfCIsTcCiHZPUSziP9TwZbxYBE9kPONAwFtB+UhfQdSYe0J/bro13eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRqNitaJ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRqNitaJ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6e8814842so991322685a.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836365; x=1736441165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeDvGkxIoG2pQKa7PHtBx1HxqggtqDBJK5ahsNF77fc=;
        b=WRqNitaJRwi9dV9ieqEQWSR6sNmvQzJyyiA349BRe9WiXuLJYm6nrmAxxt/bYK8I3G
         HKdNRrLS7yWeUzwW5KTKsNR6EVhNZJseoEJeloalyJnj7HjXtBb+YIodHjYbkQp0NSl8
         wUZlhI8lSn9mdSuV/qi1HuLrlkc5ej24Ll0kKCAzFE8Se+I8RKtIFWHpLrmVCNe2/+Qi
         S8CrZydHGJXmynXOtc5z1meK9pO6f88ugr2hv0e182xTwDURUG/XKhjoUmYfX/B8aEOZ
         XdfHkVd988vIiezwFnprtAiUxZKZLeb6hMLeNH8kibbFwGfdsImfCG3JHPzX5ZYnl3z5
         W6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836365; x=1736441165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeDvGkxIoG2pQKa7PHtBx1HxqggtqDBJK5ahsNF77fc=;
        b=Ju3cOEhSLV7baxzO8IJGgvo0tRTs09tmuvcxkfH1uKYIIGp5Yslh8ofLAVnGCigaln
         J3iVlIrxAUcTxt7RV8qkJ8gWvZTP1SMSwgCPem9dVM5lL9+dUkpGI3bYvWa0imTZ8VRj
         sosN967LgbxFdaxwW0t6iHKOFW+i9Mutxk7sN9zzrXLZCaUlxNvpOVgMaOIqHypKCVek
         q7eOZNt16WjPWnqdKrKuqvSRjEaqJTOevIQNHk3fBsjByU+Gkn1ASNuoLlhD6TLrxcgh
         n6WGvnD4S7aXSrAgfAz5xzQMIlKxGWsGE8du+hSkPGKigf6zq2rJpdJ/7Ucu1cMfs3Dh
         0xTQ==
X-Gm-Message-State: AOJu0YyXy0BsQ5KDX4FJs3QTfykqyXNAKBaNldOo036wV2jphwqZDs0y
	jPkBQ8PC01GFf4pq6ghC+6NhpfQ3lPE72hk5aOruVsns4Q3WpiNjZB+X7g==
X-Gm-Gg: ASbGncvEkeNbGKy9LAbm/QBY3LrPG0yAaG8bFfda+EVkwyXFu0Nws5t66xEnDJwSJCE
	zNAlRbaDF3knQGCilJ0ZD8QbjtXTwHqdlWwz5DBcEg5ooU6h1Cy2kQUFuWXTDWgqmqei3uso8PC
	xawbiN7Ca5o93XbNxYwJ7M5nbugXJVtt+rvw3dfy7ELeY7WQ3xFHYdSMt4lfyRAsDGOyQjrF2EF
	/s5i1vr/pEPl+io6/rkq0LB0TNKzFZ/paHtP1RgIMHi56/Mp65N9WcANGmq9j2e5LgxKqOas3qn
	+0T0xfKHVyTODDo7oJiKlskxLcxLjNCPyMH7Abmpo8fEVoZ53bRnKORJ9UeTb6QvUJ/FMA==
X-Google-Smtp-Source: AGHT+IEi9WSUdQocLTMkARF2ziQEnyawHYcEjRuV0AjP8twKBNDZD3/BgzOeTCdp4dbvhfER9I2BYA==
X-Received: by 2002:a05:620a:650a:b0:7b6:6634:5a42 with SMTP id af79cd13be357-7b9ba79b290mr6575707985a.23.1735836365253;
        Thu, 02 Jan 2025 08:46:05 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.46.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:46:04 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 44/44] selinux: fix inode initialization when no namespace is initialized
Date: Thu,  2 Jan 2025 11:45:09 -0500
Message-Id: <20250102164509.25606-45-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit e8087cb36d3d2c6eab77 ("selinux: init inode from nearest
initialized namespace") wrongly assumed that there must be at least one
ancestor namespace that is initialized. In the case where the init
SELinux namespace was never initialized (i.e. no policy loaded on the
host), then this assumption can be false. Fix the logic to defer
initialization of the inode in that situation.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6c980f9117b..da8f76707c8c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1441,8 +1441,14 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	if (isec->sclass == SECCLASS_FILE)
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 
+	/*
+	 * Find an initialized state to use.
+	 */
+	while (state && !selinux_initialized(state))
+		state = state->parent;
+
 	sbsec = selinux_superblock(inode->i_sb);
-	if (!(sbsec->flags & SE_SBINITIALIZED)) {
+	if (!state || !(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
 		   server is ready to handle calls. */
@@ -1453,13 +1459,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		goto out_unlock;
 	}
 
-	/*
-	 * Find an initialized state to use; there must be at least
-	 * one or else the sbsec won't have been initialized.
-	 */
-	while (!selinux_initialized(state))
-		state = state->parent;
-
 	sclass = isec->sclass;
 	task_sid = isec->task_sid;
 	sid = isec->sid;
-- 
2.47.1

