Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CCE1C230E
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942197; cv=none; b=uRKKCV4ebd9MfXiV2Q+pE3axkMvj7upKBqkTsZqfFXiAnuxcio/xlpFsmvdht1clkcN/Gz+akCJMW/aKW86ocpvxvPjyVDGEdE1a8hM79Whjgc2QTJxSTNCzo8euUmrMDZtaFf1krjAOOfmv7P3xHzjH/QbXu2ocL7xG14S6eTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942197; c=relaxed/simple;
	bh=qn66shCH8fMVqd6lI8x2JwAV19hPOKt/jfYDsArJqDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qL2GNMbqwTtvYr502Q775XIrUAyb5ASo7FqJEt2uVfVxURw1i20Xb5bJ2eI5ps2IIbJCymOENDYqkKSd59WJCq9UqKHclUM5NIT3j6A6qt3NDBGglVoX7oHXpxzfd9K2RjSAX222QFSXZogjeE/WbhL1dnaMVoiS/jfNO3cbBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=NB4mlZ8W; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="NB4mlZ8W"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFxMi7KbFK+ca8mjranagTa6Yxcu2vho3L0vM1umt5Y=;
	b=NB4mlZ8WMIC8/mKYAgwMsMfP4vhoVdolisV53330KSoEn6BMvRtDaHcg30z5hzZoAGuUS+
	WwxULkeFfvUI7UIko5mjrGmBx6vznVU7vvp1/qIkSr/fgstsuKzB0HjR7M1uOupOLjbkws
	zy/wrayVbcHxKjGwEmlxLAtgFE95ag+bHcyhvsRhkIZ9H00j6rAKmDpKwyfOzdfBx4BH16
	hA5XV0vpXpgXp9gqFVG2l55MPrvMx5nn3wi4J22eW4/Hqzjt7/kSuDuSGel4rOXzPjPi01
	1Z7mfUZmGn4VuigjsAngmaYsyK0V4YYfjdXx+Mpgouu0pp98lG+ScrVXSE7pRA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 12/17] tests/filesystem: improve fsnotify check and preload loop module
Date: Mon, 18 Nov 2024 16:02:34 +0100
Message-ID: <20241118150256.135432-13-cgoettsche@seltendoof.de>
In-Reply-To: <20241118150256.135432-1-cgoettsche@seltendoof.de>
References: <20241118150256.135432-1-cgoettsche@seltendoof.de>
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
2.45.2

