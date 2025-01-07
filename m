Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5401F0E37
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257586; cv=none; b=rs1Eb8ckhfTxPtcIgIcbraNDWT5wAjMV10JETRhq68PMP2Ubx+y66px91RMhqYBPjPL+WF4yIIKPTGhirqZMjg46/86ADau/fn8q9kw49fQ8CYtf19ESwIZj0EIiIoc43MpdP1t7TewPFqRcb7buBBCczkDqqOTGJwhQQOGZmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257586; c=relaxed/simple;
	bh=AteADW5Gqu++tV3O5jmD6virmufRtt/pAHds9qvWvjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScD1ZXKVU/wgC8yvxrOH/hKp9t4kj8FF7vV8l51zgTpNPgShQwqFFCUuMcmMqf3qWEiJ5C0ch568rmkhTVi5GqPcNbjXY299kwr4nhfm0PjesbjCVGzv447OLP2AfLZP0ddjRQvxbvV25LxFl3nL5oQt4FNeGNwnpG5bBVffe0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=uR0Moysu; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="uR0Moysu"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257573;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXFoif/F6eXyFTpi7lsFq2UGlxsvaOn1j+D2/ugLuyk=;
	b=uR0MoysuVkPDkqK+/Im22q5OkN5NwQkcikNuV4/dll8gSeSARjSOYErtOgnACt1jCYhSrI
	8tgJ1l7CraIXN4ga7Vq2AwYIPAUQqtPhRJncscmr2X1RWwMJWk5KLErkFjPYVPUFQP8Iqa
	zlZPWwokVQGJ/cFi8QyjDAw02NUXwDPonHaYCtf9YWoklWxTVr/TXfqV6qNEzVIV/pVXsu
	Q9PJ6d+8sFqP+siNw6tT48Yshpi7JXz2MEBPm1zINSA/y6dNgcfOQpNWHH7wep0boN5XxY
	ec7xuDxcs582L4wQPx76tpt7YcBOORgu+nrKpJOmfGg01HgCSALaQD29C90hlw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 07/17] test: overlayfs related tweaks
Date: Tue,  7 Jan 2025 14:45:55 +0100
Message-ID: <20250107134606.37260-7-cgoettsche@seltendoof.de>
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

OverlayFS does not support a couple of ioctl's and other features, like
NFS, so skip and tweak relevant tests.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: fix support for NFS, by using FS_IOC_GETFLAGS only on FIGETBZ
    failure
---
 tests/capable_sys/test     |  2 +-
 tests/ioctl/test_ioctl.c   | 16 +++++++++++++---
 tests/ioctl/test_noioctl.c | 11 +++++++++--
 tests/overlay/test         |  7 ++++---
 4 files changed, 27 insertions(+), 9 deletions(-)

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
index 9bf732d..a68c4e0 100644
--- a/tests/ioctl/test_ioctl.c
+++ b/tests/ioctl/test_ioctl.c
@@ -27,11 +27,21 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	/* This one should hit the FILE__GETATTR or FILE__IOCTL test */
+	/*
+	 * This one should hit the FILE__GETATTR or FILE__IOCTL test.
+	 * FIGETBSZ is not available on overlayfs,
+	 * and FS_IOC_GETFLAGS is not available on NFS.
+	 */
 	rc = ioctl(fd, FIGETBSZ, &val);
 	if( rc < 0 ) {
-		perror("test_ioctl:FIGETBSZ");
-		exit(1);
+		if(errno == EINVAL) {
+			rc = ioctl(fd, FS_IOC_GETFLAGS, &val);
+		}
+
+		if( rc < 0 ) {
+			perror("test_ioctl:FIGETBSZ/FS_IOC_GETFLAGS");
+			exit(1);
+		}
 	}
 
 	/* This one should hit the FILE__IOCTL test */
diff --git a/tests/ioctl/test_noioctl.c b/tests/ioctl/test_noioctl.c
index ea9f120..f8cac63 100644
--- a/tests/ioctl/test_noioctl.c
+++ b/tests/ioctl/test_noioctl.c
@@ -43,10 +43,17 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	/* This one should hit the FILE__IOCTL or FILE__GETATTR test and fail. */
+	/*
+	 * This one should hit the FILE__GETATTR or FILE__IOCTL test.
+	 * FIGETBSZ is not available on overlayfs,
+	 * and FS_IOC_GETFLAGS is not available on NFS.
+	 */
 	rc = ioctl(fd, FIGETBSZ, &val);
+	if( rc == -1 && errno == EINVAL ) {
+		rc = ioctl(fd, FS_IOC_GETFLAGS, &val);
+	}
 	if( rc == 0 ) {
-		printf("test_noioctl:FIGETBSZ");
+		printf("test_ioctl:FIGETBSZ/FS_IOC_GETFLAGS");
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
2.47.1

