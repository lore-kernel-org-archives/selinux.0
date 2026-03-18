Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953A3E4C86;
	Wed, 18 Mar 2026 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859458; cv=none; b=mDesF2CykOsumDO7hebYKylWb3p1raxornf74mPDcyA9yyMpQdiZDPTXHTqucXFU683cguL6niX2Qj+Oc6VUoBx9DC/4UmAkht/FUEGde01JPE3CnW4kAu7i7VAheyBx3wmPnaHA95h4ifrTqKOyE9kQcP0YCosd9nxf9Tmmd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859458; c=relaxed/simple;
	bh=l400cWCLuDBOCR8lTcisFzV7+Q3ZIkeL1nnb6/ueNts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMFLfc4YZRHikfhFwyMWDkVtAkH+n7SUpE5r8NxSnxT0gjZ6NNVubL2faELicZCtt1KWpTN5wrFHujj6C08rmmHSgj9SJuvv33JXt0m5ivVoRI9AdlfrT5LUxHMh4xQvpDCdY8NHycm15D/mb9Oe5myRfbJJ+ww2QAerd1giJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBQwON0p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBQwON0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CCDC19421;
	Wed, 18 Mar 2026 18:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859457;
	bh=l400cWCLuDBOCR8lTcisFzV7+Q3ZIkeL1nnb6/ueNts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBQwON0p1YLVRIZggfV64ATzvIHnNf6pekommaSWEk5OTGOvKH7MnlEh1PAhZbmRZ
	 fExCxHaPbSVPCPh5oqURD6js3bCoaK+t75pP1mhmxkVpUcok+VESddupK+1hjZeNUt
	 2qFFHJT5IzXoqO2gL+ppo0FR/MbFpZVSJ2hVIHuislwOd+VhZ7dVEVRa/bWzB6+/5/
	 zGspEu1jikfTUmvvd83dgbCDY4X+/xVLfaPkRqXY/DKATOALoGtQdhvIDFed9cYrKL
	 5HPsLu8rzCKc4nWb8LFJacUg5B44QLuLH+su0zPBDxDqnY6tmI9GORALrCM52/qgMy
	 +oKdnjR2goRWA==
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
Subject: [PATCH 2/7] apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount
Date: Wed, 18 Mar 2026 11:43:55 -0700
Message-ID: <20260318184400.3502908-3-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318184400.3502908-1-song@kernel.org>
References: <20260318184400.3502908-1-song@kernel.org>
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
index c1d42fc72fdb..48a8655af11e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -704,10 +704,6 @@ static int apparmor_sb_mount(const char *dev_name, const struct path *path,
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

