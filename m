Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB8C13D
	for <selinux@vger.kernel.org>; Sat,  8 Jun 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867233; cv=none; b=IRertvZk5mvAsNU4LAE1hQGbSHUw+TVExjIrAFIg6EtbIjoggTeC/vc+R4yGtgF+xf8+PgWc0XNUPFIhfDgGrlWYsF25rUhyMm6EVW6i19hDB2NlGbPykRzsVRxWWJxbFPHSXV9McTZYG0soViyHa8PwncVIBjXTunqFrhxVAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867233; c=relaxed/simple;
	bh=Slql2Q0FSLoJlF63qd+sSRmYLzbmHqU3Q64Lx26rg2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8QIkiPQ5w/UDfE/t0Sh5hc5bsZxjPWyG6Raq0ZYxVXqi9JpA1w8NRwyS3R6snmzWTXKtsaw9nHL7Te46B+DkXkk+pXSSO2ZeHo1wmVYdZ0d3zKomsCZtVnTftdiQ5Gld5HswloZIUo2gLqVfDnKTEHbi1k6IN4bG7LeZEpQSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ZYCEWmrf; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ZYCEWmrf"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1717867228;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=SeOsM/IvsDi9l1MgI2UpIPI57d86HeMzi4sDacOGM5I=;
	b=ZYCEWmrfgve4YYlVIurMZgnXYD08N9KkVpT0Jq01h3aCjLakF4RDFh6jmOHH7+uaEal830
	9uztxLiQ9yXq7YhDeqbHxn5sqC1o+1P2pLRbWIPNZMv/EFJz5FMeKDz4VPoEImawgQwY41
	e/ECqKzl+2JEEjcQIaH3ZlTt/B95NDlYQxr81cwVYEQa+868lwDAOs3U2rgs8iEW+Ye/Pw
	wBg7GE2a2VsRd+vS/nNLoGEmrGZPz5Jv5WE49zK3RN+wrbVUiGv0ptWTtcqNVPg5Pgclnt
	Yi68amlHziWS2xfMv+oyNtWVq7MkQ003CKfQUYSdTIIrR5XTIc0hRdPibIVRvA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] libselinux: deprecate security_disable(3)
Date: Sat,  8 Jun 2024 19:20:24 +0200
Message-ID: <20240608172025.137795-1-cgoettsche@seltendoof.de>
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
 libselinux/include/selinux/selinux.h   | 6 +++++-
 libselinux/man/man3/security_disable.3 | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

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
-- 
2.45.1

