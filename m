Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116519A288;
	Fri, 15 May 2026 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875335; cv=none; b=ommyJyPcwnajQuncvzFtkQogVd91szNPgMT5OgUfP6u7GeEvpRZ1Bt+4iy9pBBRBoNrYF2ra0oKAvYS7GxB+P3UnFXOvw0VCsqPraV3srrZaE8Jdw3E2b5kpJHksnnNC7q8z3AiKZrfJKAM4bRTDfekzt/LL229tVCqprhNcmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875335; c=relaxed/simple;
	bh=Rb6Re5XXGSVpjq5abJW6t/uPfs7Ii+RJ1l+ubL8Zhg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdG3E4Yi43WoJqh3mKAnPzVU0wyOfXumF7NjEDBLp1KzbKTj9/lnuAEcLSx3SO5WyQRDZqoaWd/lpyA5Qgo1hLqccxdmCNcx51HiKltsrsh2blSTTiuJTPJLrP1rsOlhIC8fNQVzlptTV8J4Uh3SvN2ic2uljCgyEwYRumdBiSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq6sEwcO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq6sEwcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F70EC2BCB0;
	Fri, 15 May 2026 20:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875335;
	bh=Rb6Re5XXGSVpjq5abJW6t/uPfs7Ii+RJ1l+ubL8Zhg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bq6sEwcO59n/2G5Yad0NdnsDkQi5W7l7x0B/u+QW5eq9AOWyZxdGI85gRHRYWhbqT
	 z+mwJ0xDU6GPaNnMQG80cj98kCg2vTyHJ+AAVBTXTPL2VDbFoopPyZr+MkWi40g1X4
	 5lRKKHXbq9d+YU1S78bYkNxz66yggFs2kRAHiblXNPYbowYU1nogEGEi7v487pTSDB
	 6fsIm4IiPGJVsbnqGWZs9nVQcs7wvk2xOfJ02alVUIgwJgo673r6jZP0wmYsa86pVs
	 KvBBJaMFQZsPKSYrrnErUG3pLYrjXjs1SNOaWikcWKYPX+5YjeXkgBEeGDLyRyAo76
	 BOLW4W5B+P4mw==
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
Subject: [PATCH v4 2/7] apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount
Date: Fri, 15 May 2026 13:01:53 -0700
Message-ID: <20260515200158.4081915-3-song@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515200158.4081915-1-song@kernel.org>
References: <20260515200158.4081915-1-song@kernel.org>
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

