Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687CE408012;
	Thu, 28 May 2026 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992788; cv=none; b=pEe3uCte8nhlqnwqyl70fm0enVktFTJKB3A2Q1HtW6Z+WCbRW9nxX/8a/cH2Qqe+hwRMYDas3hhDdYwnJt7YjY//WQT3NIL4qBUvkNbvl8Dc04ELrBMAZkGPce6S4f1aVL6g5UpwwnpFdcnTzxDD0tqq3nbHwb5+d9hdoLD7e4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992788; c=relaxed/simple;
	bh=Rb6Re5XXGSVpjq5abJW6t/uPfs7Ii+RJ1l+ubL8Zhg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3L43rjT8FPTg/hC4agu1IC48/vUh2gEqHnR2rEmDfPVMjwyXQBIf74oVYOkAPQ76LfAxXBGrw7WXmjskbT4+Nl72KC7ZhMdhr5TCmXHUcGqCHdp8qq2UAqt0/O592x8rWc/q8Amgq7Cst/4QvG0ubgUU9N5P2+DWSv0/Y0f54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwljjZxE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwljjZxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6CD1F00A3A;
	Thu, 28 May 2026 18:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992787;
	bh=tQUTsccM0vl0EIRqxLj70Ya/bncKxKi3jRMN7Wuiz+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kwljjZxENMdNGjbpjrePLdFQNHWorEUdB0TQuqmJmnadUMDs4VOnKa8b4yyoVej1R
	 s1UiQ8ev5pK5qsukOwoPkEPcsWRGaujfL6U8XQ3faE12znqufaZs0Fk2U5qrFLlgLA
	 zE0OddfrylllNciGDi6Cbe8Mg7THVbalbnPUP7HiamlZqA7+CQYBeyAxRQvSKRxN5w
	 aD1YesdvODO2zGfHwULfez4cqTD9LnCXpNygS2G75MpAJiEHDl/YrbDpyR6jZ/U1sH
	 G34bFLWrqetwKT1fQaFu460zM15lQ5pdVrHJ+RznT9qnSQp64cPiK/LJJRu05pVYGA
	 yLAIkYrH77NWA==
From: Song Liu <song@kernel.org>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	john.johansen@canonical.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp,
	herton@canonical.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 2/8] apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount
Date: Thu, 28 May 2026 11:26:01 -0700
Message-ID: <20260528182607.3150386-3-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528182607.3150386-1-song@kernel.org>
References: <20260528182607.3150386-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

path_mount() already strips the magic number from flags before
calling security_sb_mount(), so this check in apparmor_sb_mount()
is a no-op. Remove it.

Code generated with the assistance of Claude, reviewed by human.

Signed-off-by: Song Liu <song@kernel.org>
---
 security/apparmor/lsm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 3491e9f60194..4415bca5889c 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -705,10 +705,6 @@ static int apparmor_sb_mount(const char *dev_name, const struct path *path,
 	int error = 0;
 	bool needput;
 
-	/* Discard magic */
-	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
-		flags &= ~MS_MGC_MSK;
-
 	flags &= ~AA_MS_IGNORE_MASK;
 
 	label = __begin_current_label_crit_section(&needput);
-- 
2.53.0-Meta

