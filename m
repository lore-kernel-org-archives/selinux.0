Received: from mx208.easyname.com (mx208.easyname.com [212.232.28.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD263C9EC2
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.232.28.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147603; cv=none; b=gm4uRx+Da12cHP6KS4LRaNxYZtlE9HdBU/WB6qVshjqknfh1ZCcwOzQXwc/EhScmZS6SvWwfN4i/wbztxQLy4v2RzLELfgntEhcX+vyD6ZXb0ZQ39hipyqRfLleJY05t9r+YD9Arol59T9tNwUL69qEJaZJBOyIdIF6h/OAHANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147603; c=relaxed/simple;
	bh=9rIZZvD02gb8nNZIPRROzt5V7Hrrp/5J/qvJuXCcK34=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HMpOUG5ld+otkNe8FTx5F1TRwlKdei0v657GYK5KdNWdSIL1Rj2tXc3TerCkR9KuHvdSLYmS/xFdDYDHQ/1zNuP9sA44QPhrO4M/Hzje9DfOIobdNlf24+LT3IhpjoOwmG9nndk4RDLgtjSqs0X8S4wCGpro9Ykr2vOFbdlmvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peppergray.xyz; spf=pass smtp.mailfrom=peppergray.xyz; dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b=fhtWBTH8; dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b=fhtWBTH8; arc=none smtp.client-ip=212.232.28.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peppergray.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peppergray.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b="fhtWBTH8";
	dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b="fhtWBTH8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=peppergray.xyz; s=easyname; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C1aqUt2See6Uubnkpn4b8q/hVW9vr322xuK3554LsEE=; b=fhtWBTH8v54w+aZwfM9MvhlAKV
	HK0Fx1yYLvy5JokcoSIGPKLQQHiavK5T1p5R0Mn/JD4iK4mfk0Bt3OI2r0Bfrh/kfREWCvqPfHJuj
	bD6aUpCMzSV0T82yK/yxWHl3aCVf/rC13XtesmylGp1sovaYhIT89mYZgEpy8KsvP1O60mLt8AjDK
	xYJedTgALcKbyPYcUUNd6IK1oV7utiCxyCrop/8NbcD5hnf9wyZ2gh6+1NPjriRhfyuDfUFZAU2kr
	Yb5qipWERgejLMNt3lTYA7VJxcpQ3yX8AUitPfaFvAptki7sSQouTiF5kIUMfr8YI/Sy2Djti+rnL
	MVJwKoog==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=peppergray.xyz; s=easyname; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C1aqUt2See6Uubnkpn4b8q/hVW9vr322xuK3554LsEE=; b=fhtWBTH8v54w+aZwfM9MvhlAKV
	HK0Fx1yYLvy5JokcoSIGPKLQQHiavK5T1p5R0Mn/JD4iK4mfk0Bt3OI2r0Bfrh/kfREWCvqPfHJuj
	bD6aUpCMzSV0T82yK/yxWHl3aCVf/rC13XtesmylGp1sovaYhIT89mYZgEpy8KsvP1O60mLt8AjDK
	xYJedTgALcKbyPYcUUNd6IK1oV7utiCxyCrop/8NbcD5hnf9wyZ2gh6+1NPjriRhfyuDfUFZAU2kr
	Yb5qipWERgejLMNt3lTYA7VJxcpQ3yX8AUitPfaFvAptki7sSQouTiF5kIUMfr8YI/Sy2Djti+rnL
	MVJwKoog==;
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by mx.easyname.com with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <hello@peppergray.xyz>)
	id 1wKvPx-000G7j-5J
	for selinux@vger.kernel.org; Thu, 07 May 2026 09:53:17 +0000
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67b7c77865dso940757a12.2
        for <selinux@vger.kernel.org>; Thu, 07 May 2026 02:53:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8wCwmQBjBVhPG5SeGtZd47QFjnrm5B+nB7p9OhWtZsifI9Cte
	S4tQ8QHQCHBx8m4v8o1/ksxwjCZZ1mhMYMZXejUh9SJJKEYuJgjpLIXsSbCo/HaWWVD9956IjS5
	sowoYE4CPO/ppHYisTTq1owwTINA7QrIVNva2W8yNKA==
X-Received: by 2002:a05:6402:5411:b0:67b:89f5:26c7 with SMTP id
 4fb4d7f45d1cf-67d64c902a0mr3595359a12.26.1778147595348; Thu, 07 May 2026
 02:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pepper Gray <hello@peppergray.xyz>
Date: Thu, 7 May 2026 11:53:03 +0200
X-Gmail-Original-Message-ID: <CAHLDejy7Urrh6kgENDCW1h7b2+e=JmPMMJWt_pwUrqu-k04ovg@mail.gmail.com>
X-Gm-Features: AVHnY4JNMySj6iz83oTztn_vLcNWDDZzffa_MZPzVEbrObqPa--iCAyyeoreGZI
Message-ID: <CAHLDejy7Urrh6kgENDCW1h7b2+e=JmPMMJWt_pwUrqu-k04ovg@mail.gmail.com>
Subject: [PATCH] add test for fts_* availability
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From c2753a08fae66de4cdab9bd95bbccabcf36b11a5 Mon Sep 17 00:00:00 2001
From: Pepper Gray <hello@peppergray.xyz>
Date: Sat, 11 Apr 2026 17:52:24 +0200
Subject: [PATCH] add test for fts_* availability

check if fts libs are-builtin (glibc) or add -flts
to use standalone fts (musl)

fix: #514
Signed-off-by: Pepper Gray <hello@peppergray.xyz>
---
 Makefile                | 6 ++++++
 libselinux/src/Makefile | 3 ---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 972d5525ff..5c181ab5fb 100644
--- a/Makefile
+++ b/Makefile
@@ -25,6 +25,12 @@ else
  -fno-common
 endif

+# check for fts_* availability
+H := \#
+ifneq (yes,$(shell printf '${H}include <fts.h>\nint main(void){return
fts_close(0);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS)
-Werror=implicit-function-declaration -x c -o /dev/null - >/dev/null
2>&1 && echo yes))
+export FTS_LDLIBS := -lfts
+endif
+
 ifneq ($(DESTDIR),)
  LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
  LIBSEPOLA ?= $(LIBDIR)/libsepol.a
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 0dbba7f47a..4eae890c87 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -99,9 +99,6 @@ override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
 LD_SONAME_FLAGS=-install_name,$(LIBSO)
 endif

-# override with -lfts when building on Musl libc to use fts-standalone
-FTS_LDLIBS ?=
-
 override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)

 # check for strlcpy(3) availability
