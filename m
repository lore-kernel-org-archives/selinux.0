Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F112E1DC
	for <selinux@vger.kernel.org>; Sun, 23 Jun 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719145583; cv=none; b=ZLw2KE+kFox8TISABeNofUU2NNp5yRqqKgkmeLY4Pmeee2wJ5RAfOpZpYQ/zTTVaks/gAODZsuHUy88fkCeKw4FM5P8oJYpFx8hLf6tHST/r+1o1rFH2+5GRqrz5tMqC75yYe/pcW4bDqD5RAxaLuDyfzC2JkEFe67zuxqOkO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719145583; c=relaxed/simple;
	bh=L4R4/uvGlChDcJnFRqKQ1ynyq95KHUWFmZmN2vXJFpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sOPaqSgqQ02Hzy4xWbnPQObAY9fS98LlgI77OMVJBhbKLzZmhki9a03UVi/eeC6R7Zm6OTPTIEq3p1ne50UrtHdg9zyHF7sacOC+u4+kYry4F4Am7GJsv3MIXJp7ibJAFKVRbwlxQKsEPNEdZrvZhKIa8BJYD85e4URtMPnx1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=l+aIQtFf; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="l+aIQtFf"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1719145569;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0TLtK2nt5cKQwii06p6piNdZZMOtOQWMEgA5LeQZ1RU=;
	b=l+aIQtFfVXNRPEuVszUnphtV551Iwi9avHysJh4Wmq83OMHTTm3RfIkd3quYcLvuVJSEK8
	qtxI1BywHq2aVpmzsAQAc/ayGpfNBVp6A0XpKB/taKOQEv435ENYHmLYnbJMCNQJu0SwxU
	Dd1Dyczogl18UdBj+YG0BncKwx/wVybSK+5gGbht8EtyrJuyaTWmohXM30yM59c8wl1I8f
	8KH5gRavEaK3NivBEkjnOglp0nlsHODYbbruZV2QuPPO1AsbOxH8ptfuXnmR07b/vJAqcN
	/Q3BaOvz0ysXTJZFBZHpg2jhfdvnzVvIPi8IUC6yHV9+O8RCR8s0iE5R+3SZsQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2] libselinux: deprecate security_disable(3)
Date: Sun, 23 Jun 2024 14:26:04 +0200
Message-ID: <20240623122604.34890-1-cgoettsche@seltendoof.de>
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

The runtime disable functionality has been removed in Linux 6.4.  Thus
security_disable(3) will no longer work on these kernels.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   Ignore deprecation warning by the internal usage of
   security_disable(3) in load_policy(8).
---
 libselinux/include/selinux/selinux.h   |  6 +++++-
 libselinux/man/man3/security_disable.3 |  3 ++-
 libselinux/src/load_policy.c           |  2 ++
 libselinux/src/selinux_internal.h      | 18 ++++++++++++++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 61c1422b..1318a66a 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -367,7 +367,11 @@ extern int security_deny_unknown(void);
 /* Get the checkreqprot value */
 extern int security_get_checkreqprot(void);
 
-/* Disable SELinux at runtime (must be done prior to initial policy load). */
+/* Disable SELinux at runtime (must be done prior to initial policy load).
+   Unsupported since Linux 6.4. */
+#ifdef __GNUC__
+__attribute__ ((deprecated))
+#endif
 extern int security_disable(void);
 
 /* Get the policy version number. */
diff --git a/libselinux/man/man3/security_disable.3 b/libselinux/man/man3/security_disable.3
index 072923ce..5ad8b778 100644
--- a/libselinux/man/man3/security_disable.3
+++ b/libselinux/man/man3/security_disable.3
@@ -14,7 +14,8 @@ disables the SELinux kernel code, unregisters selinuxfs from
 and then unmounts
 .IR /sys/fs/selinux .
 .sp
-This function can only be called at runtime and prior to the initial policy
+This function is only supported on Linux 6.3 and earlier, and can only be
+called at runtime and prior to the initial policy
 load. After the initial policy load, the SELinux kernel code cannot be disabled,
 but only placed in "permissive" mode by using
 .BR security_setenforce(3).
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 57d7aaef..dc1e4b6e 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -326,7 +326,9 @@ int selinux_init_load_policy(int *enforce)
 
 	if (seconfig == -1) {
 		/* Runtime disable of SELinux. */
+		IGNORE_DEPRECATED_DECLARATION_BEGIN
 		rc = security_disable();
+		IGNORE_DEPRECATED_DECLARATION_END
 		if (rc == 0) {
 			/* Successfully disabled, so umount selinuxfs too. */
 			umount(selinux_mnt);
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index b134808e..450a42c2 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -113,4 +113,22 @@ void *reallocarray(void *ptr, size_t nmemb, size_t size);
 #define ignore_unsigned_overflow_
 #endif
 
+/* Ignore usage of deprecated declaration */
+#ifdef __clang__
+#define IGNORE_DEPRECATED_DECLARATION_BEGIN \
+	_Pragma("clang diagnostic push") \
+	_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
+#define IGNORE_DEPRECATED_DECLARATION_END \
+	_Pragma("clang diagnostic pop")
+#elif defined __GNUC__
+#define IGNORE_DEPRECATED_DECLARATION_BEGIN \
+	_Pragma("GCC diagnostic push") \
+	_Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
+#define IGNORE_DEPRECATED_DECLARATION_END \
+	_Pragma("GCC diagnostic pop")
+#else
+#define IGNORE_DEPRECATED_DECLARATION_BEGIN
+#define IGNORE_DEPRECATED_DECLARATION_END
+#endif
+
 #endif /* SELINUX_INTERNAL_H_ */
-- 
2.45.2

