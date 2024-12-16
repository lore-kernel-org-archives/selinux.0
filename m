Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739231482E1;
	Mon, 16 Dec 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367296; cv=none; b=hkYEA8ulYco4r+JW0Y30Mh1AKibd6I7pu2JF3AfIGEXUXLEI3spFzZVqPOdYc5zv7kYsYs+FJcPnnrVWHzbTJeWFerDuNMLEWGjirymE8SX99d1YQ1Gt33pjtCx3v81G+XJWXojcjoSo++ZacHL3038FGnN97doc4W2Ptz5uX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367296; c=relaxed/simple;
	bh=1m+nvSgHvdaEYj/voNaUnE4+rGXqHl0HcieaOtLwgFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y9kNQyiXikKB7kLd9yG1b+YYvuYsK1S2EA+tcm+4i1EITxrJKpl9zusvlYK2Yp7KDaaSQpPnYpOoR26aWc567JFf/uYTNgt6joHraAAvIDMIVu4efuqrjecvyJBX75hPVrfTQ7PguSxb8SXN82N09tUll6NH8/O8ffxsQ7cgf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=cUkP4dKB; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="cUkP4dKB"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367284;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2sfcmiY1kPIis/5wMAS0oN3KA0Tj2tVbF7n/o+i3T6M=;
	b=cUkP4dKBBvSdjwWctzeJ02q/r5zP6CZ0yy1yHkP5zvOsVOcfWn5lmZS3MYBgnfR0t855kx
	bQgBGedbAdf0gLcmOGvPg5NoOz080AkVwLO5Mq4beZjAvAtwljVW1VKZFBO+A2iwCBcLTE
	mCUjl/QrMbPObElny1pXkjxTVedHq3qOwFxeJBhflQn1WT2UyxfuCFet8wHVKbgL3V73Po
	07tjOI46kMRQsBlmCPP76/nxVA5sB7qrsNMA0P4tFMRRL5yq03e9WjWjkEWfWy3eTZhMeQ
	mHwRflA9NX8GUnq2ZFQmz41062Fex2jqtAQpH3UucP08xIZRI8S47pOZ3q0gog==
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
Subject: [RFC PATCH v2 01/22] selinux: supply missing field initializers
Date: Mon, 16 Dec 2024 17:39:59 +0100
Message-ID: <20241216164055.96267-1-cgoettsche@seltendoof.de>
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

Please clang by supplying the missing field initializes:

    security/selinux/selinuxfs.c:2004:21: warning: missing field 'ops' initializer [-Wmissing-field-initializers]
     2004 |                 /* last one */ {""}
          |                                   ^
    ./security/selinux/include/classmap.h:182:9: warning: missing field 'perms' initializer [-Wmissing-field-initializers]
      182 |         { NULL }
          |                ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/classmap.h | 2 +-
 security/selinux/selinuxfs.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 2bc20135324a..03e82477dce9 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -179,7 +179,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "anon_inode", { COMMON_FILE_PERMS, NULL } },
 	{ "io_uring", { "override_creds", "sqpoll", "cmd", NULL } },
 	{ "user_namespace", { "create", NULL } },
-	{ NULL }
+	/* last one */ { NULL, {} }
 };
 
 #ifdef __KERNEL__ /* avoid this check when building host programs */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 1efb9a57d181..47480eb2189b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2001,7 +2001,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
-		/* last one */ {""}
+		/* last one */ {"", NULL, 0}
 	};
 
 	ret = selinux_fs_info_create(sb);
-- 
2.45.2

