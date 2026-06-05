Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8805233F597
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680146; cv=none; b=Ffx2pazNbnlqSRapLZ4AkHkMUj1FPdCVjhZvtQUEm169hskhX4+8yMbeK83NhQv1WOEet/G4qscGQ+b7+aQ22TtMDDIpZxHFlDz+c0zHgsA95kuyakumJy6W3L6mLT03E6Q4vnRR9uMWXyBi/RU0yYa9mWaCzC51m/CNppR4T3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680146; c=relaxed/simple;
	bh=1phwkplxIAiA3Jv53WNVhZHOhebk8ZLGA2GwbeAhFI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nT/HSjpksi8F5AL9zpOXPDcgoswzEG+fjgWvkUPThAB2mHjCCF1SuVIWvPXZPohV90+/cpBGvMt5hjmKa0GY63zumL7gvhfw40gOsaz/zIJ6iopFQV4QPpcwv6Vy2DCmUJHA4+s5QBqI8RIOe/qHDjwtZDEHGomq5/psOBZI8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=heGfbtEM; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="heGfbtEM"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780680144;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0yk+UhFd1zSjad9Ch/hHIhoXd7/+QTO1kq5PnlIWJI=;
	b=heGfbtEMiQPqfOLqL1efTxKKfmOXfmE4m5pMJy+jFj5rnLey/dQGj3eY7fYt+Ml9sxVaHD
	LaSQSVOTrb2Bi41uSk47vuzheFa94Vq4aD2UCmkboxsJA7cAJt33sFd4gg3dlkflG7wFWR
	kPPYTEeAej7S3IvPZ/yW4Rryt9cGv6AXqRszOfAjzNS3R4WkSSV/MXEqKRoVSONO2C8UCT
	8gYRoQmVp9nGGhLpGJ/8NFQ5WgVng8ojMT7zR9hGdZYqgG5P9XGtkF43HzNlEdqBUW8FAl
	O8fXdyjkfEQQosr9xKJV4j7MXWg74NnMJG+9YxqkzzqE0acLy9IfS1bxnNDXbA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 05/11] policycoreutils: drop unused macros
Date: Fri,  5 Jun 2026 19:22:00 +0200
Message-ID: <20260605172207.222382-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-1-cgoettsche@seltendoof.de>
References: <20260605172207.222382-1-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/run_init/run_init.c | 1 -
 policycoreutils/setfiles/setfiles.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index 2cf5bb7b..f304c4f3 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -235,7 +235,6 @@ static int authenticate_via_shadow_passwd(const struct passwd *p_passwd_line)
  */
 static int authenticate_user(void)
 {
-#define INITLEN 255
 	struct passwd *p_passwd_line; /* struct derived from passwd file line */
 	uid_t uid;
 
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 1ab59ee2..9016db5f 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -21,8 +21,6 @@ static int null_terminated;
 static int request_digest;
 static struct restore_opts r_opts;
 
-#define STAT_BLOCK_SIZE 1
-
 #define SETFILES "setfiles"
 #define RESTORECON "restorecon"
 static int iamrestorecon;
-- 
2.53.0

