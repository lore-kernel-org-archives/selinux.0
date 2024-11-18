Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31AB1C1F37
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942197; cv=none; b=NJ+IJtpTISXqTo3WCF3XLhNcM154ynr58xRSFBV/sLrEsFCQ10cfsal2us2JjsI2tE540nlRsh+6ptV9ZTDm9yP9Hq6/AJqOwWB0uYdaatdsrvEeS/X0fRXUMFLXRrSG2mc8UmJqzr4EHuPF4g89R9YgiKgkdXjK0dCEkaNei1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942197; c=relaxed/simple;
	bh=M5wVKuHBrGr812ut/qyxtniOT6QxwmVEZipXmMTKKqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L19kUMsACosQPH1nQn5gpGW18/iJQchgynnGSiCUxKbf2MAeD264Amu6a0yX6IYbXjhJZt+ALmSSH4Y5l9kVcG7VWWXndg2/OOIlugcgTT9Bxe3w2HhZf93e4Lb97nVMYQ1ZxZvJ0prqzH+wC4as8tuHDNeX7tTeaj4VBB7pgBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=DF9Ds2hb; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="DF9Ds2hb"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bzOx7Nnpr7CVMCBMAfokORsD3C2E8LRw7oes6P+zc4=;
	b=DF9Ds2hbop753a6/hNpKiP+7325lSb1XmKFyoWZX84zlsvu8MiL5eeYKRM7cIdUEkR23Kx
	HO1cKH0rCpR0ZGtlsW8aFkLtCyPoUHhhHXV16Na8Ddt3P5+BTdvfJcrDLfB32MjMwnUHtZ
	0ESIqzVkxkR9xH6K0hiIN5I90unnuwTucp6nATA1GbsDYWWKMRLRz+iQ9M5Xo2xQ6szY/J
	lwl27zUd3Fcgrv2aVvEKKXcmhnNB0fXjlG7+MOqUFzjw/AVlPuJtwPvs3imUBVyyiXPmao
	xsj1iT8Q9/hymz2xMBwS7Fu2y6EFKE4ebsvQd5s3M0m/YgLr7u2mdHYHsX1kAw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 10/17] tests/tun_tap: skip if not supported
Date: Mon, 18 Nov 2024 16:02:32 +0100
Message-ID: <20241118150256.135432-11-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/tun_tap/test         | 10 +++++++++-
 tests/tun_tap/tun_common.c |  2 +-
 tests/tun_tap/tun_tap.c    | 10 +++++++---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tests/tun_tap/test b/tests/tun_tap/test
index 3daf2eb..87956c5 100755
--- a/tests/tun_tap/test
+++ b/tests/tun_tap/test
@@ -16,7 +16,15 @@ BEGIN {
         $v = " ";
     }
 
-    plan tests => 14;
+    $result = system("runcon -t test_tun_tap_t $basedir/tun_tap $v -c 2>&1");
+
+    # check for TUN/TAP support - ENOENT
+    if ( $result >> 8 eq 2 ) {
+        plan skip_all => "No TUN/TAP support";
+    }
+    else {
+        plan tests => 14;
+    }
 }
 
 ############ Test tun_socket TUN #############
diff --git a/tests/tun_tap/tun_common.c b/tests/tun_tap/tun_common.c
index 9a3c5de..86e41df 100644
--- a/tests/tun_tap/tun_common.c
+++ b/tests/tun_tap/tun_common.c
@@ -5,7 +5,7 @@ int open_dev(int *fd, char *test_str, bool verbose)
 	char *tun_dev = "/dev/net/tun";
 
 	*fd = open(tun_dev, O_RDWR);
-	if (fd < 0) {
+	if (*fd < 0) {
 		fprintf(stderr, "Failed to open device: %s\n",
 			strerror(errno));
 		return errno;
diff --git a/tests/tun_tap/tun_tap.c b/tests/tun_tap/tun_tap.c
index a3db6c9..c1b8590 100644
--- a/tests/tun_tap/tun_tap.c
+++ b/tests/tun_tap/tun_tap.c
@@ -5,6 +5,7 @@ static void print_usage(char *progname)
 	fprintf(stderr,
 		"usage:  %s [-p] [-s ] [-v]\n"
 		"Where:\n\t"
+		"-c  Check if TUN/TAP features are available.\n\t"
 		"-p  Test TAP driver, default is TUN driver.\n\t"
 		"-s  If -v, then show TUN/TAP Features.\n\t"
 		"-v  Print information.\n", progname);
@@ -16,14 +17,17 @@ int main(int argc, char *argv[])
 	char *context, *test_str;
 	int opt, result, fd, bit, count, test;
 	unsigned int features, f_switch;
-	bool verbose = false, show = false;
+	bool verbose = false, show = false, check = false;
 	struct ifreq ifr;
 
 	test = IFF_TUN;
 	test_str = "TUN";
 
-	while ((opt = getopt(argc, argv, "psv")) != -1) {
+	while ((opt = getopt(argc, argv, "cpsv")) != -1) {
 		switch (opt) {
+		case 'c':
+			check = true;
+			break;
 		case 'p':
 			test = IFF_TAP;
 			test_str = "TAP";
@@ -52,7 +56,7 @@ int main(int argc, char *argv[])
 
 	/* Start TUN/TAP */
 	result = open_dev(&fd, test_str, verbose);
-	if (result != 0)
+	if (check || result != 0)
 		exit(result);
 
 	if (verbose && show) {
-- 
2.45.2

