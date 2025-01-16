Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126118FC8F;
	Thu, 16 Jan 2025 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057336; cv=none; b=F/046O41W3TMJK0lux4CPJlDQ1hOGqit/FW6QjqpvMo7msx0ZggSJ/2oQhAZs3CdBCyZDaGaOcAjjwZde8m6oX73u+43P2NRkowmgSrKxDZBnYsmM9Ft/JB6G5vCYBhQAmM61XeWOZY4EEwMIpcAtFS/JwO6X6dNyU2TkrHzdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057336; c=relaxed/simple;
	bh=dyRV/Tom+tDbX+C7Xad40mX0GjP/1YzX3fAenE+bTJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i0nE+wBqKUqgET3Qo5phQumgMQ3mpFwFY+H+VLupy8sXQzBjiDVwn+NnVGmO/7Z1yzxY1PziCaGqO/BJPuaSvrTZV9erUlEbZP2njj2iEMKXFjPY65zrSEWp1Wn/kos6iOakY3n8lXlSdfUReio0tsomU5Mn9Vw73gaQJcDsNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sfr06F/n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfr06F/n"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216401de828so23786235ad.3;
        Thu, 16 Jan 2025 11:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737057334; x=1737662134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxojJr/VObF6kXqu5nshWdLf7yDujw0TbB3CUodRBcc=;
        b=Sfr06F/nPPPGmpfkylsbKXahzBd/qdjSMiBJKNjkkVg3ETU996yU76M9aivriRRDLM
         XJ1VdO6mYuNGOqP4qPBQPunwkC/j2aeQtNYSicJFHySAdbtOe/cIegc5/dkD77v0gARj
         bXoMvB8T0w9FdlfgsXp7ci3+h8DROrcimam405mhvfw4035vVUZ3jd10h0KmQgAGEJni
         eu+AGeHU6PVQW8zFVCLTnQVljPDmInrizP9LPovdVxiRv/Eh2fBhXXV2+hb9JVTfUw6a
         pBZ9aDd/BbrHfF9U0d5d8kSNmKbmraav9u+/CwskPAs0tQyvgYMrhvZpdR9mBXT5EX7E
         xI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737057334; x=1737662134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxojJr/VObF6kXqu5nshWdLf7yDujw0TbB3CUodRBcc=;
        b=WNO5MlKkyqE/ir+NL6hksRsuHBdgFS2abyBn9VaGqQwK9Pwjnknb4sHpBo5pFFaXRt
         tzkzX8Vm1fWkuodQLMjixQIbVJrFkQfmDDzx5h12GJBYKGKwHUpOfsDFtQWtzaJrGbMY
         Up6GmK1KY78MWfOfYov0/yC1DelVsq738Z1+ctACNjc053gUzf9Ipp/nEL4sRi0Xmwqe
         yKu6EA0tBtNawWjuJNyMbAglzxGkVADFybcFI9ZZGQZRB3l/vej22B6vyO0qwqbj4liF
         ib+6tiO+Yy3bajYYyEMCwIHdxvrWrpF6qgwtYtCw3Dj/WU7cbW5lmFvRmsrKfvHvL/SY
         iGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6oCvsUp3KfQYBaR+AXaQz3XrqH9qLe2n6CqZtcBPGNYDswm8FMfiTh15++cakizg4zRrqqEnXxA==@vger.kernel.org, AJvYcCXIkiXNS3ky+YR9mYNwkVvys1TXne/1jCqXH7fYd9Wt/7m7D62u1rwMub3/McrISkDbRIUxswDvTFRE+Go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6NQjgANuF8sWkxa+DD7IAPrxl5o2ISlyGIYaFmGe4RHazSnN+
	4DKj1+vN4JCc3GQlbjm5wmJkdgJ/xJpPforwkyCNB+QTQX+i9U8d4JFaY1PGHu0=
X-Gm-Gg: ASbGncsJ/L3gy5VqYXWcyBmcCj9nqGuZfxK7MZgDokF+RFpN/+nICDi3CXQDq5wYfMI
	RKY0pLJe234MOzgpeu3s+s9oMYr6yvruzvoq/pIrBpcHGpAWF3G6BMZY0znij3P5TaNxcDJYJkp
	jWRGNmy1YtUXgAM9zQ+iU6r6vE0nNfNFFgMZ8K6jh7RfDBUhtw1sM8fvHk9E2wFC+wZ/oWhWF/C
	Rj3j7kE/8VFlTn2NiR/MEmedhLjGqQAw0XFqRjPkaDaNeBHz/EXQg==
X-Google-Smtp-Source: AGHT+IGymoW4dbss59UHu9fiOysoxBA+UJpqMJRU86LsjLLKEMM7T02A0lFgB2NnXZEMHrLPAjFgVA==
X-Received: by 2002:a17:902:db0a:b0:216:2426:7666 with SMTP id d9443c01a7336-21c352ec44bmr191635ad.12.1737057334271;
        Thu, 16 Jan 2025 11:55:34 -0800 (PST)
Received: from s2lab02.. ([114.70.9.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77629ac0dsm546392a91.34.2025.01.16.11.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:55:34 -0800 (PST)
From: Ingyu Jang <ingyujang25@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: Ingyu Jang <ingyujang25@gmail.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: Handle NULL return from selinux_inode in inode_security_rcu
Date: Fri, 17 Jan 2025 04:55:25 +0900
Message-Id: <20250116195526.2303758-1-ingyujang25@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'selinux_inode' function may return NULL if 'inode->i_security' is
uninitialized or if 'inode->i_security' is NULL.
Previously, this scenario was not explicitly handled in
'inode_security_rcu', which might lead to NULL Pointer dereference.

This patch modifies 'inode_security_rcu' to call 'selinux_inode' and
check its return value.
If 'selinux_inode' returns NULL, '-EACCES' is returned to ensure
consistent error handling.

Furthermore, analysis confirmed that all current usages of
'inode_security_rcu' check the return value using 'IS_ERR', ensuring
compatibility with this change.

Signed-off-by: Ingyu Jang <ingyujang25@gmail.com>
---
 security/selinux/hooks.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 171dd7fceac5..61c9191bafbe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -310,11 +310,17 @@ static struct inode_security_struct *inode_security_novalidate(struct inode *ino
 static struct inode_security_struct *inode_security_rcu(struct inode *inode, bool rcu)
 {
 	int error;
+	struct inode_security_struct *isec;
 
 	error = __inode_security_revalidate(inode, NULL, !rcu);
 	if (error)
 		return ERR_PTR(error);
-	return selinux_inode(inode);
+
+	isec = selinux_inode(inode);
+	if (!isec)
+		return ERR_PTR(-EACCES);
+
+	return isec;
 }
 
 /*
-- 
2.34.1

