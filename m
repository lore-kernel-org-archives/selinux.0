Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FA11C174E
	for <selinux@vger.kernel.org>; Fri, 31 Jan 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738346589; cv=none; b=hGuzBziafbzMK2M7vJbh5E6KXxL+0JVbi+/0weAEXp9CqcrydsGTGcqSH1lWo5eSSJ188owFVyWupE4bWSIMADxAaXaaMlzGKMfA1mV2B30uLWoIfh9EpYs/24gl+mRfl1CnBANTZRKK3iF5QLjtHbZFXp2ZKA+HzYmdKjzT9u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738346589; c=relaxed/simple;
	bh=EFloP0hXZ9hWdaEZ2q028NNJdpuCQKEbrGwecCr6/is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdR/6XhyY1R27oYql0Mswi12CBRuTBVnNRsqimYqf6P0vfapgRh56/M4fJQuJiS9DVpTpCilqPcNRA0OXaGFEJzQnrfuEmhr7EeF0g9aoGlgIdgSB77t/6nxD9hilPov68ev4ibo3XJgvhz+9UvuefToyBwMNRsJ79NPGpr7ZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=BO/QihhZ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="BO/QihhZ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1738346161;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FbAa6sbcddsM+zDfU5IZNXedZa+5xN2UzAhbdYND3w=;
	b=BO/QihhZKKnk7Q/020v4k9YXW0anZ6y3y778nJoRK8zovGpFdJClhVy1c803fYD+vEKWQc
	cDnlmwQNubK8o3PFsecJWn0498/zQGMwsEzMH/1wUwV9bL/2yvfr9aD4tWm/JGewtgJme3
	YfbasqPbuweYvHYH3rIqbNUoVUDWepWti35QiAqpxFmoYL6wcbLEYoYRz/ZYrcp6ewcAL6
	e5iQR4TnfZ24KfDCJTUN+V4Qd2S74RgqiQjlKZwDdipDyBgXsRHvdR+i91/wB3ITQlF82o
	tiNAxyhMMiHOakYZwd+5Mk3F47/K1LZ+xsVEYkmL+beqHfXdVpum4Ya/Tt8GLw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/4] libselinux: initialize regex arch string in a thread safe way
Date: Fri, 31 Jan 2025 18:55:55 +0100
Message-ID: <20250131175556.21836-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250131175556.21836-1-cgoettsche@seltendoof.de>
References: <20250131175556.21836-1-cgoettsche@seltendoof.de>
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

Synchronize the initialization of the regex architecture string.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/regex.c | 46 ++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 182c8c89..976f00d4 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -30,32 +30,38 @@
 #endif
 
 #ifdef USE_PCRE2
-char const *regex_arch_string(void)
+static pthread_once_t once = PTHREAD_ONCE_INIT;
+static char arch_string_buffer[32];
+
+static void regex_arch_string_init(void)
 {
-	static char arch_string_buffer[32];
-	static char const *arch_string = "";
-	char const *endianness = NULL;
+	char const *endianness;
 	int rc;
 
-	if (arch_string[0] == '\0') {
-		if (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
-			endianness = "el";
-		else if (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
-			endianness = "eb";
+	if (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
+		endianness = "el";
+	else if (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
+		endianness = "eb";
+	else {
+		arch_string_buffer[0] = '\0';
+		return;
+	}
 
-		if (!endianness)
-			return NULL;
+	rc = snprintf(arch_string_buffer, sizeof(arch_string_buffer),
+			"%zu-%zu-%s", sizeof(void *),
+			sizeof(REGEX_ARCH_SIZE_T),
+			endianness);
+	if (rc < 0 || (size_t)rc >= sizeof(arch_string_buffer)) {
+		arch_string_buffer[0] = '\0';
+		return;
+	}
+}
 
-		rc = snprintf(arch_string_buffer, sizeof(arch_string_buffer),
-				"%zu-%zu-%s", sizeof(void *),
-				sizeof(REGEX_ARCH_SIZE_T),
-				endianness);
-		if (rc < 0)
-			abort();
+const char *regex_arch_string(void)
+{
+	__selinux_once(once, regex_arch_string_init);
 
-		arch_string = &arch_string_buffer[0];
-	}
-	return arch_string;
+	return arch_string_buffer[0] != '\0' ? arch_string_buffer : NULL;
 }
 
 struct regex_data {
-- 
2.45.2

