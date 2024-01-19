Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B63C0A
	for <selinux@vger.kernel.org>; Fri, 19 Jan 2024 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628672; cv=none; b=bGEaOq4A0sjHokQgjDGg+w73njcgWS6CVLvK3Fu7Gfz/gUbA5Cgpu+4XYiJppTEdkEPM/OUMwNG88DDlGZN4G+2xD6i2/xKt93rx1CYuCwU6koaGZAskCVFqIR5hWi2mOJkRBs24sPhwSO5DEeq1rAYVwiIQ3Dm6vPIPce7CZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628672; c=relaxed/simple;
	bh=dafkt+s6AyqOSGKObwrHu4csGb78zSxZ6FgYDMk7K3s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uE+haFB6LdjXHybrn6hNP73cYinQIzkXdi86VJ1+628ao/zvYCPjty+nRdWD/zd4EOr54ymZ290obtP22bVNiDMOAbqXW91cXihqqIsoBhjgzDMoKKQCIY1wRI37uhtv3Sjz99lV0iuqn0VEm7FouFRk0/4TJ0idS6ubIRe5agI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cLuHSD1x; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cLuHSD1x"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78315243c11so18076285a.3
        for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 17:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1705628668; x=1706233468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9xOnEKsKi/rbVPtxuwDnhYC79t5v2NLFauaiizHUlE=;
        b=cLuHSD1xgii1WjbMyxxuowQJz6JcRzKbqpis9jnv5AQjISEz1gSmbDkXowQIxmzcOn
         11C/h/9Gmxzlg9g/7d4C8SpTrKrI52oak9TXgCVNzqryQ7g3Y0GWBFFvN1yLJqsmGFjC
         KJJJqv8UdqQYsF3XO01N4fiTkrwM5mpKkqKKiqBg1zfam6tAUd2HjYRQWY2gr//WEsaz
         nXDbnvspLsCinXbEqP35x8u9I3E3j8luO9Smw+Bp3O+/Gjn6jLEMljIrIEXSxAOKZrk9
         YzLvV9nN1M/DFp9WoQzBoT9QhdL2iyLwO86Hc+Os7+uhsFLS/vAil4yxh2UUkcSsogra
         ljtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705628668; x=1706233468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9xOnEKsKi/rbVPtxuwDnhYC79t5v2NLFauaiizHUlE=;
        b=AbulMqj+O/oEhKDFnp6S1DDTxKp3OSPm1fQ+jRs4V485UdT3HlIqDPPBW/KtEB/fC+
         kpU9nnk8OkBAUH8yceksgz5j2R20SA5ZWgLS0zUrE+FlVH3vnSs9VYn/I6R0krd+lwWB
         ceLyGlu8PWKS54xkl+AGjUbQJTfnwYUPUYbojUggSOQrlnHIMwNgdFyrPJ631jNLC+G6
         Tl9HqOSUSxQkbsTNFu5FQf1M+4FqjlGisDvo0GSBgjBRKnBiLR2nkkqNffoxO5dAdh+m
         OpKNkbSGW75OMwjvcNTHQd5EO4rUBFrZfxqTYJpq3mfv51FGXnYQAx8UwYS6xt0WvCFe
         tE2g==
X-Gm-Message-State: AOJu0YyAAjtV0sGt0SS0w+4AY7TYQGTrLCvv8y42sbi/aiwKBc06F7QO
	6oYAVBzO7PGEtvMTSI6hinpV5vT/QJPrpmbQ3ip6mskTGiAmsqfGCq7ojOSeBCWKN/6Bwa9loIU
	=
X-Google-Smtp-Source: AGHT+IER/63lMsBF5M9oNZp+D0y3iJrzlddrY3yftayB04+XnrcG4nLqfSYGEVF95YV9IoRxSsA+Vw==
X-Received: by 2002:a05:6214:5013:b0:680:b44c:1a01 with SMTP id jo19-20020a056214501300b00680b44c1a01mr1705111qvb.116.1705628667841;
        Thu, 18 Jan 2024 17:44:27 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id qq3-20020a0562142c0300b0068199548937sm590681qvb.28.2024.01.18.17.44.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:44:27 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: reduce the object class calculations at inode init time
Date: Thu, 18 Jan 2024 20:44:21 -0500
Message-ID: <20240119014420.493814-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=paul@paul-moore.com; h=from:subject; bh=dafkt+s6AyqOSGKObwrHu4csGb78zSxZ6FgYDMk7K3s=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlqdP0gkaMbLMTM6zCBi1m7Ojl5uyLlzPlyRpBE 3wpu3RL+BaJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZanT9AAKCRDqIPLalzeJ c+QuD/41eqCFKyDCm5MswjrxrHBxdLTuduFmtRxkBbOIAfD3xC317nN4E28hExvHZb3z92D6pDo XQBR7E9dm2SbJnrANHuJ438DeebpUQnUncYCVLY7eizsbievks6NDCW+jn7sh9Np9oApnCfZLPp a2tpDetwailOh8fioS7KojLrlSUTm0Yo+vHLVkFuEBwAUaZI29/hiFW7xHG0dTcu80w5zR//+7r Iksq7NQ3eaLxyOCsDCrarEiix6IpWXhvqZ8wCFTSwJn54X+3jzS/A7NsU9g7eIRMKiWoQuVeHZN iiZ/Qhhioz1XS4D0Tq1W5KAwAuAYDitRGncDvFLTFKaYhzmeS6cuMJBF04teivw/k9GZZX1KZ1f xZDHnrPG+tc2LMhfMmQ2bXJV3vZ1Glp0rQIcmpCDwHKte3t0LfdDKFrKb3H79zdySjHv9MTNVBp Enj+kvszIBJl3BZKUb9FbtJtX9/OZSiOy1kKrGFM4poyGU9eR2roQdyruGXC9tIbqhJ798aD87P 7SF2JNzcYVHCdY2CcEAioTf36kqw8ZCmuqmtcPOe0nvp+lr0IJ2D+DWoiyduZSWlnItE78ZhrFj VfkFRuRaynHwqpJP4K4VYrXgIXPq0org+aqDl2Vcdt1Zwuek9KpjE0klDjb4lOxzS0HiIKICYjj TmUeI+/QRAGdD3A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

We only need to call inode_mode_to_security_class() once in
selinux_inode_init_security().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7c69ce62c106..9e59f9c80ca8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2920,23 +2920,22 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	struct superblock_security_struct *sbsec;
 	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	u32 newsid, clen;
+	u16 newsclass;
 	int rc;
 	char *context;
 
 	sbsec = selinux_superblock(dir->i_sb);
 
 	newsid = tsec->create_sid;
-
-	rc = selinux_determine_inode_label(tsec, dir, qstr,
-		inode_mode_to_security_class(inode->i_mode),
-		&newsid);
+	newsclass = inode_mode_to_security_class(inode->i_mode);
+	rc = selinux_determine_inode_label(tsec, dir, qstr, newsclass, &newsid);
 	if (rc)
 		return rc;
 
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
 		struct inode_security_struct *isec = selinux_inode(inode);
-		isec->sclass = inode_mode_to_security_class(inode->i_mode);
+		isec->sclass = newsclass;
 		isec->sid = newsid;
 		isec->initialized = LABEL_INITIALIZED;
 	}
-- 
2.43.0

