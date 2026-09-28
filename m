Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7663A4E9C09
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611118; cv=none; b=i2heo8ChXYkdzo+etJpxmYRyPXsG8h8KZ7dXNWzl0vLNTppllceI6By5tutmKcz/xeMdAWMdD8SUHUMUWvq2bdnc2/m6qU2g4MpEDizVDjIu1mK/GF/ZakG5m6vOWhH1HpG0RvUyWtFU+PZbkyOXKUU0EF2adnVWZjj0FlGAk9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611118; c=relaxed/simple;
	bh=8PMaGHWqOm8RYPc194ruMZqZWHY/7L5XDzKr3uZ4YXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1ZChIh9AO3wVpLt4kkLxsROTt3phaB0GMNzg1nG8+ktGmFUgdJl70OLEqbMLHUZ3xFZdZrqiOM4ZbORMyo7zjxbBlYh2YgUlnkpdrATq+M2QKKAzsWA/WMKvWJ/3IEfUcQ0BiDl3gcEgx12Za/68mxk/NadM8frd2STowa7Ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=gwo62KH+; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="gwo62KH+"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611104;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8z16C3Hk6nEsPDwpeHHiNOLQSyYhqINb2CQdWBmpjo=;
	b=gwo62KH+zjZA08niamlvhU42b0KZlCO/EoCzY1Xk2c4KC5a13CnoxwEXu1TjDSA4sBxcCq
	O9pJ2sybRXicEWlWt0PMxccc7I4deVNe19QCWHRou+Z4/y9i29j/djEB1L6AaY5D4e0kE3
	0OHYWXddHs8zlU8JofWFUGWAlRkKOVqdRFg4ZCSNxLAooTpugYZAPp4qe4qDSzIDQI0mBk
	SfOh8ok4JzTOPl6M7aeNdSx3qLRz6Om5ssOyurc7Vt2DAHyldm6Ijhj47DzmWlR5Y/XFGP
	uloQlDfOuuKihABrnWGJ/4xnW42KflX9QkCNGAPJKqTZ0G32/lbGkM45XsR+FA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 18/21] tests/filesystem: improve fsnotify check and preload loop module
Date: Mon, 28 Sep 2026 17:57:49 +0200
Message-ID: <20260928155753.2259807-17-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
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
index ff6daec..115144e 100644
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
index 56f116a..1525199 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -182,6 +182,9 @@ ok( $result >> 8 eq 13 );
 
 system("rm -rf $basedir/mntpoint 2>/dev/null");
 
+# Preload module
+system("modprobe loop 2>/dev/null");
+
 ############### Test Basic Mount/Unmount ##########################
 mk_mntpoint_1($private_path);
 
-- 
2.55.0

