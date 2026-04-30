Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648DA40DFAE;
	Thu, 30 Apr 2026 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507435; cv=none; b=CPIT5KC9QCSmkc5rKEoFYPzaomkOKNHb7x4QaikF3laL6mHCC5Bt30GXrW/BAieRRJtCNEtWCV4WjMRyDgO+LSVymRMHJJ5lNJXeyJOWkMyFu2cdvPawWRFZsM9sIH9Odm6LfS4Fl7mjfEof4rTRS8k/7BQ8eKkPZiUFKeGVcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507435; c=relaxed/simple;
	bh=/R5+/PxtQNMd/Wp2NSDozPYyHupAuMJV+79tR525jzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dp6/QTo+LgrhFAnkWEGlZpTxoy5g8/SD+ePDyuQ4CIhXVEeLIOcMQMFeURbdtQ4STUHBXMxWVXGV0LxMPe4nqE21dGfy0I5fDgM/k5XihH5K/mF/usJYhOm4skFzIvzAlsm9OF+gGYFOeAOx6DRbuZ5KpcaTrhpds07hB1JrZSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUz2TDf5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUz2TDf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D21FC19425;
	Thu, 30 Apr 2026 00:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777507435;
	bh=/R5+/PxtQNMd/Wp2NSDozPYyHupAuMJV+79tR525jzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUz2TDf5Q/zBsZF/E+T2vY+kPl77uXpNTmk356QwMu1OWhCnKvYPPhfXZmbJloq0Y
	 o8D0CJciLljPT5HUdDI3iQIiOJxiJC5nOTJai/2MTA3SH9aWkoO5CWKta5wIeGEpBZ
	 JAZJrtXuyXfex7vjes+ZrBpRPM+qbHDAKVsQ1yxr1x+mHAmfzlpTks6aBXwaq8pPbP
	 MHspX83R5RTNbYi8q43aVkjf8k1vldLsbk+aFRAnnZwFyZkC5KM6eqS/9CPzE8xFoR
	 q+D2jeVZDwY0I8RJXfxFNIkXzgf5tGatkwepK39sb3/vJjasvQkJs4TPiz6YgIw5lm
	 WwQBoG/9ckQtA==
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
Subject: [PATCH v2 2/7] apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount
Date: Wed, 29 Apr 2026 17:03:10 -0700
Message-ID: <20260430000315.918964-3-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430000315.918964-1-song@kernel.org>
References: <20260430000315.918964-1-song@kernel.org>
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
2.52.0

