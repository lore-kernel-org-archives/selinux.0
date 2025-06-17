Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AB2F2C6D;
	Tue, 17 Jun 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169217; cv=none; b=dFEISA597s4evIaOK1HpLuKeM8x4BfjYSQM8c8w3jzbpik4VEtsy/ZkBjj9zj25sy/qpiu1QD4gRAHt8/mkCEMqBGdWmEo0u0b1u2DKMveEglGIgbZ6CnSXOIAeJT2yEuLf/5H4DFTh3Yr60+Jt1UIXOJ4t/wNqXVsPTTeK7PqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169217; c=relaxed/simple;
	bh=wJeCwvnxR0akDbjsgWbBIu+zJ2mAf7ILcxwg1+5cb7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6ZAT/IKbL5CN9sR6cTL6JcqrisNaw96g4QlA14BOVYHuRUzQZQLWaDZDCp9ZLDDGRCY7vq+D3beiBuc6u1POAkEoI6tMql45h4/LAhUk6aYpWttAsuY+3Oe4B7zhv+RshvgpBDQzZeeL7a3gQ+c1YEIV59hJlITVUcV2YQWKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlMxPyoO; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlMxPyoO"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d38cfa9773so603313085a.2;
        Tue, 17 Jun 2025 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169215; x=1750774015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVXA4/+o8NIIYgdkwwL7LcDduG8Jjeb8rwglNYmZSQg=;
        b=SlMxPyoOJ9m1pLF6JuQVse9tjdsYxIatdAcVWS9maexq8t6dFzEagrwoWpof8hejpJ
         GuPa+fJ82FOAuvOhKgg+msz9rYdm6T7jPvsXtnPLgKteTuF3SYqUn23zoHgZVlNn3CIx
         o8CprDN7lzfL7eTPYQHBufBx8TOpIxoOHrEwzOD8amLxNNGxZ6VYbZvEtwGzaMqLGVFw
         kdD99nehSLVk0ga63f1scd4zi65Fx40yL5vG6FqnhVZIIy2OlGStG/HQ7hax2Voln5wk
         2bySO5m9Jwz1TXxPMG+8E8wWU25qPeNEg9MW4z+SNBYE/6l63ottGo70mJqT+D+xogis
         TnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169215; x=1750774015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVXA4/+o8NIIYgdkwwL7LcDduG8Jjeb8rwglNYmZSQg=;
        b=M0vdVLMiuLhvnVCNmI+IAxVC6+4cRbXBn/HQomY/JYQWJZ08MSXPac+gHYRAgWETXg
         JIpqYNAtEsa5yRI0xuqN0mUTfc/L0afEVNxCr/lnMAvxtaciGepGQycrY8qZN4dr/RNj
         7NTZl5redIHEhcPwX2bG92WGeynjqlFwuR6sba/cIVDhKGKX4ckGlvx5sk7qCKvDgaCH
         iy9QzFHu8xEICJYCJ8PGTj+bYXoPzGg+6IhBCrmDKBE6OyoxZaJaQzlZieDxqJhXLlOA
         zwrM2AERDomzWU3VSMT+bJygA18oel567piNomgYtl8I28H1DC06/oxmb3fJCwLUKa4g
         jx/g==
X-Forwarded-Encrypted: i=1; AJvYcCUGpGjLzARZiaxdcJUswrTbICp+MFrsUgLqS5ge6x4+6knoOWct7BGNKsAX890YFdrEUWzgI90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwtCRoScWrWlWlIflkDCPDwekpR1c45TUgGna6V+uiyhTyll7
	MZ9AuybViwWE3qIaNq63+c1Zrml6X7Gb5kCiLYHt4iSFxgjSvn+XENUqMepT/w==
X-Gm-Gg: ASbGncsu1sCkthGWaczGsiAapjDo9Fkr2iSUBtpoc9bv0MeRUP+DcH1KrbT/Ps4JxOU
	AvXybPPBkhdhSZvGiu+jv8y99Y29S05N9LckcTT7yCPiHm2vs0s1M5JMbCIAeAWRryJZ80PryQ8
	sE0miclBJZbTBIexlqYP8wdT8UC5d8dY1qGK14yOGJ11AWN0BZBNJ3/fBwo7X9fbOP38UGwBqHh
	O1CHxx4VWg3URF3UCaDSzY0aV6/7UBvSIycIg9x9H3I+IWljgDV0UI+gHc1m00gfdrKnIcMqnpf
	dP15VwQ82rMBDWilDWK8qxhgvAeq3fdvHLsc8GBuJwk3P2G8mf90JKbsJHhl16ddvHtABYgHgsz
	G9x8J4xq085p+VWN04dgTpSzqcS39woKYFkcipsw48q5UM42xiobaeDrGt/IZRrWi8Q==
X-Google-Smtp-Source: AGHT+IGuATyirItbSBeXn//Et35c9lxPfDqn1yy5oruN8MRk2lOhfMJctvkjpsC4MF92rPRBf58NCQ==
X-Received: by 2002:a05:620a:3912:b0:7cf:a26d:5085 with SMTP id af79cd13be357-7d3c6c1e137mr2346358485a.15.1750169214649;
        Tue, 17 Jun 2025 07:06:54 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 41/42] selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
Date: Tue, 17 Jun 2025 10:05:28 -0400
Message-ID: <20250617140531.2036-42-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
index 5f27d2932e4b..7923ce5e6a4d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6273,9 +6273,9 @@ static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_t
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

