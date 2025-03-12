Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1B1F03E1
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814580; cv=none; b=iimCSLCwh/5F+vIcXruokf64LikxZo2674XaLZa3d6g8XQSZigTSU6VVRKkdhniplD+cMFxnsgec+Aqs4coRtk3ds05U4J8VFlfVAFMg+CxvdPDolMxR4R7c3E4sibxQJ92UuSj1cO5SCRwF2gie09625HOMlsNX7PyeSgd30bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814580; c=relaxed/simple;
	bh=UQi4jGJd9JPX9q54M13Eyu1joQsCWppMerqI6/F5Zeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhMwTi0F6F8Y4KJsLZefiw4rhx5Z4a7VrSb8ogqmjsxXy+Jss9fBJKWjVI/nYxiviq+jbmZYnh0dIqwKWnHVxxJXOj3UFNRfSl/uGgQ1GbhTvO7ROw1T7uiCb4PJyXpfED4E2OXbxqJurYnStyrYcDyt8D/qIrJhGYHL5MXNVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sCFyKZak; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sCFyKZak"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4F4883F6FD
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814573;
	bh=vkBChevR2KYwwFZBDZ6M820pfzcyPKZb2PO3mstNSrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=sCFyKZakaUftWxs9QToSa2iYDRjmwymogEnh5bqNk+TcutGHQj9F0evcRwByZfnif
	 mzfGT37QLIhi9GxW0NLVMtPvVL8i/4N1Z11S0gz3Am+a+fAkqQFRcweqS6j45bU4Ps
	 di9NaLEzCZUIPwau/tK1oxZg1naxvstlzn9m0EtpyabpVX0+7NiMlEoRJppbuDrUrZ
	 TbAimvT/OXzsfPIaIbjkJMa3Q18gbvrYKrjQ3Qgj67zWju3huasfBqTn4n75QcTCPB
	 EEgl958EFmTLiUBE5PCwCT2Ve49CRgm6WRLWa80uv8GJk3b4Bj5dvMk0kBsdiq20pi
	 dBXKQP0ViouSg==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so714039a91.3
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 14:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814571; x=1742419371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkBChevR2KYwwFZBDZ6M820pfzcyPKZb2PO3mstNSrA=;
        b=W3DK2Mn7QdjtX5B1za/xwPmOGppzF0pe6A56179eZQfftw+9TgKLtN1RIdT2tQfiHg
         YLXfAwxBs1nL9VEaa7oEeDlTZRThTtqkz+Cj/I6RbLQ6Ivvw34T6KJPEjgVkL1eb/7I9
         ffdfANplwYHZlwzz3rdE1qsnwFzgHSd/VTL1iUxUOmVvQiT2WdHSRvGYon9Rp9TQw+JL
         Dxl6SCgNAnaJWUlHDHLqyBcf/7kEICqhPjPdua50IsOsqIZA/+lJsPw2PtcU7vArjHo2
         ahjJPzeskSSWVh1p4nETl7+s+1i5n91ze3Hgdi86FuZBagkjPelSTrgZefdZKscy3PjB
         +mMA==
X-Forwarded-Encrypted: i=1; AJvYcCWoMuQcv+bExlQcq4PzuisHyUVYVtwjcqgx2l4vqRqea8Ek0SmS3Ymdwqfm8DH5hXOMZcCKc3uF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+qsW2s0aWHLiCRJF3rJYbKq8/JfvkHrLlOP5xPCCVr/Y97TFJ
	FFToOgy7ongdE5/UsTNC9jQ7en4XrxI7bUcrS4dmIPa8OgWZ+ct2+yN8IA9AopvJStr+Cjw4bLb
	+/HcjEb0RIQghd7cMbw2FwTE+al5mzJBqFpaqPd2iFtQlXw1x2s0B2fn3s6kTd+BIqR6OUjs=
X-Gm-Gg: ASbGncsuE5q/bW7VPSURGw6O5HduXy/VAWObDsPsusxRKFElvxCpQ0e+4UGpoqs+sR6
	keWvztdIuf1qm9kKF8N/7gXUqU6cwAz9MEEnAifnLvjGAowaT46Igc20KvcHuuzxmERl1+HtcFr
	0Q79/7mQRFesp52fLuUK6j+J71sooVYtbmzPLkcTuUA70U6ltiSuwFWUGYLJIciG7incbW4tnwz
	cL6FatRKikqwW1OuZjAL0U420m7PzAMluBrG6Mosy7wbjNa9q22IsTW8bl2yoxQvW5A8k0jWGZU
	l5Zxh+ARlA02B67Tz/Yl25Nk1x7GyztdJCIUf807O/jaG88snt/MsxLaxDgpbocXAngE6IY=
X-Received: by 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2ff7cef76acmr32847531a91.28.1741814570803;
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2zy2F9PoKbQMeK6fUS3X/Yt717KlC839Q5G4xkP4Nr8/wnDbMYJ8pDxU6TgdAPfQxzzejkA==
X-Received: by 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2ff7cef76acmr32847501a91.28.1741814570519;
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
From: Ryan Lee <ryan.lee@canonical.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 4/6] selinux: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:44 -0700
Message-ID: <20250312212148.274205-5-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312212148.274205-1-ryan.lee@canonical.com>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that O_PATH fds are being passed to the file_open hook,
unconditionally skip mediation of them to preserve existing behavior.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/selinux/hooks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 07f71e6c2660..886ee9381507 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4009,6 +4009,11 @@ static int selinux_file_open(struct file *file)
 	 */
 	fsec->isid = isec->sid;
 	fsec->pseqno = avc_policy_seqno();
+
+	/* Preserve the behavior of O_PATH fd creation not being mediated */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	/*
 	 * Since the inode label or policy seqno may have changed
 	 * between the selinux_inode_permission check and the saving
-- 
2.43.0

base-kernel: v6.14-rc6
