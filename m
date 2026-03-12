Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6892240DFD6
	for <selinux@vger.kernel.org>; Thu, 12 Mar 2026 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328173; cv=pass; b=RoihQPfCDikOyPtaEIWZhEQHD8OnDe0Nu6/0z+GXYGU18f0VPJwBhLgZT9D13UbQUWZT43TxlnWtr1X1yMvGImy8T2O1kKgV43k7AOqUnf0XwxdDZseaZyTnMeyURnA+f21AO28YEGuiwytRXe8jNZr1HOhpcEytvc+f1f0pKd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328173; c=relaxed/simple;
	bh=7FQQHCjByofd5/MX36aFSmjbnQu/gSTx/QyT1hmWoOM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WS4HlG4TK6lXBabLQFxO3dy4jH52b/tLJCpMbAKBLmkKiIS6H3OfP6joSiPnYk/WLzjQBErXQVpT7TG+rNT7CuIsjWoKNFC6YoV6T1HElOX6dhh/hbda1IjVisfuIvZVsJzudqldtgnKXgcsbN+Fisqc1y7AA8UWs0q9AiXAK/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chainguard.dev; spf=pass smtp.mailfrom=chainguard.dev; dkim=pass (2048-bit key) header.d=chainguard.dev header.i=@chainguard.dev header.b=mSs1lm5o; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chainguard.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chainguard.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chainguard.dev header.i=@chainguard.dev header.b="mSs1lm5o"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b78b638eso1274200f8f.2
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2026 08:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773328169; cv=none;
        d=google.com; s=arc-20240605;
        b=jvkGoyS3F9H/Vl6W5yFumwlBlBUbQkhOhHlKteI9GMQ7CotRfwQeqZrFAu2YrVhIcu
         V3N9/VA9fNdSUDXwA0nNrmbxLG3qafj2VDKgOqe+cqxKfwthKOQQoymwfSF8H6Ibv/1S
         lJKHOHlBMVyQAVV2brIIruWzS2lUE4+9sTL8rIf6Mdast4r93Xh2bGJyh+15zK/hJUVd
         bMM9nfoxWbIA5eRCRxgPu2DBF6X4BB5dGBIIZOoFIR6WJ0+bBbReFpksxt3ELWOHvuYh
         VTq7b2rZYcFdQZMF/2i0JVyXZXhAIPQYAuli10FdWLO0Io4ixarzierSwMD08Vn5ZKjh
         5PRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=EdiZQRteYxohgiGUThUqqj3QM6HlCa11w1Yyiez9PAI=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=Znl7p5I7V8X92BhbSWBU2fSjFcs619i7aw3TeiBa5b0vwZxjFSF+wLtLgIRTSEu9+M
         T72w1hrtrdiX+7RguwgbcDuRx/8+hXkQtSAhhZ0xDlc3XpHbtkPpMIZWLQeKueTpKYl3
         yd2rXs9TX685V5a3y9NkncYI6t5EPd/YfPgoht1oPL+DO9vqgHqdFfVsNEgT5+lam2hs
         qpt/DN4QB59OOJ9HmZKSg/j/3wsANhj+9BQd6BJBuSiEmC9st3+xC72t3ZSN0DaB+Un8
         +d6CS9Ha8AyDCCMKTm5WbKWd6kZt624x6P/PFGCyhF4lUfl2r832oXDWTlpsNHjqiyiw
         EIUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chainguard.dev; s=google; t=1773328169; x=1773932969; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EdiZQRteYxohgiGUThUqqj3QM6HlCa11w1Yyiez9PAI=;
        b=mSs1lm5o7FStBO2PK9kilJo30xP9t+gPV/GN/v9Mg1q+R9/AuER+JoXe6YONbnv9Az
         56PanTzL6ynoPcQa6KRFcmTobQTG8zXFmuzKJtQ6w4ZCzFUbkf9iUcX7tL6qYQ9VMaw+
         d5Kp7lV5AYhO2Cxa4cUgHIQG8cu/wl0Ved4oymrkkMc/gynRaVaegKGxXd8hT0We4RiQ
         MuAZZMc6a7KVUpwXKt/Ib+fALEkMmLZN/luDfj8Wl4TQS2A+13pcKFp76mqIS06V0vio
         0NtyuUX3NLMsOvrF5v3YN/75VPom2ziJlxvGVQC37ITK3U1PdgQzvoOxi7Rc56XkPrJy
         644A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773328169; x=1773932969;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdiZQRteYxohgiGUThUqqj3QM6HlCa11w1Yyiez9PAI=;
        b=EZOn2KTgly5TyAp4vBzq1g+0jJROaFKWoz3wFBLilaBSQTNpQMFzuyTcThvlZkSZth
         Buo47QFPyjCcC4hk5P7k4SSbqyefZuq5kZIHU6u9l9tpcfBGg/Jl34UgkIyw9D7W+M+u
         bPPvBO0HJhvYFGP74ZpNHhHtViRmjXuOF+bmu5h28bSQ5XBvydvY23bSTkOmiGcXwIL8
         V0pJGcx+2Wb9Rq2eI+vu+T4xvWVlpyKVuucanTukFP1x/KzyUYn1w5L5QsYyyB2S3RpQ
         G19r2PHnExsfFpQ/TUZLQ4ENYpbf+zMrRcWn1TEkrp0O4hx1P+oy5sPfnBd/1p/Ukp+k
         MQtQ==
