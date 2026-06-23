Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552337A49D
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222152; cv=none; b=pGA4ITHHek3L6MDmBPihkxC9Haj6AcGXrymLWhvFKWo+odeLE7b1JiFpMUeAhYSF+QLaYTWz8gauZnr+jtCKzF5lrMUnJ/pqdfTaidiSnRFpsdrJP3INuxAUaC1e4Kw/29uxSnSBMcgTjo9l+dKaJmOp55y8lGePd+kmfO658rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222152; c=relaxed/simple;
	bh=ENHRf4YuzYSs9NpM8SwuMzbVKhtowapyhb726a7Ozms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwCd+kOZReTvqFbMG+TuBFtMq3S/caxHt2Y+DismEhiMUlvYLil80brLqgLodj2pSHsbtmCxxSBnM/K4FocLpWWD81ZP1Ie5x1OQX+nufHdNZofqYsKEma19Hn8Hyoqt4JKDS2USReFEA8uJHaj36JBYQcECljcb4FhRVLVC7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=JN0dKshp; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="JN0dKshp"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222150;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eH1cpAj6sycjTqEJAt/7lASJ4UKf/veP9QfZ+LVbQe0=;
	b=JN0dKshpA/KsBqBu3ZvRh4Kyne9eqMZk6ywuuw/FH6tjX93PR1M0Nh9h2LYYC4f/sv0cU7
	yurynto2g672wBkYLpMGhPOLWMegVgftSLxWLpg4Qs6TgDACz6NIbUn1V6O4vsN417naoH
	8E2okq/uxSJTKmpRwD/oEw0EZfsmFRZb6HZcLjfbC35evb+A8wA5YyZcvvLu36TQfWqMpa
	F/LhMY4Jip+IrmmsKRcE/Fh1xlZSxumgezEyU0kp+4sUH+QhkszQ7lUOYwqoW/NH/NQSps
	/CLrbBk1naWVB+FM5pbJv8xm5iDrDsjZO4SKo1Tf3eUmCkLa/1KlcQoI+GxAfg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 03/24] libselinux: strip only a trailing newline in type lookups
Date: Tue, 23 Jun 2026 15:41:52 +0200
Message-ID: <20260623134215.98273-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

find_default_type() and customizable_init() dropped the last byte of
every buffer unconditionally; a final line without a trailing newline
lost a real character of the type name. Test for '\n' before stripping.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/get_default_type.c     | 2 +-
 libselinux/src/is_customizable_type.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_default_type.c
index 6a09ca22..f689b4dd 100644
--- a/libselinux/src/get_default_type.c
+++ b/libselinux/src/get_default_type.c
@@ -38,7 +38,7 @@ static int find_default_type(FILE *fp, const char *role, char **type)
 			errno = EINVAL;
 			return -1;
 		}
-		if (buf[0] && buf[strlen(buf) - 1])
+		if (buf[0] && buf[strlen(buf) - 1] == '\n')
 			buf[strlen(buf) - 1] = '\0';
 
 		ptr = buf;
diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_customizable_type.c
index 4eac6cad..124ee38c 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -44,7 +44,7 @@ static void customizable_init(void)
 			i = 0;
 			while (fgets_unlocked(buf, selinux_page_size, fp) &&
 			       i < ctr) {
-				if (buf[0])
+				if (buf[0] && buf[strlen(buf) - 1] == '\n')
 					buf[strlen(buf) - 1] = '\0';
 				list[i] = strdup(buf);
 				if (!list[i]) {
-- 
2.53.0

