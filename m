Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133821F03C2
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257586; cv=none; b=SvVp7vaUPhXk8DZFHYfccP796LgHn9sUrJWCh+mhvQkN55B0D+Op+Ze+BN4l5LtSRiYiXuL/KsLg7RGNOgzQUQlZpydvEQnTt1aZJ+SpqyaWPq9cjwkpkO07WFH0bFQgI8r51gLbY9brxkDCyZSstpLeYV92oyTxMjdtRF5DjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257586; c=relaxed/simple;
	bh=N9IJmBkn3nfPsuDmmuOLlzze6wEECvmAbP6D7O4cn18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dw/YYfFH8iPQYVUCSbfC5P59ru4V0kTkrfgIWHKFjujs87OAOPr0W8NdOEcsevIvGDrZqiZ3qtFMdKm1o2UCmbNT30eJHNNy8ULwJ6FYBE9J+qttvRUUq4XEcnN4gd2P2q/9R9oGcp3YbNzmimQaTB/vob+2D/jqr7Nj47R+uFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=lt6GuZ6r; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="lt6GuZ6r"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257574;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFz9Uq3lDPnvKhXlYcpeT8kw62E/5Ik2BLrolGzg0IE=;
	b=lt6GuZ6rUzkzpQfTl8D0FbeBMY3N/Cvd3CX5ycM9fNPrHQzDvZScNUwA9gDFmEj8SxnTVL
	Jj/NzRGFbdAdoZIie1eUis6BCwsaIfS41HjG8X3WsrGU9qyZYsUXlxBryGHkTTyHsabTRb
	gq725qHS3j1A+dBTEgPuDTaS1S2cPq+yktdoOo6PzPr9O2jI8ALEUBb3rWc7B/iWEzBIB+
	a03b7+t1fNwkyFW5q0umNuaRliGQRq7I+TEg04pbLMDXKH0JoXv+OWxPMs78/0+lcGSJg4
	VnkOWTH4Kt7hx9dUD1WRxXUoVHR9abG3OwGZxFsMgWxXBfEMSP/I1hq7AbA5UA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 10/17] tests/tun_tap: skip if not supported
Date: Tue,  7 Jan 2025 14:45:58 +0100
Message-ID: <20250107134606.37260-10-cgoettsche@seltendoof.de>
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
2.47.1

