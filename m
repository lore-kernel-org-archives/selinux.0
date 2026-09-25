Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E6D3F5BE6
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356748; cv=none; b=MT1bKh+CP0aLrxfa3+8WXx6PxsfbtYoXn22FSmNH67cMm02qpShSkTRqUQ54ygDNKyfUqFq1tetINaBwYWZbZ2gbfT6jYhPSzY2UNtX7DxXbyRF2izb873ks+lVOUCMZwxuIRxKn7qg2oDo9AsO9vriFMM9IfLcm0GotLQ7YIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356748; c=relaxed/simple;
	bh=8PMaGHWqOm8RYPc194ruMZqZWHY/7L5XDzKr3uZ4YXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMQ7lafhDQbleq/apb9uqneOSZiVMSXbeoGH78uqlmsH0Dqtum7uuny0eRRO8t7EJtxhgFkfJr+ddr5aF8DSOaj+6mIG9EX1VZ3LIpJRbTlkBDCQ+aV1WBQpLgQrHEU5vqy1a40Rn0wbh97oz1ALF5ObaZcMSe3GFDMyC3OETnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=stntOBL5; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="stntOBL5"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356714;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8z16C3Hk6nEsPDwpeHHiNOLQSyYhqINb2CQdWBmpjo=;
	b=stntOBL5YnaFVzXqfTj7KkSoBag0OQp9JLhwRjZGHK5xjwQZCwCksFxD8nR2dGDPorZ6Nq
	hv/pzwmrCZhcL4Z29IDLUMQB5ECa+yb5EbCvMU3FdRoPku6R5i9s23F/kUwEwMSOnkpRYe
	Xi3eYdtDvT+anNTFr5UDWY5n/XAAfVyv9rt3QIZd6GWKBg2LtFFBjwVj8x9qjc8QhVuaT1
	TE226Oqz+MPsszg3sxmZ26MKZ6mF6tcqPsQ+zAwsnojo/Fo4MhTLdJfAVGF1+gVlRvee9z
	CQUPPhrpcpTuhCcUCgjrbBzE2BVuaNzC9a8He5LbkE9AA1VaKD0jxLYQQ+8eAA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 18/21] tests/filesystem: improve fsnotify check and preload loop module
Date: Fri, 25 Sep 2026 19:17:50 +0200
Message-ID: <20260925171755.2029271-17-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
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

