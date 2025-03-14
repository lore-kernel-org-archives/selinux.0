Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99BC1FA272
	for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957870; cv=none; b=RlqIpuCDkR0WMfNFYnl+VY6E3+N5Tjem71rWMV0aea6kWxuOqnmOcchVFb0u7MW4zM5FfbucIO+PSaTRqGgY6Q1PoWT26FfiGVR5ztlSP//j8WXzVfx9EB4XvFjQ8xAoDUnh7FMoePiIcbkQVxn2ahylA2pO80XuhSRT7HInV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957870; c=relaxed/simple;
	bh=8Hfhx2JUKrPhHF9vHW43Vvc57gwq/r7NMIp3YKIgezk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6hHiOUdN70PR1N7cG3LRyYE3uM4fZF2bm8XyR0aZOaSd1zPJSt9DqZhFb18napixalYqSeGaz7OjY6lsiWdS6Tg7SeYVFsrS5IjITFpb/ZPbsdbSv2+6aME9ylo+YlKJVSBfMXivq9MwcHr9rgUNqDBMZqWYOU8ONO3wn3PepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=n7UCfGBV; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="n7UCfGBV"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1741957859;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szv4YABbw/t+AMOe0EiF0RtQgjdHHBMeww+FDjrFywY=;
	b=n7UCfGBV76FBUA9riQKXDOnzY7XEj1MxYiEQ8hDykkiSeiAF2M6pPZLxQA79XfhgRePd+7
	0iqXLYjmYXlqLnC4bhWSZiwPy4KjDYhir/1qXpslGfP7mvlY3H+1CwENOiCOGDfM84Zk9P
	PLEhXMr0qgkfaVfz94qdjRHHiAlTLAOeQ2x89xNhZJFdD2jMGkvO/NpEjA2xnGuo/ldrjL
	yg3gKWVTuKMpuuzT9TsmjMHa6GNr3gWXC77ehveerG5VJ7MHdluaHjgIAufK3caKkxxs2k
	8BmhF6i3yWpoQ1/8QmRgj0enEvbUCeNRzxhHv/IEAViasNQpY3QIO5W0J/AsLw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 1/4] libselinux: constify global strings
Date: Fri, 14 Mar 2025 14:10:54 +0100
Message-ID: <20250314131054.24450-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250314131054.24450-1-cgoettsche@seltendoof.de>
References: <20250314131054.24450-1-cgoettsche@seltendoof.de>
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

Declare the read-only encode table const.
Drop the only once used global variable selinux_rootpath.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/compute_create.c | 2 +-
 libselinux/src/selinux_config.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
index d19baa0b..ff8553bc 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -33,7 +33,7 @@ static int object_name_encode(const char *objname, char *buffer, size_t buflen)
 				return -1;
 			buffer[offset++] = '+';
 		} else {
-			static const char *table = "0123456789ABCDEF";
+			static const char *const table = "0123456789ABCDEF";
 			int	l = (code & 0x0f);
 			int	h = (code & 0xf0) >> 4;
 
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 1d8cfb71..75db14ba 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -153,7 +153,6 @@ static int setpolicytype(const char *type)
 }
 
 static char *selinux_policyroot = NULL;
-static const char *selinux_rootpath = SELINUXDIR;
 
 static void init_selinux_config(void)
 {
@@ -312,7 +311,7 @@ int selinux_set_policy_root(const char *path)
 
 const char *selinux_path(void)
 {
-	return selinux_rootpath;
+	return SELINUXDIR;
 }
 
 
-- 
2.47.2

