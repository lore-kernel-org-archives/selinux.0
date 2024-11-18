Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F11C1F1C
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942199; cv=none; b=mpZWBDe6boZ8b5a67XqYqb/0ZDk32vqHIhJknodv6EMOPpjK/e9etNSR+Bxa2OaMTI2gad2wuOaU2O63q6DhruVoBQVCMVJjCA99DVfkMEgzUaOj+z6rcq6m8jgiL0L4L69eHUVwdN+PxesC+DSVgIqpM+VOdhA3jcAxo7dUYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942199; c=relaxed/simple;
	bh=p2c2cDcaMQPFZuADXIo5av4l5xEc86U7ap10uKKMkDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mArwFSigFR6gtDYaplI5pWC7GloBmYyzuvwXVONmVc82/aFce4FtWR7kIbGPzcyJ1wBc36V5jTmSf+21AriJ++n237seNPiUGlUzAZeWGu0zclyPU4g1J1AAiSOkWJgTGwNCKq3EFN1ddxpOawqNU0J2mlxzbe2oDHY+E3qBtDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=oJgTt90K; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="oJgTt90K"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwBBOdeD0i4q9AnuVKoRDX/YDCd5DLJi1IX+Wt8eD9U=;
	b=oJgTt90Kbf7HDoYgRdUFwezdL69JJ+/Gb8rYZAmE1bBJtMVtLPuEK2w6Crt+/qqEhznkjj
	BawPfeWCY8FoWFjq426BvC27GTSiXwNwyIATHKXHZWiX7i+Sx+qmtJv8yZPWjIe9M5RQQ6
	GnniPFqwBdtm7oRYrD+bwmwSyqVH8zrLQ68bk5igk9TugGPTr3+jJ+472B95gg30KQZbJw
	/S6h1Gkl3ouEXPai8Irk1RzF9hDJCMWK4cyjYxk8ARpyWa35dasU0hrd9KgAOpn49XS+vU
	vVlbaPSOLCC/XScOtOKE9UN6AOtMqZJiiEc21siVA1wDCGjo3W04ME5S4nzQuw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 07/17] test: overlayfs related tweaks
Date: Mon, 18 Nov 2024 16:02:29 +0100
Message-ID: <20241118150256.135432-8-cgoettsche@seltendoof.de>
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

OverlayFS does not support a couple of ioctl's and other features, like
NFS, so skip and tweak relevant tests.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/capable_sys/test     | 2 +-
 tests/ioctl/test_ioctl.c   | 4 ++--
 tests/ioctl/test_noioctl.c | 4 ++--
 tests/overlay/test         | 7 ++++---
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tests/capable_sys/test b/tests/capable_sys/test
index 132c732..6fb57a1 100755
--- a/tests/capable_sys/test
+++ b/tests/capable_sys/test
@@ -10,7 +10,7 @@ BEGIN {
     $basedir =~ s|(.*)/[^/]*|$1|;
 
     $fs          = `stat -f --print %T $basedir`;
-    $test_fibmap = ( $fs ne "btrfs" and $fs ne "nfs" );
+    $test_fibmap = ( $fs ne "btrfs" and $fs ne "nfs" and $fs ne "overlayfs" );
 
     $test_count = 7;
     if ($test_fibmap) {
diff --git a/tests/ioctl/test_ioctl.c b/tests/ioctl/test_ioctl.c
index 9bf732d..3ed0695 100644
--- a/tests/ioctl/test_ioctl.c
+++ b/tests/ioctl/test_ioctl.c
@@ -28,9 +28,9 @@ int main(int argc, char **argv)
 	}
 
 	/* This one should hit the FILE__GETATTR or FILE__IOCTL test */
-	rc = ioctl(fd, FIGETBSZ, &val);
+	rc = ioctl(fd, FS_IOC_GETFLAGS, &val);
 	if( rc < 0 ) {
-		perror("test_ioctl:FIGETBSZ");
+		perror("test_ioctl:FS_IOC_GETFLAGS");
 		exit(1);
 	}
 
diff --git a/tests/ioctl/test_noioctl.c b/tests/ioctl/test_noioctl.c
index b72a476..522fef5 100644
--- a/tests/ioctl/test_noioctl.c
+++ b/tests/ioctl/test_noioctl.c
@@ -44,9 +44,9 @@ int main(int argc, char **argv)
 	}
 
 	/* This one should hit the FILE__IOCTL or FILE__GETATTR test and fail. */
-	rc = ioctl(fd, FIGETBSZ, &val);
+	rc = ioctl(fd, FS_IOC_GETFLAGS, &val);
 	if( rc == 0 ) {
-		printf("test_noioctl:FIGETBSZ");
+		printf("test_noioctl:FS_IOC_GETFLAGS");
 		exit(1);
 	}
 
diff --git a/tests/overlay/test b/tests/overlay/test
index c8367dd..744fc9c 100755
--- a/tests/overlay/test
+++ b/tests/overlay/test
@@ -9,14 +9,15 @@ BEGIN {
     chop($seuser);
     $seuser =~ s|^(\w+):.*$|$1|;
 
-    $isnfs = `stat -f --print %T $basedir`;
+    $fs = `stat -f --print %T $basedir`;
 
     # check if kernel supports overlayfs and SELinux labeling
     if ( system("grep -q security_inode_copy_up /proc/kallsyms") ) {
         plan skip_all => "overlayfs not supported with SELinux in this kernel";
     }
-    elsif ( $isnfs eq "nfs" ) {
-        plan skip_all => "overlayfs upperdir not supported on NFS";
+    elsif ( $fs eq "nfs" or $fs eq "overlayfs" ) {
+        plan skip_all =>
+          "overlayfs upperdir not supported on NFS and OverlayFS";
     }
     else {
         plan tests => 119;
-- 
2.45.2

