Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5751FA272
	for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958279; cv=none; b=fgT/HJR9xLaBlogI+ra1tZ6qgeffCrm1m/98IFjUOiS0B6oF3LwE0j3LtCvhv5bQuneWATmifzv4vmOCcxZMIqGvrXBbVGoc2ZCCUDSsob4jyRJO2R+hJDqaVLJo1Rpg7zNCFLKM/tl7sBakHH5sxrSKtY9UXpU4eSF1w662sfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958279; c=relaxed/simple;
	bh=6mJtMCynq3/qFJfbuwBFmL6N1mZMD0UPGwHP82/HUQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaXKXAWoZzXh8pSo3MXTidRKBqNIvm9nPNQ0kp6Nk7dZ0ViZTavsMt8UrZEJJbY5wcbnmfgvJIf0teV2iVHoI5jxVueVjFnHpaHpkw8FPABOcYwi6XRU0NMuv6tiCmr7egUgIYxFFvgtyZd620YUoHXu3ie5AthXN0RedLoSv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=E6mDOeoe; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="E6mDOeoe"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1741958275;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8dcfVRtMjJubp4rsFUjaEOXQkYrlFHgM6nWfwVWiio=;
	b=E6mDOeoeOX6XxHcCLGBW17gdHf+8VAJ7VLAcuAuQvHKLoTTmjGQgYN/viLhim4wFhdkPlw
	NVc5WKE+PnzfLs68pSi8k9NrSXCccX6Z5VoVm5KMYi7+ZSD0+E/0v2FIKxT07EcE5TOE26
	pgN9QDcT4zIdO0ncEVDw+3xRXPvbYJmdx6RdP03HfO9/EWOeATpJsk6eXp9Zz9caCLs690
	nZNVCNiZ6b6gfX/SfIm0tu9U1IvXW7kPHP6HoSYhrSDREvDPsWyKjz6vb0Jn8EmOKu4iGK
	cJMCfBtVju5EZKjIZvgyT8zZTgfG7jpnH3TvkC56B4Xh79GvMv9Ql6ZP9OqJ+Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 3/4] libselinux: initialize regex arch string in a thread safe way
Date: Fri, 14 Mar 2025 14:17:49 +0100
Message-ID: <20250314131751.28289-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250314131751.28289-1-cgoettsche@seltendoof.de>
References: <20250314131751.28289-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
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
2.47.2

