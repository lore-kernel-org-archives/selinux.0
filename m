Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968530;
	b=lv6QRMTzoi9OT8Hq9UKf73aQ3VqxssmmS2OK8SaqnV3MgRz+mQ/QbNutkobRFfiPJMUo
	 04W+ZFM0amVKsbRHU7hdJuyp1QqU9F6DRVzEJwFLrCVxEh/jWqki3svvisa9NqWTF0RSM
	 wZWszHlpB8bGj/nH0qJowCpmBfdmZTcAr6vgghHTU6NOo1X5GndX+cMmXTBDs+5zRCOQY
	 6wJl5z2K+tPrBxrzcSn7tyoXKx3epDDEgurkG8hjg09Svw90qMnoOox/h3LZODMXLaY64
	 J+sCd+b15c3PmmCl5xS2RrIuMSCopjqfkTvsh4Qi8rDSgY9j/bNe9C6jZUkLejAhmrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968530;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aqljU3Zaw6W63sTecOsGoxDlHA5VUn1LEJUaoozp3OE=;
	b=V0tpRyjCcrmYLnye94cbo7EnEQh0N5B84otjMurI7uMgOXZCila1+UjkO0gNBckihKfR
	 UXrR2mhJ3mNnyGM6W2325BhlE7N0Bdsm+zfZXKLHtCOthowQrC7OqbpVMKcBXT+INO6p1
	 QyY2NzPWRRtHPp5zZ9fmr1wu4cK+7ULrNL4n9EORNEFq1DedrKgMbRKWKGfN+M5UP5OrA
	 5u6xn+aFYw89tQR7LIwVOAplIZILM64KvuoqXLzoztBgjJQovPUGbRsEq7xJqyHlwzL8i
	 qMqPjND0kR8nin9wWvSVSHvT8l/ZrAIQ2sNjeAjmMleQZIpnc9yjoX3yjXawntEtOpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=adb1SKYO;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B9C606A339
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60B9C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=adb1SKYO
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968526;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqljU3Zaw6W63sTecOsGoxDlHA5VUn1LEJUaoozp3OE=;
	b=adb1SKYORCFXySKAeLoF7L4Y/F/mcDtKnVS1IkQ3clgFndTiETDTPSncXpLeeHomy8xeP9
	SqntNrt9QxQRZFFbGm22q94Kuc3YrFiiTDTzMaanvUpGLwXaLP4WlrsGxqDXaiXYtC5eYB
	8IVI0G/xz8svf8mn98rC2QJiaoyq2q9GMJrbLE0c1ID7ObUrF2fzU/OuMkI68eLDvmYP5f
	mP9sT09g5WCUhoPCsVUI3RnnvsY2woJv8vSicen9TcDq+YGKyQHgdsAwRSLIPOrofW2ejj
	u6+dsY/Y/6XuaRyhCnyZjCIu/tqEGcj+Qbs9QMF5n1uDd7NIYeb2CsOXKrGJ8w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 13/16] policycoreutils/hll/pp: report output write failures
Date: Fri,  6 Nov 2026 13:35:06 +0100
Message-ID: <20261106123510.76727-12-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-1-cgoettsche@seltendoof.de>
References: <20261106123510.76727-1-cgoettsche@seltendoof.de>
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

pp writes the CIL through stdio and closes the output without checking
for errors. Write errors of buffered output only surface when the
stream is flushed, so a conversion to a full disk succeeds silently:

    pp module.pp > /dev/full    # exits 0

libsemanage treats the exit status as a successfully converted module.

Flush and close the output explicitly and fail on errors.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/hll/pp/pp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 08d2c56d..dd6974b0 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -155,6 +155,22 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	/* write errors of buffered output only surface when flushing */
+	if (fflush(out) != 0 || ferror(out)) {
+		log_err("Failed to write %s: %s", ofile ? ofile : "stdout",
+			strerror(errno));
+		rc = -1;
+		goto exit;
+	}
+	if (fclose(out) != 0) {
+		out = NULL;
+		log_err("Failed to close %s: %s", ofile ? ofile : "stdout",
+			strerror(errno));
+		rc = -1;
+		goto exit;
+	}
+	out = NULL;
+
 exit:
 	if (in != NULL) {
 		fclose(in);
-- 
2.55.0

