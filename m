Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973127;
	b=zo6JQPHzCnVPqO9AyBdbIosTsjx7uHS6y3xHDPz8cDbgTRoLEZxtM+cktxfjx/xGQWOr
	 BMSvR3i7kR+qlLmpYUXdt2Q2v1TrsWFkuoEQ24smdi6nX+GaKZZ35ikXc8bnDH+qSxQb9
	 Hcz6ByaGxHSDD0tY6gGQwm5nGgiF12DwhPw8SBhi3UTeBkdCMXVJjFZciLM9zlhZuzPcv
	 27FXxJ561kp9lT+ANqHYa1xj5nqHUY/BADz/WQvomP+yWF2Wnt1+0agId3lwaDkD6BRHE
	 ebpdWhxi5Zu9v3zya/PJvERgLvc43cjBWZrqIBfQgPsaMmgNW4xUZP+mSFh/fK4g13Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973127;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZNiqQlgnz/cRgoSBnLZZprVq5YYmNP+Vlj6c6dc4JUM=;
	b=Puj8or9iefnH+i7TUdvUki1HJUyV2KJd9SMj45SU+Qw5XEVh1Kay/19kVSQW5/BPgyKs
	 4TmCSuColNOR8ROrTXgVwiVOxskqLtlfsCUXEqDm3FVAEqezx1dXcRMvFYAO1hj3BSo8k
	 sMsBpRCh86vWnRn8TuvRaZ151WIUwffMugXdJQgyg5x0lw6060tKAbWPhLiNmKe95Jkih
	 vSGdDDYf8E1GOzmXr8iT+JevpwO4ZrEVDhogJEEKjwheMQVDvGwyR+VNE83WiNVfltazU
	 L8z1VQMrWFEzQ9K0gsOqclHbI+V38pBXQWzzyMl4sbveHG9LgnnNiZeUQPTEBJd8T4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=aYOSNSGp;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC1606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 13:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3EC1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=aYOSNSGp
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793973123;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZNiqQlgnz/cRgoSBnLZZprVq5YYmNP+Vlj6c6dc4JUM=;
	b=aYOSNSGp+2s3C6gNiOjNidlCJGlyGSPfXO8ZtbwXuCXfv5gEr8/bxc6gDWkHiupfLJpFpz
	9giLPBRzb+Uw82AZd3Wtk/P5ozhHBntUIyX8kvvGnaygHwVEsg5djPvTed5BAf7jautLgg
	0VnLrtwuvoBYjrYVt94M4XQI7pkUvbSGdP2+vRy54IKBz0knOR/VzP69CP10ii9C/47IWv
	T9whX5egy3YvtgbpCZl/iNZNUpiVLVSYk7J9SC0yrDKyK2EDdYG9Uuav6yvojSuVTQiC5O
	5O/MzqGPnracHf855vea0HsZi+FcsJncUVq36UcFbRrfNcyKtVeoXrPFJacksg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] libsemanage: make the migration import diagnostic distribution-neutral
Date: Fri,  6 Nov 2026 14:51:49 +0100
Message-ID: <20261106135150.377761-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Describe the required Python 3 bindings without naming distribution
packages. Include the original ImportError so missing modules can be
distinguished from failures to load the bindings' shared libraries.

Use sys.exit() rather than the interactive exit() helper on this path.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/utils/semanage_migrate_store | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index c6caf3bf..2fcbc571 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -12,9 +12,10 @@ from optparse import OptionParser
 try:
     import selinux
     import semanage
-except ImportError:
-    print("You must install libselinux-python and libsemanage-python before running this tool", file=sys.stderr)
-    exit(1)
+except ImportError as err:
+    print("Unable to import the Python 3 bindings for libselinux and "
+          "libsemanage: %s" % err, file=sys.stderr)
+    sys.exit(1)
 
 
 def copy_file(src, dst):
-- 
2.55.0

