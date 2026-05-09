Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7827E05F;
	Sat,  9 May 2026 01:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291558; cv=none; b=mREofcjrV6qzZfSF2XmzCPL/6MV1JUg/dKq4hvU55pQ5fGlFC8dflXV5dRFmRwCa0nPOYjkmF1Tep9ZPt6fWqQuJHIEx63HumGV7efD2B+DZEZqAvkVdeEBgLqgL4lrxFzJA18lyP2Vgo6LvO84QosbC6c0/kiU3FKnTGSoBqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291558; c=relaxed/simple;
	bh=Rb6Re5XXGSVpjq5abJW6t/uPfs7Ii+RJ1l+ubL8Zhg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAFgTorniiRmeN/ld4I+BNkyXkV1lo/CngJcIL+f2xZP0NcysyoDEPwrZk2ng4zwLeVe846hF5kLKeleVG0XislFcj4VUNHYweE6XLsdSmOP6E/JTKlueqjAVI+N+btwWCXn5rDROI7riwVmgg2i6RxGhatir7JRuivCN/Eor8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5MuVocv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5MuVocv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B08BC2BCF4;
	Sat,  9 May 2026 01:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291558;
	bh=Rb6Re5XXGSVpjq5abJW6t/uPfs7Ii+RJ1l+ubL8Zhg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5MuVocv7kcjs3xH9vfzaqRZUPHvAOEbpV7maUWqij/v4S1oapHeKfmiFbPi/hCj3
	 cDOY66jIpZJyup+sS1TzqKjaUr0AtuJWL9P+abb38PjIiYYnH76IqeFXQ++BPHK0c5
	 /DW8bCRt5h0da8RZeHnRw/Zko55MzRRGE5KMlqdNGBAplynL64pxiyomqHCN9Pn4Jc
	 WrIPEjkUs2xi/nm8OA2q/XgcrrxiZM6jtufiOoRwzV4iyDKWhkbK4KNrnrz23JcEZk
	 T9CqcJeyHrZj+i1Ao3LqVAiHJzcEuQXrevJOcpBTMSbxuqaDmisaKy3o/jmFONhGMR
	 zo3tnz/bfI1gg==
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
Subject: [PATCH v3 2/7] apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount
Date: Fri,  8 May 2026 18:52:03 -0700
Message-ID: <20260509015208.3853132-3-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260509015208.3853132-1-song@kernel.org>
References: <20260509015208.3853132-1-song@kernel.org>
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

