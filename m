Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE033AEF24
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132452; cv=none; b=RlLX9r3Ka5DEEmI9w5pogNgmYxklV5HVnT+nYOaSAn00RgQwBvBVBMwmMBC/P6rwL47MnbeALEYCGDtaMTxT/ak6WM7z0ZMsZU3SDuYSrpeZ4j7g05tZNnIpqy7VyG0Ph7yB2js+qK8Zw8RyApxmOj6/76udOHoRhL5KFdmO0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132452; c=relaxed/simple;
	bh=Ioz7B4FaQHe7gGJcmcCkAD8dWyKPn5yxEd/BMEmuCIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKjTFw9yirqvFilw0xps/d1oHJVlj5odWte+cH+MC+fjYcOBVqgExiMyC5Y5sp4kB2Rxivkf231clv3qwJ9jqxOYb3BT/vfDt0lBblOJRAK6SMWL2WPvXVhDGb+2raJ8gKRv6P341DnfXACpnzoEPqOWH2dt1kFwt52e+RNxm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwJSWi2v; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwJSWi2v"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5b048375so376372185a.1
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132450; x=1784737250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FFAKsszcbEu9WBmU7F4De8HjXr80x5PUnJIpfhdTtAA=;
        b=lwJSWi2vP6n4j0I6HdIW9EbSdNIbwAcUKxXd9Ga4cMrlSpagn93Li7vngjhrpc8KWR
         5AWlPssefwxXwp7gKU3A8dpHwzHofvKMT9EH6NtJ7+Mt4XFrbUlODfuUDVI/hxsiGFUp
         E+QR4+YYWY8DCpNi9mdMP2zenVv1JCeS4abLBV8U4UztDoXrjtDgn+EqgqXHHNLd3Mbf
         5CwrPG6Z4C8G5huLZB3NAwVMWJhWrpuVd5VMXN2ZDI0L1jzxTutZThNh4uUYTqM/RmvL
         iA1BY4lfDhz9eVsvbPxL5tQqRKf/Na8Nv6HtMZcEzUoms013+ufg0negKtY2Q8E5BZIG
         wzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132450; x=1784737250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FFAKsszcbEu9WBmU7F4De8HjXr80x5PUnJIpfhdTtAA=;
        b=dUjCiDYNNMIvIa+KWFmmPlE/ES4hsgeTKQaTZBZJUGA834sycsmjDuCcPAexgSZ9eo
         L19t02B7mIROuoXHddcup9MXUO+V4DB64lk8zR3yYL+hq2rK9Gg42t+FyvU5n2dCvkaM
         oX6sopa1bIrpzMCveDIM46XaG/14m3akYjLuT5TBtmTq/JDh7+F4DOOGa9wHcb/eepAE
         XJPi7NliBD0ymT8qd00LvoFbHRN+sxZR/H+deUrcRGcMo2CCpO+adfHFYiidhnlkxcFY
         W06ycFJZTqfWTs/pNcto5twEclzbR4szFYUu6g5zLUG5xFFwNynd6meUQjcd+R2tf7pI
         P5Fw==
X-Gm-Message-State: AOJu0Yy5+Le8sBK/HRkYPM7w904Ox9rHuOsogsxBL8XnxOuLOPAT+Brs
	d5tPCJM6KlXlve4mcBPmCuWjsTf4cLUM2EsXSpLnCLgISsgqnPtgbrMYBq9GgA==
X-Gm-Gg: AfdE7cmqGBT2NXrALdBtHZcvyYnx/flpC8RKPBSEaAKMXNxmbvS/pM+F5YUPND2qH1O
	Z+lyVEnOPKUbK7PU0V/+zzL+3KjUsXrBGb1omzir2ovoOQH6+s1sNcBMxQmEwF702eDap1uuVhF
	EHA7J3uxwqEhWulExR8C5Y4elaS0R0eZ58PT6kDVWapT2lGi5lE5lmDGYD86dEkuMwGDcvBxWwn
	vizD6DtwRtxGmQQGVC3q6yfqiZ2BTLJ6lRbSLy748YE67TocRIOQkN9YMkx3BymVBmUtYu6twZi
	Jqke58OWheseOHqAC7JKKEkTImQDiWbZemWn1+fq1RkZlA8qixgdzYK83+n5bncJc26r87VrTz1
	n8jA5ugmnWcJVyJgmxuMJDS7KzM/fPqKyq8cjjk/mqUYQwrN100euPDvrPOtdM3WQ7gAANgTo4u
	LYjJbxmPqbkTGKUdE6mErj9ec2aL9FAJ9NY16asEoH//tcW0TaH7dTSYabgEx/FDsRDvyRXSY/1
	Obz0C108vOhq+1w
X-Received: by 2002:a05:620a:4146:b0:92b:67e6:4b66 with SMTP id af79cd13be357-93086bf69aemr774170485a.61.1784132449950;
        Wed, 15 Jul 2026 09:20:49 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1694855485a.30.2026.07.15.09.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:20:49 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 01/10] sandbox/seunshare: free glob on error path
Date: Wed, 15 Jul 2026 12:20:27 -0400
Message-ID: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Free the glob on the error path for a failed calloc.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index f2d637e1..0c32d03f 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -448,6 +448,7 @@ static int rsynccmd(const char *src, const char *dst, char ***cmd)
 	*cmd = calloc(3 + fglob.gl_pathc + 2, sizeof(char *));
 	if (!*cmd) {
 		fprintf(stderr, _("Out of memory\n"));
+		globfree(&fglob);
 		return -1;
 	}
 
-- 
2.55.0

