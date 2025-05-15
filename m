Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C729A310
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314665; cv=none; b=ZqPnB5fHJCeMtaXTOIzbPcKLD1ryvA6C4CGojYLvxE7Cv3vlpela/QUeaN1vAh3fr1vvbTploqDEZp2hfsAHaYaUH4FVR3U4HGpgSRQldB20LzdrxWPPOncFTeboVwaTDRhsf1328ZGCLy/fks5YVIIRwOnfsz41Vvh197fJqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314665; c=relaxed/simple;
	bh=MZikWshpkzszeHKMwrOX7MWr/ZNlkMGey2Hv0N7+5zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHbO9P3ZWLyeE4/oXKrQQ3e8D2Wo0O/JAeHkdDvy0UzShyorutxHvnF7x5pWJ+d5pvazaE4ypcppl7HcIzSUlybzK8r+ihTxxrGhcwuaGjLCEX/U1QaCtbOKb2Muf+gihWX+14xpqZA6+RNKZfCVBU/telpMe3gE0u4bWmf0iEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZolfgFHs; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZolfgFHs"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4ddb9d80bffso640112137.0
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314663; x=1747919463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQykNmSfG4kUMJ1LRpZp5PW+TIpoPyIWLRG4xoNzP9Q=;
        b=ZolfgFHsOly3YQdV0SXq3nN06fJUyvwwlrMHrK0yT94vSZEGyJgFPjoM5Wpyx3DXq+
         xBMkFHEztcHu3SVugsDww2/4ao9x6+dbV9Jj6KJZLpYZe2Qw0HwZV5iwkLpRVpO3ZPn/
         yaXSPJXK/KcoO1qFwOA8UKA0HZW62EEt9H7Eh/4pW7am6xW0o3DRNK+R0SlK83XsIm8b
         jaP61ei+EfpnuTmPRoU7NCPKdlzAHdvJxFNzLxXDPZi1Fjp4dhQk6HpzszF9QAkQiPZq
         lAHE2PbKaVt5YhngXbEgJpFqUH6xYEnVf4xR0BS1FjtO5wbQWxA5stwWrvGsuJMgk73P
         /5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314663; x=1747919463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQykNmSfG4kUMJ1LRpZp5PW+TIpoPyIWLRG4xoNzP9Q=;
        b=PY8azSY1IFyDp9dNobswigbbz1nR5lJmlvEq2M7x6cAG37R5f8Ap4DR1OQBgY7Ltcg
         xhlRmoLOsLQ5xb8MbB6ulEvUEs9x7ncBw+jasv9XBPJvgtjC1YV1BbannmXk3JLe47xw
         mfPI/r0lheNTfuMcpYm6bc1kqdMPHOI260iFt28fpLhqw9FtVFn0PL9MRgdNY1UvcCo0
         V/wKwEdniqf25gID8mIPlQ9KqmnV5i+RsvEzPS/umccKsfQedQ8MVaqTqaxI4GFHEmzN
         fdoJBUlDe8WiiqK/YIMA3fQ++ZFbkQSTi1E/yATcsJL+l92H5bDOQm5GcluMyTlIK8J6
         jLbQ==
X-Gm-Message-State: AOJu0Yz+l4VHdMxU0XERE0UsAh1vUTIOCkfz6Hr0ve6Qiu13na/ysB8i
	OVDRWM7434kN1XdHq6X6sCnKv+B1h1HGeBOl2cBECDzzKosp9H08ul1T1Twmfw==
X-Gm-Gg: ASbGncvpmGJAUDHpABcRrJ0fv/ucZa75Axzd+s2XxeIUEx3az8e5PUPoQka8iNkM+nl
	MkvmpLMipsk62JErZKhreaP8wumnHgd8dz2Pa+RwOLfWVe9L5YhtsXbpAGD3506HVmiRNiSl5kv
	jc+Pp7WHdyEZXw3nGMZwls9lKlk9kbtsViiWQ65IzbeN6mXo9Let0seXYsFW24Vmx6ctVCUKCLa
	cz6+RA8bwG+CnRemzi/OhqWg6Ix9j4emhvWXMg1067x0r9e61n3oMEmhM51vSZCGXslgXE5CF15
	Xu+MEI9kSBf1B1Hk+Y1R9py0sO/5D8/Q6fDnFHfuenr2qUeLwVJIohc4dEjGPO92cc5OlYGc58z
	IGty8up1jCIxOeymNZSWl9DbiohZSfvAo6Qe52QqK+vnsikT4O7GVCA==
X-Google-Smtp-Source: AGHT+IGpZHKEbdJHO1976w7An1D0jTWYgUwJo3zzeNkGq5Zb0BxPFcjQ29MCvaN7WVZ/51mrbeCxoQ==
X-Received: by 2002:a05:6214:acb:b0:6f5:1064:edcc with SMTP id 6a1803df08f44-6f8a3210c45mr55200456d6.18.1747314652747;
        Thu, 15 May 2025 06:10:52 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 46/49] selinux: acquire/release SELinux state properly in socket hooks
Date: Thu, 15 May 2025 09:09:44 -0400
Message-ID: <20250515130947.52806-47-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several SELinux socket hook functions were not properly accounting
for the release of any previously set SELinux state and acquiring
the reference to the new SELinux state if the state differed.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 113242c4cb87..a9b5879cdd62 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5606,7 +5606,10 @@ static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 	newsksec->sid = sksec->sid;
 	newsksec->peer_sid = sksec->peer_sid;
 	newsksec->sclass = sksec->sclass;
-	newsksec->state = get_selinux_state(sksec->state);
+	if (newsksec->state != sksec->state) {
+		put_selinux_state(newsksec->state);
+		newsksec->state = get_selinux_state(sksec->state);
+	}
 
 	selinux_netlbl_sk_security_reset(newsksec);
 }
@@ -5845,7 +5848,10 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
 	newsksec->sid = asoc->secid;
 	newsksec->peer_sid = asoc->peer_secid;
 	newsksec->sclass = sksec->sclass;
-	newsksec->state = sksec->state;
+	if (newsksec->state != sksec->state) {
+		put_selinux_state(newsksec->state);
+		newsksec->state = get_selinux_state(sksec->state);
+	}
 	selinux_netlbl_sctp_sk_clone(sk, newsk);
 }
 
@@ -5856,7 +5862,10 @@ static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 
 	ssksec->sclass = sksec->sclass;
 	ssksec->sid = sksec->sid;
-	ssksec->state = sksec->state;
+	if (ssksec->state != sksec->state) {
+		put_selinux_state(ssksec->state);
+		ssksec->state = get_selinux_state(sksec->state);
+	}
 
 	/* replace the existing subflow label deleting the existing one
 	 * and re-recreating a new label using the updated context
-- 
2.49.0

