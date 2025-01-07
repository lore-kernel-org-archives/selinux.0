Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230821F0E20
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257587; cv=none; b=BGs3HQFB6dFVUrjII4GhNLCmJLeqXp2v2FCf8w+2w+ClM1Q3wP99cfuI3X45D/H90cfo57kDff+R69yeaZi2wzpwyI9tIKNxksnXDw3JYHtgu/idq99IHiuL5s1RyT0Hg+K5uMcZl6g51vPAZFTIbIgSaiJJUOlW/I+cP5zSEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257587; c=relaxed/simple;
	bh=e5ZuGC72oFzMvSgy1qKb6QI+qPupvXxtmhOCH6Rli9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCKqmqkTm4hLq02LrpKTOmfwCafozzXyKy4Zt6/2HGfSQ4w7MO00xPAD6pnHGXiZc2viZL0Ad4FzA7lggi50NSc53/5SrZzO2XbLji0MnaaGRNxkq3ZOaUrQYqehTb35QnvAOnifFf69gYhoMuJg7wvW5B/ZKRklwyjGHXgiYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=pbFijOSX; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="pbFijOSX"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257575;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nC9Qa2vMKF4MHk570KCB7wjtI+pwpSP+Ldg3tti1WsA=;
	b=pbFijOSXb7kuv8qo1X4KxPdG0Wv28fFwZDFk9BSh7/NdN8gzqv+zIjOclbjzrEmJ+zaiQA
	xp37FliUDuY4ZGWawh2X3tAhiJW7IqHbZRNMRuy3mKUtAh/gBgkvUMDiKv7a5wzXiebxB5
	i5aLE6TaQY7K5u/+HAyijPiDW5Hjg8DXTU3N1oXUuubNGDjmvV9666IQInPztXYN2x3TXM
	oRZH++DYV7t7KeppmjFZoRjvRhxLuVI0pgkeqjpMFVpiYqZB6f/Q7/juVo610HI4NBSquq
	cqnfCVStz4P3kjSe4taAaLriIl5TQwba7/7900tkHGthAzrfZCr+6bIv31Y9eg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 12/17] tests/filesystem: improve fsnotify check and preload loop module
Date: Tue,  7 Jan 2025 14:46:00 +0100
Message-ID: <20250107134606.37260-12-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
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

fsnotify support might be missing from the running kernel.

Pre-load the loop module to ensure creating a loop device succeeds.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/filesystem/Filesystem.pm | 2 +-
 tests/filesystem/test          | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index f169464..ab5db31 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -15,7 +15,7 @@ sub check_config {
     $watch         = 0;
 
     $result = `$base/../kvercmp $kvercur $kverminstream`;
-    if ( $result > 0 && -e $fanotify_fs ) {
+    if ( $result > 0 && -e $fanotify_fs && -d "/proc/sys/fs/fanotify/" ) {
         $watch = 1;
         $tst_count += 11;
     }
diff --git a/tests/filesystem/test b/tests/filesystem/test
index a7d8b24..c12fed2 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -176,6 +176,9 @@ ok( $result >> 8 eq 13 );
 
 system("rm -rf $basedir/mntpoint 2>/dev/null");
 
+# Preload module
+system("modprobe loop 2>/dev/null");
+
 ############### Test Basic Mount/Unmount ##########################
 mk_mntpoint_1($private_path);
 
-- 
2.47.1

