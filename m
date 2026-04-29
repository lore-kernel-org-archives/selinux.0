Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021F32B99F
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486550; cv=none; b=LVDcxvgy4U6mAUxO7GwK/UulW/Vi4CKYlFB4gzm297/JzUgVtIKozkR5OR0jpundBzxG0Jad4cRNORRESyHARJZ3rwpoWUcPNRkyzOxJ6nRipMx/tw1gQWr051F/kaTjdGA940b/radLer4/jjf3xhl2t5y6UTrqMgVMlN7oJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486550; c=relaxed/simple;
	bh=BORdBJgbSWP2X4DMd9AkTdiDjgd//uH7HsxXKAT/gIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuDvQ7Yom2jSKce8zukxREWYfJIigjabvQH5czDcCBMV5jRy5ACHCK1TK2UrW8HYwt3K7M9JysUKRMcyvqerTcenF7SrlKd1SaBR2yXuVg26d6aaWvbaO6ZzFJFnU/WmpLsLE/e0163iDQrAub4GiRRVnSky5rG14+jLYMicfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnQ/hqLn; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnQ/hqLn"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ac9ef74131so1539196d6.1
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777486547; x=1778091347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DGr6v6JxvcZ8xbgMfrwNnEcKGgItmheS7RNVdkfQIE=;
        b=VnQ/hqLnUGsRJZ/qLZ9XkpBxFe/8gmV405uBsM7zoekuNmIZ2kj6jMXGP6vbOHJeyI
         H61Sn7Dw0WeYCHRfU/vBrxX7rCkMheEqciaSNNCaADX980HFaZVsrX2i5RZSn92x4eRA
         5Q68hOr4ghTu0Sh3/Yxz6vy8zytFwckkBPlHJxnpFNc09fWRNfkPWboVhiVD9kD2g0sI
         FaMD74zioPTGZji61YgGfjLV6j8L1jNg4IGcTWVrFLTE3lizBKvIz59MHvO23OzfRKKV
         yW9FJa7B33ody1sU0/cBs0L7+ArRSdr9ZBjKQO8YoOysYog/ZlAlRFmR1Ax2+wZdQK65
         +Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486547; x=1778091347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DGr6v6JxvcZ8xbgMfrwNnEcKGgItmheS7RNVdkfQIE=;
        b=YGQBFLO+R5OTzcgtqRyrV9P2kOPKeg+OkaJHH9b5qxrNwTV6RH2CJY44xj/0N9e2wM
         GeDQnyA4EmgOglYnULCFLHd1dDQJIF+ItB6zlPSAFRW8lFc24oQz2qgXktifj61GdgyO
         zAHdXdeBxpvzEzdRlVvLEIOgA1QJwUGDJccXGNCYG+XPMiLb227t9zp/3Jbh3p0Zeqz2
         cjIJuuFwHU60RwxTsHmZwcAmdoYmpRH0spRFnALcvLoNBsDTyJEaytWvOGV07+9Tq04t
         VnH3aM0nQB23L7Dw9y2zFFgx8YpwZdZ58QXxeHNhvqS0uNLOnNIWY1+b6CBys+ESU82c
         wPeg==
X-Gm-Message-State: AOJu0Yy1jfJT6M28+pe1h70up/SBVvmdR4G3ceWkYE5OQl16/N+awgTw
	7sEGGX3BIow3sylC1cAf8XUBhOSjrdDr8ULFPwE+R1bsifYEnuHkaohPflgAoA==
X-Gm-Gg: AeBDiev3iNEn2cGHNrrwXzPkOSi8725MQj9hqBIc2OrWukvStu6/b36LEwjRtHvXIyt
	LWSmVEOIzF6dcBvGSOYQ6N/m6nN7Dkczmu10Yg2KaA2Cycvr2tnLLPZHVBrTiYGoEFAO/bH70B/
	EabryzvXb0TxUb+rA+n9dHDRIhLrcEWqQPHfIUa6Bo80f+NwLMhaQQnxArT7c2QwMVbS4Mq0Nma
	74O+4dkT7VwxSlm13io2LbyYwAuLODB2KsdHmOWfrZTK/Lxxg11geJLslQdVz6O029yZkFfshLZ
	ih3ICChHIZBOf1l2RhbUP5HbD3NUMXsilWJBGO4gmE6duQAGW7AAuagVTneMsCf6Wg2pFYkoNUR
	i+OlRp2+8O5ntEr+GXzNUx36KTvVzYABBthNFcK3Z6G9v48LYROzAca5m+UyW0Ulj9q/UV/znH3
	iGpCqj94cJ0dXNdk4auSJCIQqoEftTEZ9a9LBy90vfRXnfHtM55dqQP7iKBTg7TCKCRd9T6Oyrt
	ikRYxPXbXtxY7k9/TnUFIBVl1QQuYLHlzbKGft3mEbcsEui86iEAxlxpa0Gqh42Fw==
X-Received: by 2002:ad4:5cad:0:b0:8ac:a546:775f with SMTP id 6a1803df08f44-8b3e2faca57mr134023046d6.1.1777486547639;
        Wed, 29 Apr 2026 11:15:47 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ef70b10asm24771576d6.13.2026.04.29.11.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 11:15:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: fix sel_kill_sb()
Date: Wed, 29 Apr 2026 14:15:31 -0400
Message-ID: <20260429181531.5566-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the order in sel_kill_sb() to match other pseudo filesystems.
This does not currently matter for selinuxfs per se but could
in the future, e.g. with SELinux namespaces and multiple selinuxfs
instances.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 8c107af5140e..c4a68d623d40 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -95,9 +95,8 @@ static int selinux_fs_info_create(struct super_block *sb)
 	return 0;
 }
 
-static void selinux_fs_info_free(struct super_block *sb)
+static void selinux_fs_info_free(struct selinux_fs_info *fsi)
 {
-	struct selinux_fs_info *fsi = sb->s_fs_info;
 	unsigned int i;
 
 	if (fsi) {
@@ -106,8 +105,7 @@ static void selinux_fs_info_free(struct super_block *sb)
 		kfree(fsi->bool_pending_names);
 		kfree(fsi->bool_pending_values);
 	}
-	kfree(sb->s_fs_info);
-	sb->s_fs_info = NULL;
+	kfree(fsi);
 }
 
 #define SEL_INITCON_INO_OFFSET		0x01000000
@@ -2093,8 +2091,10 @@ static int sel_init_fs_context(struct fs_context *fc)
 
 static void sel_kill_sb(struct super_block *sb)
 {
-	selinux_fs_info_free(sb);
+	struct selinux_fs_info *fsi = sb->s_fs_info;
+
 	kill_anon_super(sb);
+	selinux_fs_info_free(fsi);
 }
 
 static struct file_system_type sel_fs_type = {
-- 
2.54.0