X-Gm-Message-State: AOJu0YzlMJzy3n0TgOSWDMrLXU34KZa1LGFJzw/EWt7huDzy35blxj+i
	vtMvzFJRXPDZdpj5OpUxh8yGrP/CVLS0rz/FSA5Z992KdTZTX/8jeD+skes1tKdl7ScbwUn4QyJ
	j/RiFcX54l6BC4jisODtgvKTTlcB3MHOHWrSnLKZJPxPdP9lSv2dVQWw=
X-Gm-Gg: ATEYQzwjFmBUkOUJYX6BxQn4v/Yi9bzIr4xb+xm0EjtUi4Xgd+TKPQhcCSxiYVck9Qh
	fhRuvim7slCNcqBiL3krNQ6V0ANcJW1120ZxQtPnTW8Y6UN/s/WeMi7Copw9znJ90xvzHePJ7Kx
	zKhuBJTJpFfxNwoIc3ZAT5QM9xd8Zc9nU+0Vxivt/bANZjf5quKYdNo2oitzQ9iIXqDkOD2r+oy
	H3Qw9umMdKtrQ68ZRdpRW74JH119XrerW7bLJYhx4HzknpsvVLU1H5p3Xhcs1XP4r+aC4PnJ9B2
	qsqik7k=
X-Received: by 2002:a05:6000:288c:b0:439:c1f4:302a with SMTP id
 ffacd0b85a97d-43a04d79f6cmr91357f8f.11.1773328169338; Thu, 12 Mar 2026
 08:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dustin Kirkland <dustin.kirkland@chainguard.dev>
Date: Thu, 12 Mar 2026 10:08:53 -0500
X-Gm-Features: AaiRm52Pxxfd51xWhSdZyl9PpXmGgx6tcdr6oFMQ0nzpDfzcuaanDcdvkCF3oZI
Message-ID: <CAC-oOXP04oBE7ciLr7eZBx857uw8sQm6u5v1DpjwYzfzY8vvVA@mail.gmail.com>
Subject: [PATCH] policycoreutils/secon: fix discarded-qualifiers warning with
 glibc 2.43
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

https://github.com/SELinuxProject/selinux/pull/507

In my_getXcon_raw(), ptr is declared as const char * but is
assigned from fgets(), which returns char *. With glibc 2.43,
strchr(const char *, int) now correctly returns const char *
(matching the constness of its input), so the subsequent assignment
to char *tmp triggers a build failure:

secon.c: In function 'my_getXcon_raw':
secon.c:365:18: error: initialization discards 'const' qualifier from
pointer target type [-Werror=discarded-qualifiers]
  365 |         char *tmp = strchr(ptr, '\n');
      |                     ^~~~~~
This breaks builds on any system with glibc 2.43+ and gcc with
-Werror (which the SELinux Makefile uses).

Fix
The const on ptr was always incorrect:

fgets() returns char * (a mutable pointer into buf, which is
char[4096])
The result of strchr() through ptr is immediately used mutably:
*tmp = 0
Remove the erroneous const qualifier from ptr.

Relation to issue #506
This is the same class of bug reported in #506
(libselinux/src/selinux_config.c:284). That issue covers
strrchr() in selinux_set_policy_root(); this patch covers
strchr() in my_getXcon_raw() in policycoreutils/secon/secon.c.

Both instances have the same root cause: a local variable was
unnecessarily const-qualified, which glibc 2.43's strengthened
strchr/strrchr const-propagation now correctly rejects.

Testing
Verified by building policycoreutils version 3.10 against glibc 2.43
on a Wolfi-based system (Chainguard) where this was a build failure.

Signed-off-by: Dustin Kirkland dustin.kirkland@chainguard.dev

From fe074290a6eff8f12345350ea2938bb0e5e5bc5a Mon Sep 17 00:00:00 2001
From: Dustin Kirkland <dustin.kirkland@chainguard.dev>
Date: Thu, 12 Mar 2026 09:55:17 -0500
Subject: [PATCH] policycoreutils/secon: fix discarded-qualifiers warning with
 glibc 2.43

In my_getXcon_raw(), ptr is declared as const char * but is assigned
from fgets(), which returns char *. With glibc 2.43, strchr(const char
*, int) now returns const char *, so the subsequent assignment to
char *tmp triggers:

  secon.c:365:18: error: initialization discards 'const' qualifier
  from pointer target type [-Werror=discarded-qualifiers]

The const on ptr was always incorrect: fgets() returns a mutable
pointer into buf (a char[4096]), and the result of strchr() through
ptr is written to via *tmp = 0. Remove the erroneous const.

This is the same class of bug reported in issue #506
(libselinux/src/selinux_config.c:284). The fix here is analogous:
the variable should not have been const-qualified in the first place.

Signed-off-by: Dustin Kirkland <dustin.kirkland@chainguard.dev>
---
 policycoreutils/secon/secon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index d624fa136f..9a05cf1959 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -348,7 +348,7 @@ static int my_getXcon_raw(pid_t pid, char  **con,
const char *val)
 {
  char buf[4096];
  FILE *fp = NULL;
- const char *ptr = NULL;
+ char *ptr = NULL;

  snprintf(buf, sizeof(buf), "%s/%ld/attr/%s", "/proc", (long int)pid,
  val);
