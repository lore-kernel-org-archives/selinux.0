Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D1193430;
	Mon, 16 Dec 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367295; cv=none; b=MoRNEb2Hb5QaPslbmZMtOWE4Sk7JqhUah//VZaiM2V4+1nyrVgV4dUjODFkvMD0cZTiQbnzOVb/6/iEDK/Vz7fT/4pAnXg1GDr18tMdFnIDMitaMf9ZxICi4XJ1w1KhsrZj/nTb8zfND5fS6DbuOd68jDCsFlfhy0PMpF02+Z1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367295; c=relaxed/simple;
	bh=LzsFpOls8oXtgcc/LvXjxf3PJjqQkyOjKQSP/0EcyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiRxIz+W7OQqD7cd+6DMJRHeduVCmEyKgKSysREEYgcncfLb87WXpmsr4OmVsJ//E1F8107DLhuR1Z4I9Jrj09sl2G69fPWhFt7CJ/PNqUD1FYcwiaeXCbONaMMCmhyY/Oe5mn7ka2jDhu1XmKmLiQhx3lzx7a6ET8ro2LYJy4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=GmBH3LoD; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="GmBH3LoD"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367285;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4k4ZF75QAu6g5n+iQVxb/sSwhil14zmDfkFwEEcBxjs=;
	b=GmBH3LoDTtK/VWa31laPQErpC4e8J3goHHaekNxnEThLfGyr9amANp6lmEbZmY59wuqG+w
	JbAiSrBwpvZ6hgBSU30OKYLV7PsHAl5RcHlnqBQQj6Sb3SG0t0fZldqjaRVccqe2vZcM97
	JPhBzLS8yv6qsrCQamP6MMgkuad3EXHKIcL7bBSPm8zmBQMzsgQxOXMagFbO9oPYcsVvr9
	zhKYdTPnqexlglq+AAc2GgMOi8LZnpVXy2Uf2eA5Qzdb88MXhzCs/x0fPbzwtWMXV+FSDV
	ZkIwtZb01mmPQaaOlk/mF3jovAiy50TDo5Fb0cVALOluizO2Ad0jt5VOHO/Unw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [RFC PATCH v2 02/22] selinux: avoid using types indicating user space interaction
Date: Mon, 16 Dec 2024 17:40:00 +0100
Message-ID: <20241216164055.96267-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-1-cgoettsche@seltendoof.de>
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Integer types starting with a double underscore, like __u32, are
intended for usage of variables interacting with user-space.

Just use the plain variant.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c       | 2 +-
 security/selinux/ss/policydb.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 617f54abb640..7b2e2c60f0f4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3135,7 +3135,7 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const struct cred *cred = current_cred();
 	struct inode *inode = d_backing_inode(dentry);
 	unsigned int ia_valid = iattr->ia_valid;
-	__u32 av = FILE__WRITE;
+	u32 av = FILE__WRITE;
 
 	/* ATTR_FORCE is just used for ATTR_KILL_S[UG]ID. */
 	if (ia_valid & ATTR_FORCE) {
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 4bba386264a3..5c11069121d3 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -144,7 +144,7 @@ struct range_trans {
 
 /* Boolean data type */
 struct cond_bool_datum {
-	__u32 value; /* internal type value */
+	u32 value; /* internal type value */
 	int state;
 };
 
-- 
2.45.2

